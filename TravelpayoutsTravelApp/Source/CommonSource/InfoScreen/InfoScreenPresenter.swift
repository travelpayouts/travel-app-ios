// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import Foundation
import JRSharedServices
import ASTemplateConfiguration

protocol InfoScreenViewProtocol: AnyObject {
    func set(title: String)
    func set(cellModels: [InfoScreenCellModelProtocol])
    func open(url: URL)
    func showSettingsScreen()
    func sendEmail(address: String)
}

class InfoScreenPresenter {

    private var currencyObserver: NSObjectProtocol?

    weak var view: InfoScreenViewProtocol?

    func attach(_ view: InfoScreenViewProtocol) {
        self.view = view
        view.set(title: TemplateAppLocalizations.shared.informationTabTitle)
        view.set(cellModels: buildCellModels())
    }

    deinit {
        if let currencyObserver = currencyObserver {
            NotificationCenter.default.removeObserver(currencyObserver)
        }
    }

    func rate() {
        guard let url = URL(string: ConfigManager.shared.itunesLink) else {
            return
        }
        view?.open(url: url)
    }

    func select(cellModel: InfoScreenCellModelProtocol) {
        switch cellModel.type {
            case .settings:
                view?.showSettingsScreen()
            case .email:
                view?.sendEmail(address: ConfigManager.shared.feedbackEmail)
            case .external:
                openURL(from: cellModel as! InfoScreenExternalCellModel)
            case .about, .rate, .version:
                return
        }
    }

    private func openURL(from cellModel: InfoScreenExternalCellModel) {

        guard let link = cellModel.url, let url = URL(string: link), let scheme = url.scheme, scheme.contains("http") else {
            return
        }

        view?.open(url: url)
    }
}

private extension InfoScreenPresenter {

    func buildCellModels() -> [InfoScreenCellModelProtocol] {

        var cellModels = [InfoScreenCellModelProtocol]()

        let canRate = !ConfigManager.shared.itunesLink.isEmpty

        cellModels.append(buildAboutCellModel(separator: !canRate))

        if canRate {
            cellModels.append(buildRateCellModel())
        }

        cellModels.append(buildSettingsCellModel())

        if ConfigManager.shared.feedbackEmail.contains("@") {
            cellModels.append(buildEmailCellModel())
        }

        if let externalLinks = ConfigManager.shared.externalLinks {
            cellModels.append(contentsOf: buildExternalCellModels(from: externalLinks))
        }

        cellModels.append(buildVersionCellModel())

        return cellModels
    }

    func buildAboutCellModel(separator: Bool) -> InfoScreenAboutCellModel {
        return InfoScreenAboutCellModel(icon: "AppIcon60x60", logo: appLogo(), name: appName(), description: appDescription(), separator: separator)
    }

    func appLogo() -> String? {
        return ConfigManager.shared.appLogo
    }

    func appName() -> String {
        return ConfigManager.shared.appName
    }

    func appDescription() -> String? {
        return ConfigManager.shared.appDescription
    }

    func buildRateCellModel() -> InfoScreenRateCellModel {
        return InfoScreenRateCellModel(name: TemplateAppLocalizations.shared.itunesRateLinkTitle)
    }

    func buildSettingsCellModel() -> InfoScreenBasicCellModel {
        return InfoScreenBasicCellModel(type: .settings, title: TemplateAppLocalizations.shared.settingsScreenTitle)
    }

    func buildEmailCellModel() -> InfoScreenBasicCellModel {
        return InfoScreenBasicCellModel(type: .email, title: TemplateAppLocalizations.shared.feedbackSendEmailTitle)
    }

    func buildExternalCellModels(from externalLinks: [ExternalLink]) -> [InfoScreenCellModelProtocol] {
        return externalLinks.filter { !($0.name?.isEmpty ?? true) }.map { InfoScreenExternalCellModel(name: $0.name, url: $0.url) }
    }

    func buildVersionCellModel() -> InfoScreenVersionCellModel {
        return InfoScreenVersionCellModel(version: appVersion())
    }

    func appVersion() -> String? {

        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return nil
        }

        return "v\(version)"
    }
}
