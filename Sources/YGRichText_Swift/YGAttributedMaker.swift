//
//  YGAttributedMaker.swift
//  YGSWFRichText
//
//  Created by Yg zhou on 2021/6/17.
//

import UIKit

public class YGAttributedMaker: NSObject {
    /// 字符串数组
    private var strings: Array<String> = []
    /// 段落属性
    private var paragraphStyle: NSMutableParagraphStyle?
    /// 属性数组
    private var attributedItems: [ NSAttributedString.Key : Any] = [:]
    /// 富文本数组
    private var attributedStrings: Array<NSMutableAttributedString> = []
    
    override init() {
        super.init()
        
    }
    
    convenience init(string: String) {
        self.init()
        self.strings.append(string)
        
        let attributedString = NSMutableAttributedString.init(string: string)
        self.attributedStrings.append(attributedString)
    }

    /// MARK: Public
    /// 结果
    public func result() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        if self.attributedStrings.isEmpty {
            return attributedString
        }
        for string in self.attributedStrings {
            attributedString.append(string )
        }
        return attributedString
    }

    /// 字体
    public func font(_ value: UIFont) -> YGAttributedMaker {
        addAttributed(.font, value: value)
        return self
    }
        
    /// 斜体
    public func italic(_ value: CGFloat) -> YGAttributedMaker {
        addAttributed(.obliqueness, value: value)
        return self
    }
    
    /// 设置文字颜色
    public func foregroundColor(_ value: UIColor) -> YGAttributedMaker {
        addAttributed(.foregroundColor, value: value)
        return self
    }

    /// 设置背景颜色
    public func backgroundColor(_ value: UIColor) -> YGAttributedMaker {
        addAttributed(.backgroundColor, value: value)
        return self
    }

    /// 删除线样式
    public func strikethroughStyle(_ value: NSUnderlineStyle = .single) -> YGAttributedMaker {
        addAttributed(.strikethroughStyle, value: value.rawValue)
        return self
    }
    
    /// 删除线颜色
    public func strikethroughColor(_ value: UIColor) -> YGAttributedMaker {
        addAttributed(.strikethroughColor, value: value)
        return self
    }

    /// 下滑线粗度
    public func underlineStyle(_ value: Int) -> YGAttributedMaker {
        addAttributed(.underlineStyle, value: value)
        return self
    }

    /// 下滑线颜色
    public func underlineColor(_ value: UIColor) -> YGAttributedMaker {
        addAttributed(.underlineColor, value: value)
        return self
    }
    
    /// 字体描边宽度
    public func strokeWidth(_ value: CGFloat) -> YGAttributedMaker {
        addAttributed(.strokeWidth, value: value)
        return self
    }
    
    /// 字体描边颜色
    public func strokeWidth(_ value: UIColor) -> YGAttributedMaker {
        addAttributed(.strokeColor, value: value)
        return self
    }

    /// 字体阴影
    public func shadow(_ value: NSShadow) -> YGAttributedMaker {
        addAttributed(.shadow, value: value)
        return self
    }

    /// 字间距
    public func kern(_ value: CGFloat) -> YGAttributedMaker {
        addAttributed(.kern, value: value)
        return self
    }
    
    /// 段落: 行间距
    public func lineSpacing(_ value: CGFloat) -> YGAttributedMaker {
        if self.paragraphStyle == nil {
            self.paragraphStyle = NSMutableParagraphStyle.init()
        }
        self.paragraphStyle?.lineSpacing = value
        addAttributed(.paragraphStyle, value: self.paragraphStyle)
        return self
    }
    
    /// 段落: 对齐方式
    public func textAlignment(_ value: NSTextAlignment) -> YGAttributedMaker {
        if self.paragraphStyle == nil {
            self.paragraphStyle = NSMutableParagraphStyle.init()
        }
        self.paragraphStyle?.alignment = value
        addAttributed(.paragraphStyle, value: self.paragraphStyle)
        return self
    }

    /// 段落: 字符截断类型
    public func textAlignment(_ value: NSLineBreakMode) -> YGAttributedMaker {
        if self.paragraphStyle == nil {
            self.paragraphStyle = NSMutableParagraphStyle.init()
        }
        self.paragraphStyle?.lineBreakMode = value
        addAttributed(.paragraphStyle, value: self.paragraphStyle)
        return self
    }
    
    /// 设置URL跳转 UITextView才有效，UILabel和UITextField里面无效
    public func link(_ value: String) -> YGAttributedMaker {
        addAttributed(.link, value: NSURL(string:value))
        return self
    }

    /// 插入图片
    public func insertImage(_ image: UIImage?, _ bounds: CGRect, _ index: Int) -> YGAttributedMaker {
        // 图标
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = bounds
        // 富文本
        let tempAttributed = NSAttributedString(attachment: attachment)
        let attributedString = self.attributedStrings.last
        attributedString?.insert(tempAttributed, at: index)
        
        return self
    }

    /// 拼接字符串
    public func appendString(_ string: String) -> YGAttributedMaker {
        self.strings.append(string)
        let attributedString = NSMutableAttributedString(string: string)
        self.attributedStrings.append(attributedString)

        return self
    }
    
    /// 合并当前所有的字符串
    public func mergeStrings() -> YGAttributedMaker {
        var string = ""
        for item in self.strings {
            string.append(item)
        }
        self.strings.removeAll()
        self.strings.append(string)
        
        let attributedString = NSMutableAttributedString()
        for item in self.attributedStrings {
            attributedString.append(item)
        }
        self.attributedStrings.removeAll()
        self.attributedStrings.append(attributedString)
        
        return self
    }
    
    
    
    /// MARK: Private
    private func addAttributed(_ key: NSAttributedString.Key?, value: Any?) {
        if key != nil && value != nil {
            self.attributedItems.updateValue(value!, forKey: key!)
        }
    }
    
}


extension YGAttributedMaker {
    /// set range, defalut all length
    public func inRange() {
        if let string = self.strings.last {
            invokingAttributed(range: NSRange(location: 0, length: string.count))
        }
    }
    
    /// set range by (loc, len)
    public func inRange(_ loc: Int, _ len: Int) {
        invokingAttributed(range: NSRange(location: loc, length: len))
    }
    
    /// set range by NSRange
    public func inRange(_ range: NSRange) {
        invokingAttributed(range: range)
    }
    
    /// set range by condition
    public func inRange(of value: String, options mask: String.CompareOptions = []) {
        if let string = self.strings.last, let range = string.range(of: value, options: mask), let nsRange = string.toNSRange(from: range) {
            invokingAttributed(range: nsRange)
        }
    }
    
    /// set ranges by condition
    public func inRanges(of value: String) {
        if let string = self.attributedStrings.last?.string {
            let ranges = string._ranges(of: value)
            invokingAttributed(ranges: ranges)
        }
    }
    
    /// set ranges by condition
    public func inRanges(of ranges: [Range<String.Index>]) {
        invokingAttributed(ranges: ranges)
    }

    /// 设置属性
    private func invokingAttributed(range: NSRange) {
        if let attributedString = self.attributedStrings.last {
            attributedString.addAttributes(self.attributedItems, range: range)
        }
        self.resetAttributeRecord()
    }
    
    private func invokingAttributed(ranges: [Range<String.Index>]) {
        let attributedString = self.attributedStrings.last
        for range in ranges {
            if let nsRange = attributedString?.string.toNSRange(from: range) {
                attributedString?.addAttributes(self.attributedItems, range: nsRange)
            }
        }
        self.resetAttributeRecord()
    }
    
    private func resetAttributeRecord() {
        self.attributedItems.removeAll()
        self.paragraphStyle = nil
    }

}
