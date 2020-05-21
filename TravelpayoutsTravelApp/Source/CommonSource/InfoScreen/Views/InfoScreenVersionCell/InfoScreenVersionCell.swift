// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import UIKit

protocol InfoScreenVersionCellProtocol {
    var version: String? { get }
}

class InfoScreenVersionCell: UITableViewCell {

    @IBOutlet weak var versionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        versionLabel.textColor = ASTColorScheme.darkTextColor()
    }

    func setup(cellModel: InfoScreenVersionCellProtocol) {
        versionLabel.text = cellModel.version
    }
}
