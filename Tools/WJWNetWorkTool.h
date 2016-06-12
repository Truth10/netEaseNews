//
//  WJWNetWorkTool.h
//  netEaseNews
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void(^finishBlock)(id result);
@interface WJWNetWorkTool : AFHTTPSessionManager

// 获取单例的方法
+ (instancetype)sharedWJWNetWorkTool;

// 供所有模型调用的方法,模型传进来URLString和回调,当从网络上回来结果之后,~~传给模型
- (void)objectWithURLString:(NSString *)URLString andFinishedBlock:(finishBlock)finishblock;
@end
