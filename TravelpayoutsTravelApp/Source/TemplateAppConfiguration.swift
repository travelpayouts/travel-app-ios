// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import Foundation
import AviasalesKit

class TemplateAppConfiguration: TemplateAppConfigurationProtocol {

    private lazy var tabBarItemsFactory = AdditionalTabBarItemsFactory()
    private lazy var appLastUsedSearchInfoStorage = UserDefaultsLastUsedSearchInfoStorage()

    func mainRouter() -> JRMainRouter! {
        return appDelegate.mainRouter
    }

    func isApplicationTerminating() -> Bool {
        return appDelegate.isTerminating
    }

    func createWaitingScreen(with searchInfo: JRSDKSearchInfo, searchSession: JRSearchSession, delegate: JRWaitingScreenDelegate, router: JRRouterProtocol) -> JRViewController {
        return ASTWaitingScreenViewController(searchInfo: searchInfo, searchSession: searchSession, delegate: delegate, router: router)
    }

    func additionalTabBarItemsFactory() -> AdditionalTabBarItemsFactoryProtocol? {
        return tabBarItemsFactory
    }

    func lastUsedSearchInfoStorage() -> LastUsedSearchInfoStorageProtocol {
        return appLastUsedSearchInfoStorage
    }

}

private extension TemplateAppConfiguration {

    private var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

}

private class AdditionalTabBarItemsFactory: NSObject, AdditionalTabBarItemsFactoryProtocol {
    let infoItem = TabBarViewControllerTabItem(type: .mainViewControllerTabItemTypeCustom,
                                               title: TemplateAppLocalizations.shared.informationTabTitle,
                                               icon: #imageLiteral(resourceName: "info_icon"))
    let carRentalItem = TabBarViewControllerTabItem(type: .mainViewControllerTabItemTypeCustom2,
                                                    title: TemplateAppLocalizations.shared.carRentalTabTitle,
                                                    icon: #imageLiteral(resourceName: "car_rental_icon"))

    var carRentalRequest: URLRequest? = {
        let urlString = ConfigManager.shared.carRentalLink
        guard !urlString.isEmpty else {
            return nil
        }

        let url = URL(string: urlString) ?? URL(string: "http://travelpayouts.com")!
        return URLRequest(url: url)
    }()

    func additionalTabItems() -> [JRTabBarViewControllerTabItemProtocol] {
        if carRentalRequest != nil {
            return [carRentalItem, infoItem]
        }
        return [infoItem]
    }

    func sceneForTabWithItemType(_ type: JRTabBarViewControllerTabItemType) -> JRScene {
        switch (type) {
        case .mainViewControllerTabItemTypeCustom2:
            return BrowserVC.scene(request: carRentalRequest!, parentRouter: JRMainRouter.sharedInstance())
        case .mainViewControllerTabItemTypeCustom:
            fallthrough
        default:
            return InfoScreenViewController.scene(parentRouter: JRMainRouter.sharedInstance())
        }
    }
}

private class TabBarViewControllerTabItem: NSObject, JRTabBarViewControllerTabItemProtocol {
    let type: JRTabBarViewControllerTabItemType
    let title: String!
    let icon: UIImage!

    init(type: JRTabBarViewControllerTabItemType,
         title: String,
         icon: UIImage) {
        self.type = type
        self.title = title
        self.icon = icon
    }

}
