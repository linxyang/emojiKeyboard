//
//  KeyboardEmotionPackage.h
//  YCKeyboardEmotion
//
//  Created by yanglinxia on 16/5/27.
//  Copyright © 2016年 yanglinxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyboardEmoticon;

@interface KeyboardEmotionPackage : NSObject

/** 当前组对应的文件夹名称  */
@property (nonatomic, strong) NSString *ID;
/** 当前组的名称  */
@property (nonatomic, strong) NSString *group_name_cn;
/** 当前组所有的模型  */
@property (nonatomic, strong) NSMutableArray<KeyboardEmoticon *> *emotions;

+ (NSArray *)loadPackages;

// 添加表情到最近
- (void)addFavoriteEmoticon:(KeyboardEmoticon *)emoticon;

@end
