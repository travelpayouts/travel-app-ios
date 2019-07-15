// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import Foundation
import AviasalesKit
import SafariServices

class InfoScreenRouter: JRBaseRouter {

    private let sender = HLEmailSender()

    public override func `return`(fromRouter router: JRRouterProtocol) {
        if router is SettingsRouterProtocol || router is JRCurrencyPickerRouterProtocol {
            viewController.dismiss(animated: true)
        } else {
            super.return(fromRouter: router)
        }
    }

    func showSettingsViewController() {
        let scene = SettingsScene.instantiateScene(fromRouter: self)
        presentSceneViewController(scene.containerViewController)
    }

    func openEmailSender(address: String) {
        if HLEmailSender.canSendEmail() {
            sender.sendFeedbackEmail(to: address)
            viewController.present(sender.mailer, animated: true)
        } else {
            HLEmailSender.showUnavailableAlert(in: viewController)
        }
    }

    func open(url: URL) {
        viewController.present(SFSafariViewController(url: url), animated: true)
    }

}

extension InfoScreenRouter: JRCurrencyPickerViewControllerDelegate {

    func currencyPickerDidSelectCurrency() {
        returnToCurrentViewController()
    }

}

private extension InfoScreenRouter {

    func presentSceneViewController(_ viewController: UIViewController) {
        if is_iPad() {
            let height = UIScreen.main.bounds.size.height
            let size = CGSize(width: 600, height: 700)
            let params = JRBottomDrawerPresentationParams(height: height, sizeInPopover: size, sourceView: nil)
            self.viewController.presentInBottomDrawer(viewController, presentationParams: params, animated: true, completion: nil)
        } else {
            self.viewController.present(viewController, animated: true)
        }
    }

    func returnToCurrentViewController() {
        viewController.dismiss(animated: true)
    }

}
