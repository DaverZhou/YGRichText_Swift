//
//  String+YG.swift
//  YGSWFRichText
//
//  Created by Yg zhou on 2021/6/17.
//

import Foundation

public extension String {
    public func makeAttributed(_ closure: (YGAttributedMaker) -> Void) -> NSMutableAttributedString {
        if self.isEmpty {
            return NSMutableAttributedString(string: "")
        }
        
        let maker = YGAttributedMaker.init(string: self)
        
        closure(maker)
        
        return maker.result()
    }
    
}


