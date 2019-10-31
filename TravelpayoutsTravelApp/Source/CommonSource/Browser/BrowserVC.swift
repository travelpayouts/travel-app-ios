// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import UIKit
import AviasalesKit

class BrowserVC: UIViewController, JRSceneViewControllerProtocol {

    var router: JRRouterProtocol!

    private let request: URLRequest

    private var backButton: UIBarButtonItem!
    private var forwardButton: UIBarButtonItem!
    private var reloadButton: UIBarButtonItem!
    private var homeButton: UIBarButtonItem!
    private var titleLabel: UILabel!

    private var webView: WKWebView!
    private var progressView: UIView!
    private var progressViewWidthConstraint: NSLayoutConstraint!

    private var observers: [NSKeyValueObservation]?

    static func scene(request: URLRequest, parentRouter: JRRouterProtocol) -> JRScene {
        let router = JRBaseRouter(parentRouter: parentRouter)
        let viewController = BrowserVC(request: request)
        viewController.router = router

        return JRBaseScene(viewController: viewController, router: router, containerViewController: nil)
    }

    init(request: URLRequest) {
        self.request = request

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ASTColorScheme.mainBackgroundColor()

        setupNavigationBar()
        setupProgressView()
        setupWebView()

        loadInitialRequest()
    }

    private func setupNavigationBar() {
        let backImage = TemplateAppImages.shared.browserBackImage.imageAccordingToInterfaceLayoutDirection()
        let forwardImage = TemplateAppImages.shared.browserForwardImage.imageAccordingToInterfaceLayoutDirection()
        let reloadImage = TemplateAppImages.shared.browserReloadImage
        let homeImage = TemplateAppImages.shared.browserHomeImage

        backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonAction))
        forwardButton = UIBarButtonItem(image: forwardImage, style: .plain, target: self, action: #selector(forwardButtonAction))
        reloadButton = UIBarButtonItem(image: reloadImage, style: .plain, target: self, action: #selector(reloadButtonAction))
        homeButton = UIBarButtonItem(image: homeImage, style: .plain, target: self, action: #selector(homeButtonAction))
        titleLabel = UILabel()

        navigationItem.leftBarButtonItems = [backButton, forwardButton]
        navigationItem.rightBarButtonItems = [homeButton, reloadButton]
        navigationItem.titleView = titleLabel
    }

    private func setupWebView() {
        webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self

        view.insertSubview(webView, belowSubview: progressView)
        webView.autoPinEdge(toSuperviewEdge: .leading)
        webView.autoPinEdge(toSuperviewEdge: .trailing)
        webView.autoPinEdge(toSuperviewSafeArea: .top)
        webView.autoPinEdge(toSuperviewSafeArea: .bottom)

        self.observers = [
            webView.observe(\.canGoBack, options: .initial) { [weak self] (webView, change) in
                self?.backButton.isEnabled = webView.canGoBack
            },
            webView.observe(\.canGoForward, options: .initial) { [weak self] (webView, change) in
                self?.forwardButton.isEnabled = webView.canGoForward
            },
            webView.observe(\.title, options: .initial) { [weak self] (webView, change) in
                self?.updateTitleLabel()
            },
            webView.observe(\.isLoading, options: .initial) { (webView, change) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = webView.isLoading
            },
            webView.observe(\.estimatedProgress, options: .initial) { [weak self] (webView, change) in
                self?.updateProgressView(progress: webView.estimatedProgress)
            }
        ]
    }

    private func setupProgressView() {
        progressView = UIView()
        progressView.backgroundColor = ASTColorScheme.mainColor()

        view.addSubview(progressView)
        progressView.autoPinEdge(toSuperviewEdge: .leading)
        progressView.autoPinEdge(toSuperviewSafeArea: .top)
        progressView.autoSetDimension(.height, toSize: 2)
        updateProgressView(progress: 0)
    }

    private func updateProgressView(progress: Double) {
        let updateProgressWidth = { [weak self] (progress: Double) in
            guard let self = self else {
                return
            }
            self.progressViewWidthConstraint?.autoRemove()
            self.progressViewWidthConstraint = self.progressView.autoMatch(.width, to: .width, of: self.view, withMultiplier: CGFloat(progress))
            self.progressView.superview?.setNeedsLayout()
            self.progressView.superview?.layoutIfNeeded()
        }

        let animations = {
            updateProgressWidth(progress)
        }
        let completion: ((Bool) -> Void)?

        if progress < 1 {
            progressView.isHidden = false
            completion = nil

            if progressViewWidthConstraint?.multiplier == 1 {
                updateProgressWidth(0)
            }
        } else {
            completion = { [weak self] (finished: Bool) in
                self?.progressView.isHidden = true
            }
        }

        if progressViewWidthConstraint == nil {
            animations()
            return
        }

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.beginFromCurrentState, .allowUserInteraction],
                       animations: animations,
                       completion: completion)
    }

    private func updateTitleLabel() {
        let attributedTitle = NSMutableAttributedString()
        let appendText = {
            attributedTitle.append(.init(string: self.webView.title ?? self.webView.url?.host ?? ""))
        }
        if webView.hasOnlySecureContent {
            let attachment = NSTextAttachment()
            attachment.image = TemplateAppImages.shared.browserLockIcon
            if isRTLDirectionByLocale() {
                appendText()
                attributedTitle.append(.init(string: " "))
            }
            attributedTitle.append(.init(attachment: attachment))
            if !isRTLDirectionByLocale() {
                attributedTitle.append(.init(string: " "))
                appendText()
            }
        }
        titleLabel.attributedText = attributedTitle
        titleLabel.sizeToFit()
    }

    private func loadInitialRequest() {
        webView.load(request)
    }

    // MARK: Actions

    @objc private func backButtonAction() {
        webView.goBack()
    }

    @objc private func forwardButtonAction() {
        webView.goForward()
    }

    @objc private func reloadButtonAction() {
        webView.reload()
    }

    @objc private func homeButtonAction() {
        loadInitialRequest()
    }

}

extension BrowserVC: WKUIDelegate {
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if !(navigationAction.targetFrame?.isMainFrame ?? false) {
            webView.load(navigationAction.request)
        }

        return nil
    }
}
