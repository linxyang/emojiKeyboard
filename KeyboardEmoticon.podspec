Pod::Spec.new do |s|
s.name             = “KeyboardEmoticon”
s.version          = "1.0.0"
s.summary          = "A keyboard view used on iOS."
s.description      = <<-DESC
It is a marquee view used on iOS, which implement by Objective-C.
DESC
s.homepage         = "https://github.com/linxyang/emojiKeyboardDemo"

s.license          = “MIT”
s.license          = { :type => "MIT"， :file => "LICENSE" }
s.author           = { “LinX_Young” => “1217789227@qq.com” }
s.source           = { :git => "https://github.com/linxyang/emojiKeyboardDemo.git", :tag => “1.0.0” }
s.source_files  = "Keyboard"，"emojiKeyboardDemo/.{h，m}"
s.platform     = :ios, ‘7.0’
s.requires_arc = true
s.source_files = "Keyboard/Exclude"
s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'
end