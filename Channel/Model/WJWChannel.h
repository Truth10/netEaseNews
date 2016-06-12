//
//  WJWChannel.h
//  netEaseNews
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJWChannel : NSObject
/**
 * 频道的id
 */
@property (nonatomic,copy) NSString *tid;
/**
 *  频道的名称
 */
@property (nonatomic,copy) NSString *tname;
/**
 *  频道网址,且是只读
 */
@property (nonatomic,copy,readonly) NSString *tidURLString;

+ (NSArray *)channels;
@end
