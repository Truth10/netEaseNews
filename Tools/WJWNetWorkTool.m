//
//  WJWNetWorkTool.m
//  netEaseNews
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "WJWNetWorkTool.h"

@implementation WJWNetWorkTool

#if DEBUG
static NSString *BaseURLString = @"http://c.m.163.com/";
#else
static NSString *BaseURLString = @"http://xxxxxxxxx/";
#endif


+ (instancetype)sharedWJWNetWorkTool{
    static dispatch_once_t onceToken;
    static WJWNetWorkTool *_instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
        
         // 该默认响应方式支持的类型
        _instance.responseSerializer.acceptableContentTypes = [_instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
    });
    
   
    return _instance;
}

- (void)objectWithURLString:(NSString *)URLString andFinishedBlock:(finishBlock)finishblock{

    // AFN去发送网络请求
    [self GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 通过block传递给模型
        if (finishblock) {
            finishBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",[error localizedDescription]);
    }];
}
@end
