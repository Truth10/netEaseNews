//
//  WJWChannel.m
//  netEaseNews
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "WJWChannel.h"

@implementation WJWChannel

- (void)setTid:(NSString *)tid{
    _tid = tid;
    
    //生成我对应频道的URLString
    if ([_tid isEqualToString:@"T1348647853363"]) {//头条
        _tidURLString = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html";
    }else{
        _tidURLString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/%@/0-20.html",_tid];
    }

    // NSLog(@"tidURLString:%@",_tidURLString);
}

#pragma mark - 字典转模型
+ (instancetype)channelWithDict:(NSDictionary *)dict{
    id obj = [[self alloc] init];

    // KVC字典转模型
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

#pragma mark - 解决key值与模型属性值不匹配的问题
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

};

#pragma mark - 重写description方法
- (NSString *)description{
    return [NSString stringWithFormat:@"tid:%@---tname:%@---tidURLString:%@",_tid,_tname,_tidURLString];
}

#pragma mark - 将json数据转为模型
+ (NSArray *)channels{

    // 获取路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    
    // json转二进制
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    // 序列化
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];

    // 取出字典数组
    NSArray *dictArr = dict[@"tList"];
    
    // 定义可变数组,存储模型
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dictArr.count];
    
    // 遍历数组,字典转模型
    [dictArr enumerateObjectsUsingBlock:^(NSDictionary  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 字典转模型
        WJWChannel *channel = [WJWChannel channelWithDict:obj];
        
        [arrM addObject:channel];
    }];
    
    // 根据tid从小到大排序
    [arrM sortUsingComparator:^NSComparisonResult(WJWChannel * _Nonnull obj1, WJWChannel * _Nonnull obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    return arrM.copy;
}
@end
