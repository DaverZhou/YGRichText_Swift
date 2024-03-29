//
//  Range+YG.swift
//  YGRichText_Swift
//
//  Created by Yg Zhou on 2023/6/8.
//

import Foundation

public extension String {
    /// Range 转换为 NSRange
    public func toNSRange(from range: Range<String.Index>) -> NSRange? {
        return NSRange(range, in: self)
    }
    
    /// NSRange 转换为 Range
    public func toRange(from nsRange: NSRange) -> Range<String.Index>? {
        if #available(iOS 13.0, *) {
            guard let range = Range(nsRange, in: self) else { return nil }
            return range
        } else {
            guard
                let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location,
                                         limitedBy: utf16.endIndex),
                let to16 = utf16.index(from16, offsetBy: nsRange.length,
                                       limitedBy: utf16.endIndex),
                let from = String.Index(from16, within: self),
                let to = String.Index(to16, within: self)
                else { return nil }
            return from ..< to
        }
    }

    /// 获取匹配的所有 ranges
    public func _ranges(of condition: String) -> [Range<String.Index>] {
        var ranges = [Range<String.Index>]()
        if #available(iOS 16.0, *) {
            ranges = self.ranges(of: condition)
        } else {
            var startIndex = self.startIndex
            while let range = self[startIndex...].range(of: condition) {
                ranges.append(range)
                startIndex = range.upperBound
            }
        }
        return ranges
    }
    
    /// 获取匹配的所有 ranges
    public func _ranges(of condition: String, options mask: NSRegularExpression.Options = []) -> [Range<String.Index>] {
        var ranges = [Range<String.Index>]()
        do {
            let regex = try NSRegularExpression(pattern: condition, options: mask)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            for result in results {
                if let range = Range(result.range, in: self) {
                    ranges.append(range)
                }
            }
        } catch let error {
            print("_ranges error")
        }
        return ranges
    }

    /// 获取匹配的所有 ranges
    public func _nsRanges(of condition: String, options mask: NSRegularExpression.Options = []) -> [NSRange] {
        var ranges = [NSRange]()
        do {
            let regex = try NSRegularExpression(pattern: condition, options: mask)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            for result in results {
                ranges.append(result.range)
            }
        } catch let error {
            print("_ranges error")
        }
        return ranges
    }

    
}

