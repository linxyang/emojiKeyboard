//
//  KeyboardEmoticon.h
//  YCKeyboardEmotion
//
//  Created by yanglinxia on 16/5/27.
//  Copyright © 2016年 yanglinxia. All rights reserved.
//  表情模型

#import <Foundation/Foundation.h>

@interface KeyboardEmoticon : NSObject

/** 当前表情对应的文字  */
@property (nonatomic, strong) NSString *chs;
/** 当前表情对应的图片名称  */
@property (nonatomic, strong) NSString *png;
/** Emoji表情对应的十六进制字符串  */
@property (nonatomic, strong) NSString *code;


// 下面三个是非模型中的属性
/** id  */
@property (nonatomic, strong) NSString *ID;
/** 图片全路径  */
@property (nonatomic, strong) NSString *imagePath;
/** Emoji表情字符串  */
@property (nonatomic, strong) NSString *codeStr;
/** 是否是删除按钮  */
@property (nonatomic, assign, getter=isRemoveButtonFlag) BOOL removeButtonFlag;
/** 使用次数----处理最近使用  */
@property (nonatomic, assign) NSUInteger count;

- (instancetype)initWithId:(NSString *)Id;

- (instancetype)initWithId:(NSString *)Id removeBtnFlag:(BOOL)removeFlag;

@end
