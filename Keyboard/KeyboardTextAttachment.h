//
//  KeyboardTextAttachment.h
//  YCKeyboardEmotion
//
//  Created by yanglinxia on 16/5/31.
//  Copyright © 2016年 yanglinxia. All rights reserved.
//  图片对应的文字模型

#import <UIKit/UIKit.h>

@interface KeyboardTextAttachment : NSTextAttachment
/** 当前图片对应的文字  */
@property (nonatomic, strong) NSString *chs;
@end
