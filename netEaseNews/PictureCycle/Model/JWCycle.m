//
//  JWCycle.m
//  netEaseNews
//
//  Created by mac on 16/8/28.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "JWCycle.h"
#import "WJWNetWorkTool.h"
@implementation JWCycle
+ (instancetype)cycleWithDict:(NSDictionary *)dict{

    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+ (void)cylcesWithURLsting:(NSString *)urlString completeBLock:(completeBlock)completeBlcok{
    [[WJWNetWorkTool sharedWJWNetWorkTool] objectWithURLString:urlString andFinishedBlock:^(id result) {
        NSDictionary *dict = (NSDictionary *)result;
        // NSLog(@"%@",dict);
        NSArray *dictArr = dict[@"headline_ad"];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dictArr.count];
        [dictArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JWCycle *cycle = [JWCycle cycleWithDict:obj];
            [arrM addObject:cycle];
        }];
        
        // NSLog(@"%@",arrM);
        if (completeBlcok) {
            completeBlcok(arrM.copy);
        }
    }];
}
@end
