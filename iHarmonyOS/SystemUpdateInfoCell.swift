//
//  SystemUpdateInfoCell.swift
//  iHarmonyOS
//
//  Created by Cyandev on 2021/6/5.
//

import UIKit

class SystemUpdateInfoCell: UITableViewCell {
    @IBOutlet var gear1: UIImageView!
    @IBOutlet var gear2: UIImageView!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var sizeLabelTopAnchor: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        progressView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func startFakeProgress() {
        progressView.isHidden = false
        progressView.alpha = 0

        progressView.progress = 0
        sizeLabel.text = "正在估算剩余时间..."

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            UIView.performWithoutAnimation {
                self.progressView.progress = 0.01
            }
            self.sizeLabel.text = "还需约 2 小时"

            self.sizeLabelTopAnchor.constant = 9
            self.setNeedsLayout()
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
                self.progressView.alpha = 1
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            UIView.performWithoutAnimation {
                self.progressView.progress = 0.07
            }
            self.sizeLabel.text = "还需约 45 分钟"

            self.sizeLabelTopAnchor.constant = 9
            self.setNeedsLayout()
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
                self.progressView.alpha = 1
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            UIView.performWithoutAnimation {
                self.progressView.progress = 0.1
            }
            self.sizeLabel.text = "还需约 40 分钟"

            self.sizeLabelTopAnchor.constant = 9
            self.setNeedsLayout()
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
                self.progressView.alpha = 1
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6)) {
            UIView.performWithoutAnimation {
                self.progressView.progress = 0.12
            }
            self.sizeLabel.text = "还需约 40 分钟"

            self.sizeLabelTopAnchor.constant = 9
            self.setNeedsLayout()
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
                self.progressView.alpha = 1
            }
        }

        startGearRotationAnimation()
    }

    private func startGearRotationAnimation() {
        let anim1 = CABasicAnimation(keyPath: "transform.rotation.z")
        anim1.fromValue = 0
        anim1.toValue = -Double.pi * 2
        anim1.duration = 10
        anim1.repeatCount = HUGE
        gear1.layer.add(anim1, forKey: "")

        let anim2 = CABasicAnimation(keyPath: "transform.rotation.z")
        anim2.fromValue = 0
        anim2.toValue = Double.pi * 2
        anim2.duration = 8
        anim2.repeatCount = HUGE
        gear2.layer.add(anim2, forKey: "")
    }
}
