//
//  KeyboardEmotionViewController.h
//  YCKeyboardEmotion
//
//  Created by yanglinxia on 16/5/27.
//  Copyright © 2016年 yanglinxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardEmoticon.h"

typedef void (^emoticonDidSelectedCallback)(KeyboardEmoticon *emoticon) ;
@interface KeyboardEmotionViewController : UIViewController

- (instancetype)initWithEmoticonDidSelectCallBack:(emoticonDidSelectedCallback)callBack;


@end
