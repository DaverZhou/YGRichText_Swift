//
//  ViewController.swift
//  YGRichText
//
//  Created by Yg zhou on 2021/7/7.
//

import UIKit
import YGRichText_Swift

class ViewController: UIViewController {
    let titleLabel = UILabel.init(frame: CGRect.init(x: 50, y: 100, width: 300, height: 100))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.titleLabel)
        let string = "YGRichText 富文本库"
        let highlight = "YGRichText"
         
        self.titleLabel.attributedText = string.yg_makeAttributed({ make in
            make.font(UIFont.systemFont(ofSize: 20)).foregroundColor(.red).inRange(of: highlight)
            make.strikethroughStyle().inRange(0, 3)
            make.insertImage(UIImage.init(named: "personal_editor")!, CGRect.init(x: 0, y: 0, width: 15, height: 17), 0).inRange()
        })
        
    }

}

