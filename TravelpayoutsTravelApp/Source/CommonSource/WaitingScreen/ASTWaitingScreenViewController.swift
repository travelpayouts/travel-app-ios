// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import UIKit
import AviasalesKit
import Appodeal

@objcMembers
class ASTWaitingScreenViewController: JRViewController {

    let presenter: ASTWaitingScreenPresenter

    @IBOutlet weak var planeScene: ASTWaitingScreenPlaneSceneView!

    init(searchInfo: JRSDKSearchInfo, searchSession: JRSearchSession, delegate: JRWaitingScreenDelegate, router: JRRouterProtocol) {
        presenter = ASTWaitingScreenPresenter(searchInfo: searchInfo, searchSession: searchSession, delegate: delegate, router: router)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class func bundleForNib() -> Bundle? {
        return Bundle.main
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        presenter.handleLoad(view: self)
    }
    
    // MARK: - Setup

    func setupViewController() {
        view.backgroundColor = ASTColorScheme.mainBackgroundColor()
        Appodeal.setInterstitialDelegate(self)
    }

    // MARK: - Error

    func showErrorAlert(title: String, message: String, cancel: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancel, style: .cancel) { (_) in
            completion()
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

}

extension ASTWaitingScreenViewController: AppodealInterstitialDelegate {

    func interstitialWillPresent() {
        presenter.handleShowAdvertisement()
    }

    func interstitialDidDismiss() {
        presenter.handleHideAdvertisement()
    }
}

extension ASTWaitingScreenViewController: ASTWaitingScreenViewProtocol {

    func startAnimating() {
        planeScene.startAnimating()
    }

    func update(title: String) {
        navigationItem.title = title
    }

    func showAdvertisement() {
        Appodeal.showAd(.interstitial, rootViewController: self.navigationController ?? self)
    }

    func showError(title: String, message: String, cancel: String) {
        showErrorAlert(title: title, message: message, cancel: cancel) { [weak self] in
            self?.presenter.handleError()
        }
    }

}
