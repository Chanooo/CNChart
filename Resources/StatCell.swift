//
//  StatCell.swift
//  CNChart
//
//  Created by CNOO on 2021/07/24.
//

import UIKit

class StatCell: UIView {
    
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelWidthConstraint: NSLayoutConstraint!
    
    var value: Float = 1.0
    var maxValue: Float = 1.0
    
    func updateProgress(duration: TimeInterval, delay: TimeInterval = 0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            UIView.animate(withDuration: duration) {
                self.progress.setProgress(self.value/self.maxValue, animated: true)
            }
        })
    }
}
