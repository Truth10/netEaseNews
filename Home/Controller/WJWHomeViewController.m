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
#import "WJWCollectionViewCell.h"

// 频道标签的宽度
#define ChannelLabelWidth 80
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
@interface WJWHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
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
/**
 *  被选中的频道
 */
@property (nonatomic,weak) UILabel *selectedChannelLabel;
/**
 *  存储所有频道标签的数组
 */
@property (nonatomic,strong) NSArray<UILabel *> *channelLabels;
@end

@implementation WJWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 用来解决scrollView遇到导航控制器时，内容向下移动64的问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 显示频道
    [self setUpChannels];
    
    // collectionView设置数据源
    self.newsCollectionView.dataSource = self;
    self.newsCollectionView.delegate = self;
    
    self.channelScrollView.delegate = self;
    
    // 设置新闻的流布局
    [self setUpCollectionViewFlowLayout];
    // NSLog(@"%@",self.channelLabels[0]);
    
    self.selectedChannelLabel = self.channelLabels[0];
    [self selectChannelLabel:self.channelLabels[0]];
}

#pragma mark - 显示频道
- (void)setUpChannels{
    // 1.获取频道数组
    self.channels = [WJWChannel channels];
    
    // 2.创建label
    CGFloat channelLabelW = ChannelLabelWidth;
    CGFloat channelLabelH = self.channelScrollView.bounds.size.height;
    
    NSMutableArray *arrM = [NSMutableArray array];
    // for循环添加label
    for (NSInteger i=0; i<self.channels.count; i++) {
        // 创建label
        WJWChannelLabel *lable = [[WJWChannelLabel alloc] initWithFrame:CGRectMake(i * channelLabelW, 0, channelLabelW, channelLabelH)];
        
        // 将频道显示在label上
        lable.text = [self.channels[i] tname];
        
        // 给label设置随机颜色
        // lable.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        
        lable.tag = i;
        lable.userInteractionEnabled = YES;
        
        // 给lable添加点按的手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [lable addGestureRecognizer:tap];
        
        // 将label添加到channelScrollView上
        [self.channelScrollView addSubview:lable];
        [arrM addObject:lable];
    }
    self.channelLabels = arrM.copy;
    
    // 设置channelScrollView的contentSize
    self.channelScrollView.contentSize = CGSizeMake(channelLabelW * self.channels.count, channelLabelH);
}

- (void)tapAction:(UITapGestureRecognizer *)recognizer{
    
    // 让对应频道的label居中显示，字体变大并变为红色
    if (self.selectedChannelLabel == (UILabel *)recognizer.view) {
        return;
    }
    self.selectedChannelLabel.font = [UIFont systemFontOfSize:17];
    self.selectedChannelLabel.textColor = [UIColor blackColor];
    if (recognizer.view.tag != self.selectedChannelLabel.tag) {
        
        UILabel *label = (UILabel *)recognizer.view;

        [self selectChannelLabel:label];
        
        self.selectedChannelLabel = label;
    }
    // 选中对应的频道的cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:recognizer.view.tag inSection:0];
    [self.newsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];

}

- (void)selectChannelLabel:(UILabel *)label{
   
    label.font =  [UIFont systemFontOfSize:20];
    label.textColor = [UIColor redColor];
    
    // 让频道标签居中
    CGFloat labelX = label.tag * ChannelLabelWidth;
    CGFloat middleX = (KScreenWidth - ChannelLabelWidth) / 2;
    if ((labelX - middleX > 0) && (labelX < (self.channels.count * ChannelLabelWidth - KScreenWidth + middleX)) ) {
        
        self.channelScrollView.contentOffset = CGPointMake(labelX - middleX, 0);
    }
}
#pragma mark - scrollView的代理方法，监听channelScrollView的滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//     NSLog(@"%f",self.channelScrollView.contentOffset.x);
    NSInteger index = self.newsCollectionView.contentOffset.x / KScreenWidth;
    if (self.selectedChannelLabel == self.channelLabels[index]) {
        return;
    }
    self.selectedChannelLabel.font = [UIFont systemFontOfSize:17];
    self.selectedChannelLabel.textColor = [UIColor blackColor];
    if (self.selectedChannelLabel != self.channelLabels[index]) {
        
        [self selectChannelLabel:self.channelLabels[index]];
        self.selectedChannelLabel = self.channelLabels[index];
    }

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

// 返回每一个格子的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 1.创建cell
    //cell循环利用
    
    static NSString *ID = @"news";
    WJWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    
    // 2.cell循环利用
    WJWChannel *channel = self.channels[indexPath.item
                                        ];
#warning mark - 此处cell显示的类型并不是WJWCollectionViewCell,而是UICollectionViewCell
    // MARK: - bug解决方法,将main.storyboard中的cell的类与自定义的类关联即可
    cell.channel = channel;
    
    // 3.返回cell
    return cell;
}

#pragma mark - 选中某一个cell的代理方法
//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.selectedChannelLabel == self.channelLabels[indexPath.item]) {
//        return;
//    }
//    self.selectedChannelLabel.font = [UIFont systemFontOfSize:17];
//    self.selectedChannelLabel.textColor = [UIColor blackColor];
//    if (self.selectedChannelLabel != self.channelLabels[indexPath.item]) {
//        
//        [self selectChannelLabel:self.channelLabels[indexPath.item]];
//        self.selectedChannelLabel = self.channelLabels[indexPath.item];
//    }
//
//
//}

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    // NSLog(@"%ld",(long)indexPath.item);
//    // 让对应频道的label居中显示，字体变大并变为红色
//    if (self.selectedChannelLabel == self.channelLabels[indexPath.item]) {
//        return;
//    }
//    self.selectedChannelLabel.font = [UIFont systemFontOfSize:17];
//    self.selectedChannelLabel.textColor = [UIColor blackColor];
//    if (self.selectedChannelLabel != self.channelLabels[indexPath.item]) {
//        
//        [self selectChannelLabel:self.channelLabels[indexPath.item]];
//        self.selectedChannelLabel = self.channelLabels[indexPath.item];
//    }
//}
@end
