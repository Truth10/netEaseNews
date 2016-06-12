//
//  WJWNews.h
//  netEaseNews
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completeBlock)(NSArray *newsList);

@interface WJWNews : NSObject
// 标题
@property (nonatomic, copy) NSString *title;
// 摘要
@property (nonatomic, copy) NSString *digest;
// 图片
@property (nonatomic, copy) NSString *imgsrc;
// 跟贴数
@property (nonatomic, assign) int replyCount;
// 多张配图
@property (nonatomic, strong) NSArray *imgextra;
// 大图标记
@property (nonatomic, assign) BOOL imgType;

// 根据传进来的网址,去网上加载数据,并返回给我们的服务器
+ (void)newsWithURLsting:(NSString *)urlString completeBLock:(completeBlock)completeBlcok;
@end
