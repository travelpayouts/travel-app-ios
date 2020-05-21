// Copyright 2020 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import UIKit
import Appodeal
import ASTemplateConfiguration

final class AppodealAdsManager: NSObject, AdsManagerProtocol, AppodealInterstitialDelegate {

    // MARK: - Public properties

    var onPresent: (() -> Void)?
    var onDismiss: (() -> Void)?

    // MARK: - Life cycle

    override init() {
        super.init()
        
        Appodeal.setInterstitialDelegate(self)
    }

    // MARK: - AdsManagerProtocol

    func showAd(from viewController: UIViewController) {
        Appodeal.showAd(.interstitial, rootViewController: viewController)
    }

    // MARK: - AppodealInterstitialDelegate

    func interstitialWillPresent() {
        onPresent?()
    }

    func interstitialDidDismiss() {
        onDismiss?()
    }
}
