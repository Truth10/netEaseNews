//
//  WJWNewsTableViewController.m
//  netEaseNews
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "WJWNewsTableViewController.h"
#import "WJWNews.h"
#import "WJWNewsTableViewCell.h"
@interface WJWNewsTableViewController ()

@property (nonatomic,strong) NSArray *innerNewsList;
@end

@implementation WJWNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

#pragma mark - 重写tidURLString的set方法
- (void)setTidURLString:(NSString *)tidURLString{

    _tidURLString = tidURLString;
    __weak typeof(self) weakSelf = self;
    [WJWNews newsWithURLsting:tidURLString completeBLock:^(NSArray *newsList) {
        // NSLog(@"newslist:%@",newsList);
        
        weakSelf.innerNewsList = newsList;
        
        [self.tableView reloadData];
    }];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.innerNewsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 先获取数据模型
    WJWNews *news = self.innerNewsList[indexPath.row];
    static NSString *ID = nil;
    if (news.imgType == YES) {
        ID = @"bigImageCell";
    }else if(news.imgextra.count == 2){
        ID = @"threeImageCell";
    }else{
        ID = @"baseImageCell";
    }
    
    WJWNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.news = news;
    
    return cell;
}

// 设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 先获取数据模型
    WJWNews *news = self.innerNewsList[indexPath.row];
    if (news.imgType == YES) {
        return 185;
    }else if(news.imgextra.count == 2){
        return 120;
    }else{
        return 90;
    }
}

@end
