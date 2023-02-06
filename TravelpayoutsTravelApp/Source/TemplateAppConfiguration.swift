// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import Foundation
import JRFlights
import JRMainScene
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

    func adsManager() -> AdsManagerProtocol? {
        AppodealAdsManager()
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

    func sceneForTabWithItemType(_ type: JRTabBarViewControllerTabItemType, parentRouter: JRRouterProtocol) -> JRScene {
        switch type {
            case .mainViewControllerTabItemTypeCustom:
                fallthrough
            default:
                return InfoScreenViewController.scene(parentRouter: parentRouter)
        }
    }
}

private class TabBarViewControllerTabItem: NSObject, JRTabBarViewControllerTabItemProtocol {
    let type: JRTabBarViewControllerTabItemType
    let title: String!
    let icon: UIImage!
    var accessibilityIdentifier: String?
    let removesBadgeOnSelection: Bool

    init(type: JRTabBarViewControllerTabItemType,
         title: String,
         icon: UIImage,
         removesBadgeOnSelection: Bool = true) {
        self.type = type
        self.title = title
        self.icon = icon
        self.removesBadgeOnSelection = removesBadgeOnSelection
    }
}
