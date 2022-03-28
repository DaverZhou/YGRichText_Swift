//
//  NSAttributedString+YG.swift
//  YGSWFRichText
//
//  Created by 周永桂 on 2021/6/17.
//

import Foundation

public extension NSAttributedString {

    /// 根据固定高度获取动态宽度
    public func yg_getWidthByMaxHeight(_ height: Int) -> CGFloat {
        return self.yg_size(Int.max, height).width
    }
    
    /// 根据固定宽度获取动态高度
    public func yg_getHeightByMaxWidth(_ width: Int) -> CGFloat {
        return self.yg_size(width, Int.max).height
    }

    /// 根据 宽 / 高, 获取 size
    public func yg_size(_ width: Int, _ height: Int) -> CGSize {
        return self.boundingRect(with: CGSize.init(width: width, height: height), options: .usesLineFragmentOrigin, context: nil).size
    }

}
