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

@property (weak, nonatomic) IBOutlet UILabel *getCotentlabel;
@property (weak, nonatomic) KeyboardEmoticonTextView *custTextView;
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
        KeyboardEmoticonTextView *textView = [[KeyboardEmoticonTextView alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 200)];
        textView.backgroundColor = [UIColor lightGrayColor];
        textView.font = [UIFont systemFontOfSize:20];
        textView.text = @"这一个简单的自定义表情键盘Demo，可以实现emoji与图片表情";
        [self.view addSubview:textView];
        _custTextView = textView;
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
    self.getCotentlabel.text = str;
    NSLog(@"获取到的内容为:%@",str);
}

@end
