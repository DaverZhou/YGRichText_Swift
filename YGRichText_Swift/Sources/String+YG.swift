//
//  String+YG.swift
//  YGSWFRichText
//
//  Created by 周永桂 on 2021/6/17.
//

import Foundation


public extension String {
    public func yg_makeAttributed(_ closure: (YGAttributedMaker) -> Void) -> NSMutableAttributedString {
        if self.isEmpty {
            return NSMutableAttributedString.init(string: "")
        }
        
        let maker = YGAttributedMaker.init(string: self)
        
        closure(maker)
        
        return maker.result()
    }

}
