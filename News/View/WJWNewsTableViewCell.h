//
//  WJWNewsTableViewCell.h
//  netEaseNews
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJWNews;
@interface WJWNewsTableViewCell : UITableViewCell

// 存储新闻信息的数据模型
@property (nonatomic,strong) WJWNews *news;
@end
