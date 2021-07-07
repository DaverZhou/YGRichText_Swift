//
//  ViewController.swift
//  YGRichText
//
//  Created by 周永桂 on 2021/7/7.
//

import UIKit
import YGRichText_Swift

class ViewController: UIViewController {
    let titleLabel = UILabel.init(frame: CGRect.init(x: 50, y: 100, width: 300, height: 100))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.titleLabel)
        self.titleLabel.attributedText = "YGRichText 富文本库".yg_makeAttributed({ make in
            make.font(UIFont.systemFont(ofSize: 10)).yg_Range(0, 3)
            make.font(UIFont.systemFont(ofSize: 20)).yg_Range(3, 3)
            make.strikethroughStyle(3).allRange()
            make.insertImage(UIImage.init(named: "personal_editor")!, CGRect.init(x: 0, y: 0, width: 15, height: 17), 0).allRange()
        })
        
    }

}

