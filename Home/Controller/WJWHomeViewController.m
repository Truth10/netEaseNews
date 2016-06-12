//
//  WJWHomeViewController.m
//  netEaseNews
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "WJWHomeViewController.h"

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
    
    // 显示频道
    [self setUpChannels];
}

- (void)setUpChannels{


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
