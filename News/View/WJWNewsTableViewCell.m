//
//  WJWNewsTableViewCell.m
//  netEaseNews
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "WJWNewsTableViewCell.h"
#import "WJWNews.h"
#import "UIImageView+WebCache.h"
@interface WJWNewsTableViewCell ()
// 新闻标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// 新闻图片
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
// 多张新闻图片
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraImageView;

// 新闻摘要
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
// 评论数目
@property (weak, nonatomic) IBOutlet UILabel *comentCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconViewHeight;

@end

@implementation WJWNewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setNews:(WJWNews *)news{
    _news = news;
    _titleLabel.text = news.title;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    _digestLabel.text = news.digest;
    _comentCountLabel.text = [NSString stringWithFormat:@"%d",news.replyCount];
    // 三张图片
    if (news.imgextra.count == 2) {
        for (NSInteger i=0; i<= 1; i++) {
            NSURL *url = [NSURL URLWithString:news.imgextra[i][@"imgsrc"]];
            
            UIImageView *imageV = self.extraImageView[i];
            [imageV sd_setImageWithURL:url];
        }
    }
    if (news.imgType == YES) {
        if (news.digest.length == 0) {
            self.iconViewHeight.constant = 145;
        }
    }
}
@end
