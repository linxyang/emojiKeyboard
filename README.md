##说明
这一个简单的自定义表情键盘Demo，可以实现emoji与图片表情

* 最近项目中用到表情键盘这块，于是根据着网上想关资料，写了一个键盘，仅供参考。
* 项目中使用objective-c，参考别人的swift所写。

###效果图如下 
* 弹出与退出键盘

  ![image](https://github.com/linxyang/emojiKeyboardDemo/blob/master/screenshots/1.gif)
 
 * 添加表情
 
   ![image](https://github.com/linxyang/emojiKeyboardDemo/blob/master/screenshots/2.gif)
 
 * 删除表情
 
   ![image](https://github.com/linxyang/emojiKeyboardDemo/blob/master/screenshots/3.gif)
  
 * 获取textView中的内容文字
 
   ![image](https://github.com/linxyang/emojiKeyboardDemo/blob/master/screenshots/4.gif)
###集成方法
1、 把demo中的keyboard文件夹直接拖入你的项目中

```
* 要使用此键盘的控制器中包含这两个类：
 #import "KeyboardEmotionViewController.h"
 #import "KeyboardEmoticonTextView.h"
```
2、分别用上面包含的类创建对应的对象，例如：

```
// 创建表情控制器
- (KeyboardEmotionViewController *)keyboardVc
{
    if (!_keyboardVc) {
        _keyboardVc = [[KeyboardEmotionViewController alloc] initWithEmoticonDidSelectCallBack:^(KeyboardEmoticon *emoticon) {
            //插入表情
            [self.custTextView insertEmoticon:emoticon];
        }];
    }
    return _keyboardVc;
}

//懒加载创建textView(表情键盘响应者)
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
```
3、获取表情textView表情经转换后的文本
  如：`爱你`这个表情转换成`[爱你]`
  
  ```
  拿到textView对象（KeyboardEmoticonTextView类型），调用它的对象方法来获取
  
  NSString *str = [self.custTextView getContentStr];
  ```
  
###结束语
还有很多不好的地方，仅供参考，公分享给大家，提供思路吧。
  

