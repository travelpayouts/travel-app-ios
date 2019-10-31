// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import AviasalesKit

protocol ASTWaitingScreenViewProtocol: NSObjectProtocol {

    func startAnimating()
    func update(title: String)
    func showAdvertisement()
    func showError(title: String, message: String, cancel: String)
}

class ASTWaitingScreenPresenter: NSObject {

    private enum SearchState {
        case started
        case succeed
        case failed(Int)
    }

    weak var delegate: JRWaitingScreenDelegate?
    private let router: JRRouterProtocol?
    private let dataModel: JRWaitingDataModel

    weak var view: ASTWaitingScreenViewProtocol?

    private let searchInfo: JRSDKSearchInfo

    private var showErrorAction: (() -> Void)?
    private var canShowError = true {
        didSet {
            if canShowError {
                showErrorAction?()
                showErrorAction = nil
            }
        }
    }

    private var searchState: SearchState = .started

    init(searchInfo: JRSDKSearchInfo, searchSession: JRSearchSession, delegate: JRWaitingScreenDelegate, router: JRRouterProtocol) {
        self.searchInfo = searchInfo
        self.router = router
        self.delegate = delegate

        self.dataModel = JRWaitingDataModel(searchInfo: searchInfo, andSearchSessionParams: searchSession)!

        super.init()

        self.dataModel.delegate = self
    }

    func handleLoad(view: ASTWaitingScreenViewProtocol) {
        self.view = view
        view.showAdvertisement()
        view.update(title: searchInfo.routeString())
        view.startAnimating()
        performSearch()
    }

    func handleShowAdvertisement() {
        canShowError = false
    }

    func handleHideAdvertisement() {
        canShowError = true
    }

    func handleError() {
        router?.openSearchFormOnHomeScreen(with: nil, andSearchSource: .searchForm)
        dataModel.terminateSearch()
    }

}

private extension ASTWaitingScreenPresenter {

    func performSearch() {
        dataModel.startSearchIfNeeded()
    }

    func show(error: NSError) {
        searchState = .failed(error.code)

        let title: String
        let message: String
        let internalCode = error.internalErrorCode() ?? NSNumber(value: error.code)

        switch error.code {
        case JRSDKServerAPIError.searchNoTickets.rawValue:
            title = TemplateAppLocalizations.shared.waitingNoTicketsErrorTitle
            message = TemplateAppLocalizations.shared.waitingNoTicketsErrorMessage
        case JRSDKServerAPIError.connectionFailed.rawValue:
            title = TemplateAppLocalizations.shared.waitingConnectionErrorTitle
            message = String(format: TemplateAppLocalizations.shared.waitingConnectionErrorMessage, internalCode)
        default:
            title = TemplateAppLocalizations.shared.waitingGenericErrorTitle
            message = String(format: TemplateAppLocalizations.shared.waitingGenericErrorMessage, internalCode)
        }

        let showErrorAction: (() -> Void)? = { [weak self] in
            self?.view?.showError(title: title, message: message, cancel: TemplateAppLocalizations.shared.waitingErrorOKButtonTitle)
        }

        if canShowError {
            showErrorAction?()
        } else {
            self.showErrorAction = showErrorAction
        }
    }

}

extension ASTWaitingScreenPresenter: JRWaitingDataModelDelegate {
    func waitingDataModelSearchStarted(_ waitingDataModel: JRWaitingDataModel!) {
        delegate?.waitingScreenSearchStarted(self)
    }

    func waitingDataModelSearchCompleted(_ waitingDataModel: JRWaitingDataModel!, aggregator: JRSearchResultsAggregator!) {
        searchState = .succeed
        delegate?.waitingScreenSearchCompleted(self)
        delegate?.waitingScreen(self, didReceveRegularTicketsWith: aggregator)
    }

    func waitingDataModel(_ waitingDataModel: JRWaitingDataModel!, searchProgressChangedWith bestStrictProposal: JRSDKProposal!, strictTicketsCount: UInt) {
        delegate?.waitingScreen(self, searchProgressChangedWith: bestStrictProposal, strictTicketsCount: strictTicketsCount)
    }

    func waitingDataModel(_ waitingDataModel: JRWaitingDataModel!, searchDidFailWithError error: Error!, aggregator: JRSearchResultsAggregator!) {
        guard let error = error else {
            return
        }
        show(error: error as NSError)
    }

}
