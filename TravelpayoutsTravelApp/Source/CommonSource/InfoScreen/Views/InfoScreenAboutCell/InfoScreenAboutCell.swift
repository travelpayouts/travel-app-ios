// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import LibraryUIKitHelpers
import NukeExtensions

protocol InfoScreenAboutCellProtocol {
    var icon: String { get }
    var logo: String? { get }
    var name: String? { get }
    var description: String? { get }
    var separator: Bool { get }
}

class InfoScreenAboutCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var iconImageViewFiveTimesTapAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupUI()
    }

    private func setupUI() {
        iconImageView.layer.cornerRadius = 14
        iconImageView.layer.borderWidth = JRPixel()
        iconImageView.layer.borderColor = UIColor.lightGray.cgColor
        iconImageView.clipsToBounds = true
        nameLabel.textColor = ASTColorScheme.darkTextColor()
        descriptionLabel.textColor = ASTColorScheme.darkTextColor()
    }

    func setup(cellModel: InfoScreenAboutCellProtocol) {
        let appIcon = UIImage(named: cellModel.icon)
        if let logo = cellModel.logo, let url = URL(string: logo) {
            _ = loadImage(
                with: url,
                options: .init(placeholder: appIcon),
                into: iconImageView
            )
        } else {
            iconImageView.image = appIcon
        }
        nameLabel.text = cellModel.name
        descriptionLabel.text = cellModel.description
    }

    @IBAction func iconImageViewFiveTimesTapped(_ sender: UITapGestureRecognizer) {
        iconImageViewFiveTimesTapAction?()
    }
}
