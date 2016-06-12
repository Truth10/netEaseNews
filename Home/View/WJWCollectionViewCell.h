//
//  WJWCollectionViewCell.h
//  netEaseNews
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJWChannel;
@interface WJWCollectionViewCell : UICollectionViewCell

// 频道模型
@property (nonatomic,strong) WJWChannel *channel;
@end
