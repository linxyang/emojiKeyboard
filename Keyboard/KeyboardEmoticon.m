//
//  KeyboardEmoticon.m
//  YCKeyboardEmotion
//
//  Created by yanglinxia on 16/5/27.
//  Copyright © 2016年 yanglinxia. All rights reserved.
//

#import "KeyboardEmoticon.h"

@implementation KeyboardEmoticon

- (instancetype)initWithId:(NSString *)Id
{
    self = [super init];
    if (self) {
        _ID = Id;
    }
    return self;
}

// 创建一个是删除按钮
- (instancetype)initWithId:(NSString *)Id removeBtnFlag:(BOOL)removeFlag
{
    if (self = [super init]) {
        _ID = Id;
        if (removeFlag == 0) {
            _removeButtonFlag = NO;
        } else {
            _removeButtonFlag = removeFlag;
        }
    }
    return self;
}

- (void)setPng:(NSString *)png
{
    if (png == nil) {
        return;
    }
    _png = png;
    
    // 获取对应组的文件夹路径
    NSString *path = [[NSBundle mainBundle] pathForResource:self.ID ofType:nil inDirectory:@"Emoticons.bundle"];
    _imagePath = [path stringByAppendingPathComponent:png];

}

- (void)setCode:(NSString *)code
{
    _code = code;
    NSString *str = code ? code:@"";//0x1f603
    UInt32 unicodeIntValue= (UInt32)strtoul([str UTF8String],0,16);//转为无符号长整形
    UTF32Char inputChar = unicodeIntValue;
    inputChar = NSSwapHostIntToLittle(inputChar);
    NSString *sendStr = [[NSString alloc] initWithBytes:&inputChar length:4 encoding:NSUTF32LittleEndianStringEncoding];
    _codeStr = sendStr;
    
}



@end
