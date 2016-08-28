//
//  WJWNews.m
//  netEaseNews
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "WJWNews.h"
#import "WJWNetWorkTool.h"
@implementation WJWNews

+(instancetype)newsWithDict:(NSDictionary *)dict{
    id obj = [[self alloc] init];
    
    // 字典转模型
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

- (NSString *)description{
    return [NSString stringWithFormat:@"title:%@--digest:%@--imgextra:%@--imgType:%d",_title,_digest,_imgextra,_imgType];
}

+ (void)newsWithURLsting:(NSString *)urlString completeBLock:(completeBlock)completeBlcok{
    [[WJWNetWorkTool sharedWJWNetWorkTool] objectWithURLString:urlString andFinishedBlock:^(id result) {
        NSDictionary *dict = (NSDictionary *)result;
        
        // 取出第一个key值
        NSString *key = dict.allKeys.firstObject;
        
        // 获取字典数组
        NSArray *dictArr = dict[key];
        
        // 创建可变数组,存储模型
        NSMutableArray *newsList = [NSMutableArray arrayWithCapacity:dictArr.count];
        
        // 遍历字典数组,字典转模型
        [dictArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            WJWNews *new = [WJWNews newsWithDict:obj];
            
            [newsList addObject:new];
        }];
        
        // 通过block传给控制器
        if (completeBlcok) {
            completeBlcok(newsList.copy);
        }

    }];


}
@end
