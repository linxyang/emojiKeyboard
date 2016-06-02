//
//  KeyboardEmotionCollectionViewCell.h
//  YCKeyboardEmotion
//
//  Created by yanglinxia on 16/5/27.
//  Copyright © 2016年 yanglinxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardEmoticon.h"
@interface KeyboardEmotionCollectionViewCell : UICollectionViewCell
/** 表情模型  */
@property (nonatomic, strong) KeyboardEmoticon *emoticon;
@end
