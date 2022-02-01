// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import UIKit
import JRFlights
import SharedNavigation

class InfoScreenViewController: JRViewController, InfoScreenIconImageViewFiveTimesTapHandler, JRSceneViewControllerProtocol {

    var router: JRRouterProtocol!
    var infoScreenRouter: InfoScreenRouter {
        return router as! InfoScreenRouter
    }

    private let presenter = InfoScreenPresenter()

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!

    var cellModels = [InfoScreenCellModelProtocol]()

    static func scene(parentRouter: JRRouterProtocol) -> JRScene {
        let router = InfoScreenRouter(parentRouter: parentRouter)
        let viewController = InfoScreenViewController()
        viewController.router = router
        return JRBaseScene(viewController: viewController, router: router, containerViewController: nil)
    }

    override class func bundleForNib() -> Bundle? {
        return Bundle(for: Self.self)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        presenter.attach(self)
    }

    // MARK: - Setup

    func setupViewController() {
        setupTableView()
        setupUI()
    }

    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView(frame: .zero)
    }

    func setupUI() {
        view.backgroundColor = ASTColorScheme.mainBackgroundColor()
        containerView.layer.cornerRadius = 6
        navigationItem.backBarButtonItem = UIBarButtonItem.backBarButtonItem()
    }
}

private extension InfoScreenViewController {

    func buildAboutCell(cellModel: InfoScreenAboutCellModel) -> InfoScreenAboutCell {
        let cell = InfoScreenAboutCell.fromMainBundleNib()
        cell.setup(cellModel: cellModel as InfoScreenAboutCellProtocol)
        let left: CGFloat = cellModel.separator ? tableView.separatorInset.left : view.bounds.width
        cell.separatorInset = UIEdgeInsets(top: 0, left: left, bottom: 0, right: 0)
        cell.iconImageViewFiveTimesTapAction = { [weak self] in
            self?.handleFiveTimesTap()
        }
        return cell
    }

    func buildRateCell(cellModel: InfoScreenRateCellModel) -> InfoScreenRateCell {
        let cell = InfoScreenRateCell.fromMainBundleNib()
        cell.setup(cellModel: cellModel as InfoScreenRateCellProtocol) { [weak self] _ in
            self?.presenter.rate()
        }
        return cell
    }

    func buildDetailCell(cellModel: InfoScreenDetailCellModel) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.backgroundColor = .clear
        cell.textLabel?.text = cellModel.title
        cell.textLabel?.textColor = ASTColorScheme.darkTextColor()
        cell.detailTextLabel?.text = cellModel.subtitle
        cell.detailTextLabel?.textColor = ASTColorScheme.mainColor()
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func buildBasicCell(cellModel: InfoScreenBasicCellModel) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = .clear
        cell.textLabel?.text = cellModel.title
        cell.textLabel?.textColor = ASTColorScheme.darkTextColor()
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func buildExternalCell(cellModel: InfoScreenExternalCellModel) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = .clear
        cell.textLabel?.text = cellModel.name
        cell.textLabel?.textColor = ASTColorScheme.darkTextColor()
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func buildVersionCell(cellModel: InfoScreenVersionCellModel) -> InfoScreenVersionCell {
        let cell = InfoScreenVersionCell.fromMainBundleNib()
        cell.setup(cellModel: cellModel as InfoScreenVersionCellProtocol)
        cell.separatorInset = UIEdgeInsets(top: 0, left: view.bounds.width, bottom: 0, right: 0)
        return cell
    }
}

extension InfoScreenViewController: InfoScreenViewProtocol {

    func set(title: String) {
        navigationItem.title = title
    }

    func set(cellModels: [InfoScreenCellModelProtocol]) {
        self.cellModels = cellModels
        tableView.reloadData()
    }

    func open(url: URL) {
        infoScreenRouter.open(url: url)
    }

    func showSettingsScreen() {
        infoScreenRouter.showSettingsViewController()
    }

    func sendEmail(address: String) {
        infoScreenRouter.openEmailSender(address: address)
    }
}

extension InfoScreenViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModels[indexPath.row]
        switch cellModel.type {
            case .about:
                return buildAboutCell(cellModel: cellModel as! InfoScreenAboutCellModel)
            case .rate:
                return buildRateCell(cellModel: cellModel as! InfoScreenRateCellModel)
            case .settings:
                return buildBasicCell(cellModel: cellModel as! InfoScreenBasicCellModel)
            case .email:
                return buildBasicCell(cellModel: cellModel as! InfoScreenBasicCellModel)
            case .external:
                return buildExternalCell(cellModel: cellModel as! InfoScreenExternalCellModel)
            case .version:
                return buildVersionCell(cellModel: cellModel as! InfoScreenVersionCellModel)
        }
    }
}

extension InfoScreenViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellModel = cellModels[indexPath.row]
        presenter.select(cellModel: cellModel)
    }
}
