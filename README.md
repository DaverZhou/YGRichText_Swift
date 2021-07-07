# YGRichText
纯Swift版本, 调用上与OC版本的类似。

[Objective-C 版本](https://github.com/DaverZhou/YGRichText)

```
self.titleLabel.attributedText = "YGRichText 富文本库".yg_makeAttributed({ make in
    make.font(UIFont.systemFont(ofSize: 10)).yg_Range(0, 3)
    make.font(UIFont.systemFont(ofSize: 20)).yg_Range(3, 3)
    make.strikethroughStyle(3).allRange()
    make.insertImage(UIImage.init(named: "personal_editor")!, CGRect.init(x: 0, y: 0, width: 15, height: 17), 0).allRange()
})

```
