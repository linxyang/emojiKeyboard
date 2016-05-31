//
//  KeyboardEmoticonTextView.h
//  YCKeyboardEmotion
//
//  Created by Yanglixia on 16/6/1.
//  Copyright © 2016年 yanglinxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardEmoticon.h"
@interface KeyboardEmoticonTextView : UITextView

/**
 *  插入表情
 *
 *  @param emoticon 需要插入的表情模型
 */
- (void)insertEmoticon:(KeyboardEmoticon *)emoticon;

/**
 *  获取插入文本内容
 *
 *  @return 内容
 */
- (NSString *)getContentStr;

@end
