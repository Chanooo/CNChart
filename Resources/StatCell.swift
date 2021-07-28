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
    
    var id: String = ""
    var value: Float = 1.0
    var maxValue: Float = 1.0
    
    func updateProgress() {
        UIView.animate(withDuration: 2.0) {
            self.progress.setProgress(self.value/self.maxValue, animated: true)
        }
    }
}
