// Copyright 2020 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import UIKit

class ViewController: UIViewController {

    private let bgColor: UIColor

    init(title: String, bgColor: UIColor) {
        self.bgColor = bgColor

        super.init(nibName: nil, bundle: nil)

        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = bgColor
    }
}
