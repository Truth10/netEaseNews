//
//  JWCycleCollectionViewCell.m
//  netEaseNews
//
//  Created by mac on 16/8/28.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "JWCycleCollectionViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "JWCycle.h"

@interface JWCycleCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JWCycleCollectionViewCell

- (void)setCycle:(JWCycle *)cycle{
    _cycle = cycle;
   
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:cycle.imgsrc]];
    self.titleLabel.text = cycle.title;
}

@end
