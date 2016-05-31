//
//  KeyboardEmotionPackage.m
//  YCKeyboardEmotion
//
//  Created by yanglinxia on 16/5/27.
//  Copyright © 2016年 yanglinxia. All rights reserved.
//

#import "KeyboardEmotionPackage.h"
#import "KeyboardEmoticon.h"

/************ Emotions.bundle解析 ***********/
/*
 emoticons.plist 字典
 |--packages 数组(每一个元素都是字典)
 |--id key(对应的是每一组表情的文件夹名称)
 
 info.plist 字典
 |--group_name_cn 当前组的名称
 |--emoticons 数组(每一个元素都是字典)
 |--chs 当前表情对应的文字
 |--png 当前表情对应的图片名称
 |--code Emoji表情对应的字符串
 
 记载步骤:
 1.加载emoticons.plist
 2.取出packages对应的数组 --> 拿到所有组表情对应的字典
 3.从数组中取出id对应的字符串 --> 拿到每一组表情的文件夹名称
 
 4.利用文件夹名称拼接一个info.plist路径, 加载info.plist
 5.取出group_name_cn对应的值  --> 拿到当前组的名称
 6.取出emoticons对应的值 --> 拿到当前组的字典数组
 7.遍历当前组的字典数组, 取出每一个表情的数据
 |--chs 当前表情对应的文字
 |--png 当前表情对应的图片名称
 |--code Emoji表情对应的字符串
 */


@implementation KeyboardEmotionPackage

- (instancetype)initWithId:(NSString *)ID
{
    if (self = [super init]) {
        _ID = ID;
    }
    return self;
}

+ (NSArray *)loadPackages
{
    // 添加空的package,以后用来做最近表情
    NSMutableArray<KeyboardEmotionPackage *> *models = [NSMutableArray array];
    KeyboardEmotionPackage *emptyPagkage = [[KeyboardEmotionPackage alloc] initWithId:@"随便写,只要不是真正的id就行"];
    // 添加空的,默认为最近无表情
    [emptyPagkage appendEmptyEmoticons];
    [models addObject:emptyPagkage];
    
    // 获取路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticons.plist" ofType:nil inDirectory:@"Emoticons.bundle"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    // 取出所有组(共3组)
    NSArray *packages = dict[@"packages"];
    
    
    // 遍历
    for (NSDictionary *packageDict in packages) {
        // 创建组模型
        KeyboardEmotionPackage *emoticonPackage = [[KeyboardEmotionPackage alloc] initWithId:packageDict[@"id"]];
        // 加载当前组的所有模型
        [emoticonPackage loadEmoticons];
        // 追加空白按钮
        [emoticonPackage appendEmptyEmoticons];
        // 将当前组添加到数组中
        [models addObject:emoticonPackage];
    }
    return models;
}


- (void)loadEmoticons
{
    // 根据id接接路径
    NSString *path = [[NSBundle mainBundle] pathForResource:self.ID ofType:nil inDirectory:@"Emoticons.bundle"];
    // 拼接info.plist路径
    NSString *filePath = [path stringByAppendingPathComponent:@"info.plist"];
    
    // 加载plist
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    // 取出当前组名
    self.group_name_cn = dict[@"group_name_cn"];
    
    // 取出当前组中的所有的表情"字典数组"
    NSArray *emoticons = dict[@"emoticons"];
    
    // 创建一个用来存放表情模型的数组
    NSMutableArray<KeyboardEmoticon *> *models = [NSMutableArray array];
    
    NSInteger index = 0;
    // 遍历字典转模型
    for (NSDictionary *emoticonDict in emoticons) {
        
        if (index == 20) {
            index = 0;
            // 添加删除
            [models addObject:[[KeyboardEmoticon alloc] initWithId:self.ID removeBtnFlag:YES]];
        }
        
        // 创建组模型
        KeyboardEmoticon *emoticon = [[KeyboardEmoticon alloc] initWithId:self.ID];
        // 加载
        emoticon.chs = emoticonDict[@"chs"];
        emoticon.png = emoticonDict[@"png"];
        emoticon.code = emoticonDict[@"code"];
        [models addObject:emoticon];
        
        index ++;
    }
    
    //将加载的表情赋值给当前组模型
    self.emotions = models;
}

// 追加空白表情,并最后添加删除按钮图片
- (void)appendEmptyEmoticons
{
    if (self.emotions == nil) {
        self.emotions = [NSMutableArray array];
        [self.emotions addObject:[[KeyboardEmoticon alloc] initWithId:@""]];
    }
    
    NSInteger count = self.emotions.count % 21;
    while (count < 20 && count != 0) {
        [self.emotions addObject:[[KeyboardEmoticon alloc] initWithId:self.ID]];
        count ++;
    }
    // 到第二十个,添加删除
    KeyboardEmoticon *cancelEmoticon = [[KeyboardEmoticon alloc] initWithId:self.ID removeBtnFlag:YES];
    [self.emotions addObject:cancelEmoticon];
}


// 添加表情到最近
- (void)addFavoriteEmoticon:(KeyboardEmoticon *)emoticon
{
    if (self.emotions == nil) {
        self.emotions = [NSMutableArray array];
    }
    // 判断表情是否存在
    BOOL flag = [self.emotions containsObject:emoticon];
    // 删除删除按钮,最后再添加回来
    [self.emotions removeLastObject];
    if (!flag) {
        // 删除最后一个表情
        [self.emotions removeLastObject];
        // 添加一个新表情
        [self.emotions addObject:emoticon];
    }

    // 排序
    NSArray *sortArray = [self.emotions sortedArrayUsingComparator:^NSComparisonResult(KeyboardEmoticon *obj1, KeyboardEmoticon *obj2) {
        return obj1.count < obj2.count;//按使用次数排序
    }];
    [self.emotions removeAllObjects];
    [self.emotions addObjectsFromArray:sortArray];//排序后的重新给赋值
    // 添加删除按钮
    [self.emotions addObject:[[KeyboardEmoticon alloc] initWithId:@"" removeBtnFlag:YES]];
}


@end
