//
//  WJWHomeViewController.m
//  netEaseNews
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "WJWHomeViewController.h"
#import "WJWChannel.h"
#import "WJWChannelLabel.h"
@interface WJWHomeViewController ()<UICollectionViewDataSource>
/**
 *  频道scrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *channelScrollView;
/**
 *  存储所有频道的数组
 */
@property (nonatomic,strong) NSArray *channels;
/**
 *  新闻collectionView
 */
@property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;
/**
 *  新闻流布局
 */
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *newsFlowLayout;
@end

@implementation WJWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 显示频道
    [self setUpChannels];
    
    // collectionView设置数据源
    self.newsCollectionView.dataSource = self;
    
    // 设置新闻的流布局
    [self setUpCollectionViewFlowLayout];
}

#pragma mark - 显示频道
- (void)setUpChannels{
    // 1.获取频道数组
    self.channels = [WJWChannel channels];

    // 2.创建label
    CGFloat channelLabelW = 80;
    CGFloat channelLabelH = self.channelScrollView.bounds.size.height;
    
    // for循环添加label
    for (NSInteger i=0; i<self.channels.count; i++) {
        // 创建label
        WJWChannelLabel *lable = [[WJWChannelLabel alloc] initWithFrame:CGRectMake(i * channelLabelW, 0, channelLabelW, channelLabelH)];
        
        // 将频道显示在label上
        lable.text = [self.channels[i] tname];
        
        // 给label设置随机颜色
        lable.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        
        // 将label添加到channelScrollView上
        [self.channelScrollView addSubview:lable];
    }

    // 设置channelScrollView的contentSize
    self.channelScrollView.contentSize = CGSizeMake(channelLabelW * self.channels.count, channelLabelH);
}

#pragma mark - 设置collectionView的流布局
- (void)setUpCollectionViewFlowLayout{
    // 设置格子大小
    self.newsFlowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 -44);
    
    // 设置间距
    self.newsFlowLayout.minimumLineSpacing = 0;
    
    // 设置滚动方向
    self.newsFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置分页效果
    self.newsCollectionView.pagingEnabled = YES;
    
}

#pragma mark - collectionView的数据源方法
// 返回格子数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channels.count;
}

// 返回
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    // 1.创建cell
    static NSString *ID = @"news";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
//    if (cell == nil) {
//        cell = [[UICollectionViewCell alloc] initwith];
//    }
    // 2.设置数据
    
    // 3.返回cell
    return cell;
}
@end
