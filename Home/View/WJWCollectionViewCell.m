//
//  WJWCollectionViewCell.m
//  netEaseNews
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "WJWCollectionViewCell.h"
#import "WJWNewsTableViewController.h"
#import "WJWChannel.h"
@interface WJWCollectionViewCell ()

@property (nonatomic,strong) WJWNewsTableViewController *newsTableVC;
@end

@implementation WJWCollectionViewCell

- (void)awakeFromNib{

    // 1.加载news.storyboard文件
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"news" bundle:nil];
    
    // 2.根据storyboard文件实例化控制器
    self.newsTableVC = [storyboard instantiateViewControllerWithIdentifier:@"newsTableVc"];
    
    // 3.将tableView添加到cell的contentView上
    [self.contentView addSubview:self.newsTableVC.tableView];
    
    // 4.设置frame,如果不设置frame,会导致数据显示不正常,尤其是超出屏幕
    self.newsTableVC.tableView.frame = self.contentView.bounds;
}

- (void)setChannel:(WJWChannel *)channel{
    _channel = channel;
    
    // 将频道模型中拼接好的频道网址,赋值给新闻控制器
    self.newsTableVC.tidURLString = channel.tidURLString;

}

@end
