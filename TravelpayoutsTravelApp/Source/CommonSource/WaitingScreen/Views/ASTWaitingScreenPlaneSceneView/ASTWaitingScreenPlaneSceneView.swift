// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import UIKit
import AviasalesKit

class ASTWaitingScreenPlaneSceneView: UIView {

    @IBOutlet var view: UIView!

    @IBOutlet weak var planeImageView: UIImageView!

    @IBOutlet weak var cloudSceneView: UIView!

    @IBOutlet weak var cloudOneImageView: UIImageView!
    @IBOutlet weak var cloudTwoImageView: UIImageView!
    @IBOutlet weak var cloudThreeImageView: UIImageView!
    @IBOutlet weak var cloudFourImageView: UIImageView!
    @IBOutlet weak var cloudFiveImageView: UIImageView!
    @IBOutlet weak var cloudSixImageView: UIImageView!
    @IBOutlet weak var cloudSevenImageView: UIImageView!

    private let cloudsOffset: CGFloat = {
        return is_iPad() ? 1366 : UIScreen.main.bounds.size.width
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromXib()
    }

    private func loadFromXib() {
        view = (Bundle.main.loadNibNamed("ASTWaitingScreenPlaneSceneView", owner: self, options: nil)?.first as! UIView)
        view.frame = self.bounds
        self.addSubview(view)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        view.transformRTL()
        cloudSceneView.backgroundColor = ASTColorScheme.mainBackgroundColor()
        planeImageView.tintColor = ASTColorScheme.mainColor()
    }

    func startAnimating() {
        animatePlane()
        animateClouds()
    }

    private func animatePlane() {

        let animation = CABasicAnimation()

        animation.keyPath = "position.y"
        animation.byValue = 10
        animation.duration = 2
        animation.autoreverses = true
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        planeImageView.layer.add(animation, forKey: "plane")
    }

    private func animateClouds() {

        addCloudAnimation(imageView: cloudOneImageView, duration: 12, timeOffset: 8)
        addCloudAnimation(imageView: cloudTwoImageView, duration: 8, timeOffset: 2)
        addCloudAnimation(imageView: cloudThreeImageView, duration: 8, timeOffset: 6)
        addCloudAnimation(imageView: cloudFourImageView, duration: 6, timeOffset:  1)
        addCloudAnimation(imageView: cloudFiveImageView, duration: 8, timeOffset:  6)
        addCloudAnimation(imageView: cloudSixImageView, duration: 10, timeOffset: 6)
        addCloudAnimation(imageView: cloudSevenImageView, duration: 14, timeOffset: 2)
    }

    func addCloudAnimation(imageView: UIImageView, duration: TimeInterval, timeOffset: TimeInterval) {

        let animation = CABasicAnimation()

        animation.keyPath = "position.x"
        animation.fromValue = cloudsOffset + imageView.frame.width
        animation.toValue = -imageView.frame.width
        animation.duration = duration
        animation.timeOffset = timeOffset
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        imageView.layer.add(animation, forKey: "cloud")
    }
}
