//
//  SystemUpdateInfoCell.swift
//  iHarmonyOS
//
//  Created by Cyandev on 2021/6/5.
//

import UIKit

class SystemUpdateInfoCell: UITableViewCell {

    @IBOutlet weak var gear1: UIImageView!
    @IBOutlet weak var gear2: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var sizeLabelTopAnchor: NSLayoutConstraint!
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            
            UIView.performWithoutAnimation {
                self.progressView.progress = 0.15
            }
            self.sizeLabel.text = "还需约 1 小时"
            
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
