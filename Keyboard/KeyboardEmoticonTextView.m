//
//  KeyboardEmoticonTextView.m
//  YCKeyboardEmotion
//
//  Created by Yanglixia on 16/6/1.
//  Copyright © 2016年 yanglinxia. All rights reserved.
//

#import "KeyboardEmoticonTextView.h"
#import "KeyboardTextAttachment.h"
@implementation KeyboardEmoticonTextView

- (void)insertEmoticon:(KeyboardEmoticon *)emoticon
{
    // 插入emoji表情
    if (emoticon.code) { // 判断是否是emoji
        // 获取当前选中的获取,默认光标也是有个选中范围
        UITextRange *range = self.selectedTextRange;
        // 替换文本
        [self replaceRange:range withText:emoticon.codeStr];
    } else if (emoticon.png != nil) {
        
        // 1、根据现在textView上的内容生成一个可变属性字符串
        // 注意:属性字符串有自己默认的大小
        NSMutableAttributedString *attributeStrM = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        
        // 2、创建表情字符串
        KeyboardTextAttachment *attachment = [[KeyboardTextAttachment alloc] init];
        attachment.image = [UIImage imageWithContentsOfFile:emoticon.imagePath];
        attachment.chs = emoticon.chs;
        // 获取文字高度
        CGFloat height = self.font.lineHeight;//文本每行高度
        attachment.bounds = CGRectMake(0,-4,height,height);
        // 根据附件创建一个属性字符串
        NSAttributedString *emoticonStr = [NSAttributedString attributedStringWithAttachment:attachment];
        NSLog(@"%zd",emoticonStr.length);
        // 3、将输入字符串插入到光标所在的位置
        NSRange range = [self selectedRange];
        [attributeStrM replaceCharactersInRange:NSMakeRange(range.location,range.length) withAttributedString:emoticonStr];
        // 因为后面的一个会参照前面的大小,所以每次设置完毕之后都需要重新设置一次前面一个的大小
        [attributeStrM addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(range.location,1)];
        
        // 将新的字符串设置给textView
        self.attributedText = attributeStrM;
        
        // 重新设置光标所在的位置
        self.selectedRange = NSMakeRange(range.location+1,0);
        
    }
    
    // 处理删除
    if (emoticon.isRemoveButtonFlag) {
        [self deleteBackward];
    }
}

- (NSString *)getContentStr
{
    NSMutableString *stringM = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSString *,id> * attrs, NSRange range, BOOL * _Nonnull stop) {
        /*
         // 传入的range就是字符串和表情范围, 如果没有表情则不会断开, 如果有表情就会断开
         // 例如 123😘123  -->  (0,3)(3,1)(4,3)
         //      123123    --> (0, 6)
         let res = (self.customTextView.attributedText.string as NSString).substringWithRange(range)
         print(res)
         */
        
        /*
         传入的字典中如果包含NSAttachment证明是表情, 并且字典中传入的NSAttachment和当初插入表情时创建的NSAttachment是以同一个NSAttachment
         */
        KeyboardTextAttachment *attachment = attrs[@"NSAttachment"];//取出富文本中的附件
        NSString *string = nil;
        if (attachment != nil) {
            // 表情
            string = [NSString stringWithFormat:@"%@",attachment.chs];
        } else {
            // 广本
            string = [NSString stringWithFormat:@"%@",[self.attributedText.string substringWithRange:range]];
        }
        [stringM appendFormat:@"%@",string];
    }];
    return stringM;
}

@end
