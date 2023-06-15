//
//  ViewController.swift
//  YGRichText
//
//  Created by Yg zhou on 2021/7/7.
//

import UIKit
import YGRichText_Swift
import SnapKit

class ViewController: UIViewController {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.titleLabel)
        let string = "YGRichText 富文本库 YGRichText 富文本库 YGRichText 富文本库 YGRichText 富文本库 YGRichText 富文本库"
        let highlight = "YGRichText"
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(100)
        }
        
         
        self.titleLabel.attributedText = string.yg_makeAttributed({ make in
//            make.font(UIFont.systemFont(ofSize: 20)).foregroundColor(.red).inRange(of: highlight)
            make.strikethroughStyle().inRange(0, 3)
            make.foregroundColor(.green).inRanges(of: highlight)
            make.insertImage(UIImage.init(named: "personal_editor")!, CGRect.init(x: 0, y: 0, width: 15, height: 17), 0).inRange()
        })
        
    }

}

