// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import LibraryUIKitHelpers
import JRProfile
import SafariServices
import SharedNavigation

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

        if deprecated_is_iPad() {
            let navigationController = JRNavigationController(rootViewController: scene.viewController)
            let height = UIScreen.main.bounds.size.height
            let size = CGSize(width: 600, height: 700)
            let params = JRBottomDrawerPresentationParams(height: height, sizeInPopover: size, sourceView: nil)
            params.permittedArrowDirections = .unknown
            viewController.presentInBottomDrawer(navigationController, presentationParams: params, animated: true, completion: nil)
        } else {
            viewController.present(scene.containerViewController, animated: true)
        }
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

    func currencyPickerViewController(_ viewController: JRCurrencyPickerViewControllerProtocol, didSelectCurrency currency: JRSDKCurrency) {
        returnToCurrentViewController()
    }
}

private extension InfoScreenRouter {

    func returnToCurrentViewController() {
        viewController.dismiss(animated: true)
    }
}
