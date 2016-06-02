//
//  KeyboardEmotionViewController.m
//  YCKeyboardEmotion
//
//  Created by yanglinxia on 16/5/27.
//  Copyright © 2016年 yanglinxia. All rights reserved.
//

#import "KeyboardEmotionViewController.h"
#import "KeyboardEmotionCollectionViewCell.h"
#import "KeyboardEmotionPackage.h"

@interface KeyboardEmotionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 键盘表情视图  */
@property (nonatomic, strong) UICollectionView *collectionView;
/** 工具条  */
@property (nonatomic, strong) UIToolbar *toolBar;
/** 包  */
@property (nonatomic, strong) NSArray *emoticonPackages;
/** 回调  */
@property (nonatomic, copy) emoticonDidSelectedCallback emoticonDidSelectCallBack;
@end

@implementation KeyboardEmotionViewController

#pragma mark - 懒加载

- (NSArray *)emoticonPackages
{
    if (!_emoticonPackages) {
        _emoticonPackages = [KeyboardEmotionPackage loadPackages];
    }
    return _emoticonPackages;
}

/// 键盘中表情视图容器
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平滚动
        CGFloat width = kScreenWidth / 7.0;//一行显示7个
        layout.itemSize = CGSizeMake(width,width);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[KeyboardEmotionCollectionViewCell class] forCellWithReuseIdentifier:@"KeyboardEmotionViewCell"];
    }
    return  _collectionView;
}

// 表情底部工具条
- (UIToolbar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] init];
        _toolBar.tintColor = [UIColor darkGrayColor];
        NSMutableArray<UIBarButtonItem *> *items = [NSMutableArray array];
        NSArray *titles = @[@"最近",@"默认",@"Emoji",@"浪小花"];
        NSInteger index = 0;
        for (NSString *title in titles) {
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(itemBtnClick:)];
            item.tag = index++;
            [items addObject:item];
            UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            [items addObject:flexItem];
        }
        // 移除最后一个flexItem
        [items removeLastObject];
        _toolBar.items = items;
    }
    return _toolBar;
}

#pragma mark - 生命周期
- (instancetype)initWithEmoticonDidSelectCallBack:(emoticonDidSelectedCallback)callBack
{
    if (self = [super init]) {
        _emoticonDidSelectCallBack = callBack;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
}


- (void)dealloc
{
    NSLog(@"键盘控制器死掉了...");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"键盘控制器要显示了...");
}

- (void)setupUI
{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.toolBar];
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 布局AFL
    NSDictionary *dict = @{@"collectionView": self.collectionView,
                           @"toolBar": self.toolBar};
    
    NSArray *cons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[collectionView]-0-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:dict];
    NSArray *cons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[toolBar]-0-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:dict];
    NSArray *cons3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[collectionView]-[toolBar(44)]-0-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:dict];
    NSMutableArray *cons = [NSMutableArray array];
    [cons addObjectsFromArray:cons1];
    [cons addObjectsFromArray:cons2];
    [cons addObjectsFromArray:cons3];
    [self.view addConstraints:cons];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // 在iphone4s上乘0.5会有问题
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 7.0;
    CGFloat margin = (_collectionView.frame.size.height - 3*width) * 0.49;
    _collectionView.contentInset = UIEdgeInsetsMake(margin, 0, margin, 0);
}

#pragma mark - UICollectionView datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.emoticonPackages.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    KeyboardEmotionPackage *package = self.emoticonPackages[section];
    return package.emotions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KeyboardEmotionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KeyboardEmotionViewCell" forIndexPath:indexPath];
//    cell.backgroundColor = ( indexPath.item % 2 == 0 )? [UIColor redColor] : [UIColor purpleColor];
    KeyboardEmotionPackage *package = self.emoticonPackages[indexPath.section];
    cell.emoticon = package.emotions[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell中的collectionView的cell的第:%zd个item",indexPath.item);
    KeyboardEmotionPackage *package = self.emoticonPackages[indexPath.section];
    KeyboardEmoticon *emoticon = package.emotions[indexPath.item];
    
    //将表情放入最近
    if(!emoticon.isRemoveButtonFlag){
        if (indexPath.section != 0) {
            emoticon.count += 1;//统计使用次数
            KeyboardEmotionPackage *package = self.emoticonPackages[0];
            [package addFavoriteEmoticon:emoticon];
            // 刷新表格
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }
    }
    !_emoticonDidSelectCallBack?:_emoticonDidSelectCallBack(emoticon);
    
}

#pragma mark - 点击工具条
- (void)itemBtnClick:(UIBarButtonItem *)item
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:item.tag];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


@end
