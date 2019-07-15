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
                                               title: NSLS("INFORMATION_TITLE"),
                                               icon: #imageLiteral(resourceName: "info_icon"),
                                               screenshotID: "")

    func additionalTabItems() -> [JRTabBarViewControllerTabItemProtocol] {
        return [infoItem]
    }

    func sceneForTabWithItemType(_ type: JRTabBarViewControllerTabItemType) -> JRScene {
        return InfoScreenViewController.scene(parentRouter: JRMainRouter.sharedInstance())
    }
}

private class TabBarViewControllerTabItem: NSObject, JRTabBarViewControllerTabItemProtocol {
    let type: JRTabBarViewControllerTabItemType
    let title: String!
    let icon: UIImage!
    private let _screenshotID: String!
    override var screenshotID: String! {
        get {
            return _screenshotID
        }
        set {}
    }

    init(type: JRTabBarViewControllerTabItemType,
         title: String,
         icon: UIImage,
         screenshotID: String) {
        self.type = type
        self.title = title
        self.icon = icon
        self._screenshotID = screenshotID
    }

}
