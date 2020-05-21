// Copyright 2020 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import UIKit
import ASTemplateConfiguration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.makeKeyAndVisible()

        AviasalesViewControllersFactory.shared.setup(window: window, config: { () -> Config in
            var colorParams = ColorParams()
            colorParams.mainColor = "9C6CBE"
            colorParams.actionColor = "CE0755"

            var config = Config()
            config.partnerMarker = "11501"
            config.apiToken = "31b7acf7452acdb78c6a25aa1cd2ea49"
            config.carRentalLink = "https://c117.travelpayouts.com/click?shmarker=226237&promo_id=3555&source_type=customlink&type=click&custom_url=https%3A%2F%2Fwww.discovercarhire.com%2F"
            config.colorParams = colorParams
            return config
        }())

        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([
            ViewController(title: "One", bgColor: .lightGray),
            ViewController(title: "Two", bgColor: .darkGray),
            AviasalesViewControllersFactory.shared.flightsViewController(),
            AviasalesViewControllersFactory.shared.hotelsViewController(),
            AviasalesViewControllersFactory.shared.carRentalViewController()
        ], animated: false)

        window.rootViewController = tabBarVC

        return true
    }
}
