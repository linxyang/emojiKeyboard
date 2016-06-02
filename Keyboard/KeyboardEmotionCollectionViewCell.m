//
//  KeyboardEmotionCollectionViewCell.m
//  YCKeyboardEmotion
//
//  Created by yanglinxia on 16/5/27.
//  Copyright © 2016年 yanglinxia. All rights reserved.
//

#import "KeyboardEmotionCollectionViewCell.h"

@interface KeyboardEmotionCollectionViewCell()
@property (nonatomic, strong) UIButton *iconButton;
@end

@implementation KeyboardEmotionCollectionViewCell

- (UIButton *)iconButton
{
    if (!_iconButton) {
        _iconButton = [[UIButton alloc] init];
        _iconButton.backgroundColor = [UIColor whiteColor];
        _iconButton.titleLabel.font = [UIFont systemFontOfSize:32];
        _iconButton.userInteractionEnabled = NO;
    }
    return _iconButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.iconButton];
        self.iconButton.frame = CGRectInset(self.contentView.bounds, 4, 4);
    }
    return self;
}

- (void)setEmoticon:(KeyboardEmoticon *)emoticon
{
    _emoticon = emoticon;
    
    // 图片表情
    UIImage *image = [UIImage imageWithContentsOfFile:emoticon.imagePath];
    [_iconButton setImage:image forState:UIControlStateNormal];
    
    // emoji表情
    [_iconButton setTitle:emoticon.codeStr forState:UIControlStateNormal];
    
    // 3.删除按钮
    if(emoticon.isRemoveButtonFlag)
    {
        [_iconButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [_iconButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
    }
}

@end
