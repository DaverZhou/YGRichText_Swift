# YGRichText
纯Swift版本, 调用上与OC版本的类似。

[Objective-C 版本](https://github.com/DaverZhou/YGRichText)

```
        let string = "YGRichText 富文本库"
        let highlight = "YGRichText"
         
        self.titleLabel.attributedText = string.yg_makeAttributed({ make in
            make.font(UIFont.systemFont(ofSize: 20)).foregroundColor(.red).inRange(of: highlight)
            make.strikethroughStyle().inRange(0, 3)
            make.insertImage(UIImage.init(named: "personal_editor")!, CGRect.init(x: 0, y: 0, width: 15, height: 17), 0).inRange()
        })

```
