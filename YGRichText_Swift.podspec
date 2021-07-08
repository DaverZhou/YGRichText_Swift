Pod::Spec.new do |spec|
  spec.name         = "YGRichText_Swift"
  spec.version      = "1.0.2"
  spec.summary      = "链式设置富文本"

  spec.description  = <<-DESC
    基于链式编程，点语法的简易调用设置富文本，达到自由灵活搭配。
    pod 'YGRichText_Swift'
                   DESC
                   
  spec.homepage     = "https://github.com/DaverZhou"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "DaverZhou" => "daverzhou98@gmail.com" }
  spec.source       = { :git => "https://github.com/DaverZhou/YGRichText_Swift.git", :tag => "#{spec.version}" }

  spec.ios.deployment_target    = "10.0"

  spec.source_files        = "Classes/**/*.swift"

  spec.requires_arc = true

  spec.swift_version            = '5.0'

  
end
