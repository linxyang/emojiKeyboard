//
//  ViewController.m
//  YCKeyboardEmotion
//
//  Created by yanglinxia on 16/5/27.
//  Copyright © 2016年 yanglinxia. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardEmotionViewController.h"
#import "KeyboardEmoticonTextView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet KeyboardEmoticonTextView *custTextView;
@property (strong, nonatomic) KeyboardEmotionViewController *keyboardVc;
@end

@implementation ViewController

- (KeyboardEmotionViewController *)keyboardVc
{
    if (!_keyboardVc) {
        _keyboardVc = [[KeyboardEmotionViewController alloc] initWithEmoticonDidSelectCallBack:^(KeyboardEmoticon *emoticon) {
            // 插入表情
            [self.custTextView insertEmoticon:emoticon];
        }];
    }
    return _keyboardVc;
}

- (KeyboardEmoticonTextView *)custTextView
{
    if (!_custTextView) {
        _custTextView = [[KeyboardEmoticonTextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,200)];
    }
    return _custTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.keyboardVc];
    self.custTextView.inputView = self.keyboardVc.view;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}


// 获取图片所有表情内容(非emoji)
- (IBAction)getText:(UIButton *)sender {
    
    NSString *str = [self.custTextView getContentStr];
    
    NSLog(@"获取到的内容为:%@",str);
}

@end
