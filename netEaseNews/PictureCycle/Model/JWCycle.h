//
//  JWCycle.h
//  netEaseNews
//
//  Created by mac on 16/8/28.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completeBlock)(NSArray *cyclePictures);
@interface JWCycle : NSObject
/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  图片地址
 */
@property (nonatomic,copy) NSString *imgsrc;

/**
 *  根据网址加载网络数据
 *
 *  @param urlString     网址
 *  @param completeBlcok 回调的block
 */
+ (void)cylcesWithURLsting:(NSString *)urlString completeBLock:(completeBlock)completeBlcok;
@end
