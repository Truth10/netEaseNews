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
@interface WJWHomeViewController ()
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
//    self.channelScrollView.
    
    // 显示频道
    [self setUpChannels];
}

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
