//
//  YGAttributedMaker.swift
//  YGSWFRichText
//
//  Created by 周永桂 on 2021/6/17.
//

import UIKit

class YGAttributedMaker: NSObject {
    
    private var strings: Array<String> = []
    private var attributedStrings: Array<NSMutableAttributedString> = []
    private var attributeds: [ String : Any] = [:]
    private var style: NSMutableParagraphStyle?
    
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
        let attributedString = NSMutableAttributedString.init()
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
        addAttributed(NSAttributedString.Key.font.rawValue, value: value)
        return self
    }
        
    /// 斜体
    public func italic(_ value: CGFloat) -> YGAttributedMaker {
        addAttributed(NSAttributedString.Key.obliqueness.rawValue, value: value)
        return self
    }
    
    /// 设置文字颜色
    public func foregroundColor(_ value: UIColor) -> YGAttributedMaker {
        addAttributed(NSAttributedString.Key.foregroundColor.rawValue, value: value)
        return self
    }

    /// 设置背景颜色
    public func backgroundColor(_ value: UIColor) -> YGAttributedMaker {
        addAttributed(NSAttributedString.Key.backgroundColor.rawValue, value: value)
        return self
    }

    /// 删除线高度
    public func strikethroughStyle(_ value: Int) -> YGAttributedMaker {
        addAttributed(NSAttributedString.Key.strikethroughStyle.rawValue, value: value)
        return self
    }
    
    /// 删除线颜色
    public func strikethroughColor(_ value: UIColor) -> YGAttributedMaker {
        addAttributed(NSAttributedString.Key.strikethroughColor.rawValue, value: value)
        return self
    }

    /// 下滑线粗度
    public func underlineStyle(_ value: Int) -> YGAttributedMaker {
        addAttributed(NSAttributedString.Key.underlineStyle.rawValue, value: value)
        return self
    }

    /// 下滑线颜色
    public func underlineColor(_ value: UIColor) -> YGAttributedMaker {
        addAttributed(NSAttributedString.Key.underlineColor.rawValue, value: value)
        return self
    }
    
    /// 字体描边宽度
    public func strokeWidth(_ value: CGFloat) -> YGAttributedMaker {
        addAttributed(NSAttributedString.Key.strokeWidth.rawValue, value: value)
        return self
    }
    
    /// 字体描边颜色
    public func strokeWidth(_ value: UIColor) -> YGAttributedMaker {
        addAttributed(NSAttributedString.Key.strokeColor.rawValue, value: value)
        return self
    }

    /// 字体阴影
    public func shadow(_ value: NSShadow) -> YGAttributedMaker {
        addAttributed(NSAttributedString.Key.shadow.rawValue, value: value)
        return self
    }

    /// 字间距
    public func kern(_ value: CGFloat) -> YGAttributedMaker {
        addAttributed(NSAttributedString.Key.kern.rawValue, value: value)
        return self
    }
    
    /// 段落: 行间距
    public func lineSpacing(_ value: CGFloat) -> YGAttributedMaker {
        if self.style == nil {
            self.style = NSMutableParagraphStyle.init()
        }
        self.style?.lineSpacing = value
        addAttributed(NSAttributedString.Key.paragraphStyle.rawValue, value: self.style)
        return self
    }
    
    /// 段落: 对齐方式
    public func textAlignment(_ value: NSTextAlignment) -> YGAttributedMaker {
        if self.style == nil {
            self.style = NSMutableParagraphStyle.init()
        }
        self.style?.alignment = value
        addAttributed(NSAttributedString.Key.paragraphStyle.rawValue, value: self.style)
        return self
    }

    /// 段落: 字符截断类型
    public func textAlignment(_ value: NSLineBreakMode) -> YGAttributedMaker {
        if self.style == nil {
            self.style = NSMutableParagraphStyle.init()
        }
        self.style?.lineBreakMode = value
        addAttributed(NSAttributedString.Key.paragraphStyle.rawValue, value: self.style)
        return self
    }
    
    /// 设置URL跳转 UITextView才有效，UILabel和UITextField里面无效
    public func link(_ value: String) -> YGAttributedMaker {
        addAttributed(NSAttributedString.Key.link.rawValue, value: NSURL.init(string:value))
        return self
    }

    /// 插入图片
    public func insertImage(_ image: UIImage?, _ bounds: CGRect, _ index: Int) -> YGAttributedMaker {
        // 图标
        let attachment = NSTextAttachment.init()
        attachment.image = image
        attachment.bounds = bounds
        // 富文本
        let tempAttributed = NSAttributedString.init(attachment: attachment)
        let attributedString = self.attributedStrings.last
        attributedString?.insert(tempAttributed, at: index)
        
        return self
    }

    /// 拼接字符串
    public func appendString(_ string: String) -> YGAttributedMaker {
        self.strings.append(string)
        let attributedString = NSMutableAttributedString.init(string: string)
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
        
        let attributedString = NSMutableAttributedString.init()
        for item in self.attributedStrings {
            attributedString.append(item)
        }
        self.attributedStrings.removeAll()
        self.attributedStrings.append(attributedString)
        
        return self
    }
    
    /// MARK: Range
    public func allRange() {
        let string = self.strings.last
        let range = NSRange.init(location: 0, length: string?.count ?? 0)
        
        compositionToAttributed(range: range)
    }
    
    public func yg_Range(_ loc: Int, _ len: Int) {
        compositionToAttributed(range: NSRange.init(location: loc, length: len))
    }
    
    public func inRange(_ range: NSRange) {
        compositionToAttributed(range: range)
    }
    
    /// MARK: Private
    private func addAttributed(_ key: String?, value: Any?) {
        if key != nil && value != nil {
            self.attributeds.updateValue(value!, forKey: key!)
        }
    }
    
    private func compositionToAttributed(range: NSRange) {
        let attributedString = self.attributedStrings.last
        for (key, value) in self.attributeds {
            attributedString?.addAttribute(NSAttributedString.Key(rawValue: key), value: value, range: range)
        }
        
        self.style = nil
        self.attributeds.removeAll()
        
    }
    
}
