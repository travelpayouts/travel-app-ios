// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import UIKit
import AviasalesKit
import Appodeal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainRouter: JRMainRouter!
    var isTerminating = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ConfigManager.setup(provider: ConfigProvider())

        validateConfig()

        TemplateAppConfigurator.configure(configuration: TemplateAppConfiguration())

        Appodeal.initialize(withApiKey: ConfigManager.shared.appodealKey, types: .interstitial)
        ASTJRC.setup()

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        mainRouter = JRMainRouter()

        TemplateAppConfigurator.configurePostRouterSetup(window: window)

        mainRouter.start(with: window)

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        isTerminating = true
    }

}

private func validateConfig() {
    guard NSClassFromString("XCTest") == nil else {
        return
    }

    let partnerMarker = ConfigManager.shared.partnerMarker
    assert(partnerMarker != "", "partner_marker must be configured in default_config.plist")

    let apiToken = ConfigManager.shared.apiToken
    assert(apiToken != "", "api_token must be configured in default_config.plist")
}
