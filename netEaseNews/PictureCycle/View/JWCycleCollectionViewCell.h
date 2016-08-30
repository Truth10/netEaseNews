//
//  JWCycleCollectionViewCell.h
//  netEaseNews
//
//  Created by mac on 16/8/28.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JWCycle;
@interface JWCycleCollectionViewCell : UICollectionViewCell
// 轮播数据模型
@property (nonatomic,strong) JWCycle *cycle;
@end
