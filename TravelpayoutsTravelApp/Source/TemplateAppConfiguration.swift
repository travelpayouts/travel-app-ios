// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import Foundation
import AviasalesKit
import ASTemplateConfiguration

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
        return TemplateAppWaitingScreenViewController(searchInfo: searchInfo, searchSession: searchSession, delegate: delegate, router: router, adsManager: AppodealAdsManager())
    }

    func additionalTabBarItemsFactory() -> AdditionalTabBarItemsFactoryProtocol? {
        return tabBarItemsFactory
    }

    func lastUsedSearchInfoStorage() -> LastUsedSearchInfoStorageProtocol {
        return appLastUsedSearchInfoStorage
    }

    func ticketsSearchFormBackgroundImage() -> UIImage? {
        nil
    }

    func hotelsSearchFormBackgroundImage() -> UIImage? {
        nil
    }

    func enableSettingsButtonOnSearchForms() -> Bool {
        false
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

    func additionalTabItems() -> [JRTabBarViewControllerTabItemProtocol] {
        return [infoItem]
    }

    func sceneForTabWithItemType(_ type: JRTabBarViewControllerTabItemType) -> JRScene {
        switch type {
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
