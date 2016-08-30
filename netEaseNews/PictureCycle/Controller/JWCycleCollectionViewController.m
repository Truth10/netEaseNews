//
//  JWCycleCollectionViewController.m
//  netEaseNews
//
//  Created by mac on 16/8/28.
//  Copyright © 2016年 itheima. All rights reserved.
// http://c.m.163.com/nc/ad/headline/0-4.html

#import "JWCycleCollectionViewController.h"
#import "JWCycle.h"
#import "JWCycleCollectionViewCell.h"

#define KSectionCount 100
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface JWCycleCollectionViewController ()

// 存储轮播数据模型的数组
@property (nonatomic,strong) NSArray <JWCycle *>*cycles;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic,weak) UIPageControl *pageControl;
// 定时器
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation JWCycleCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    // self.automaticallyAdjustsScrollViewInsets = NO;
    
    // [self.collectionView registerClass:[JWCycleCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self loadData];
    
    self.flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    
}


- (void)loadData{
    __weak typeof(self) weakSelf = self;
    [JWCycle cylcesWithURLsting:@"http://c.m.163.com/nc/ad/headline/0-4.html" completeBLock:^(NSArray *cyclePictures) {
        // NSLog(@"加载到数据了");
        weakSelf.cycles = cyclePictures;
        
        [weakSelf.collectionView reloadData];
        
        // 默认选中中间那一组
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:KSectionCount / 2];
        [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        [self timer];
        
        [self setUpPageControl];
        
    }];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return KSectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.cycles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JWCycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];

    JWCycle *cycle = self.cycles[indexPath.item];
    
    cell.cycle = cycle;
    return cell;
}

#pragma mark - 定时器
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        // 添加到主运行循环
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)nextPage{
    NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 中间那组的索引
    NSIndexPath *middleIndexPath = [NSIndexPath indexPathForItem:indexPath.item inSection:(KSectionCount / 2)];
    [self.collectionView scrollToItemAtIndexPath:middleIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    if (middleIndexPath.item != self.cycles.count - 1){
        middleIndexPath = [NSIndexPath indexPathForItem:(indexPath.item +1) inSection:middleIndexPath.section];
    } else{
        middleIndexPath = [NSIndexPath indexPathForItem:0 inSection:middleIndexPath.section+1];
        
    }
    
    [self.collectionView scrollToItemAtIndexPath:middleIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

#pragma mark <UICollectionViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.timer invalidate];
    self.timer = nil;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate == NO) { // 没有降速的过程,直接在此方法中去添加定时器
        [self timer];
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self timer];
    
//    [self scrollViewDidStop];
  
}

//- (void)scrollViewDidStop{
//    
//    NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
//    
//    if (indexPath.section == KSectionCount / 2) {
//        return;
//    }
//    
//    NSIndexPath *index = [NSIndexPath indexPathForItem:indexPath.item inSection:KSectionCount / 2];
//    
//    // 让collectionView不加动画滚动到中间那一组对应的cell去
//    [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
//
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    [self scrollViewDidStop];
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 确定当前页数及组数
    NSInteger currentPage = self.collectionView.contentOffset.x / KScreenWidth;
    NSInteger currentPageIndex = currentPage % self.cycles.count;
   
    self.pageControl.currentPage = currentPageIndex;
}

- (void)setUpPageControl{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    pageControl.center = CGPointMake(KScreenWidth * 0.85, self.collectionView.bounds.size.height - 17);
    pageControl.bounds = CGRectMake(0, 0, 100, 50);
    pageControl.numberOfPages = self.cycles.count; // 一共显示多少个圆点（多少页）
    // 设置非选中页的圆点颜色
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    // 设置选中页的圆点颜色
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    
    // 禁止默认的点击功能
    pageControl.enabled = NO;
    
    [self.view addSubview:pageControl];
    _pageControl = pageControl;
}
@end
