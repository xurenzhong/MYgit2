//
//  XRZInfomationView.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/3/31.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZInfomationView.h"
#import "XRZInfoModel.h"
#import "XRZInfoCell.h"
#import "XRZInfoDetailController.h"
@interface XRZInfomationView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,assign) int page;

@property (nonatomic,assign) int pageIndex;

@end

@implementation XRZInfomationView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeUI];
    
    [self loadData];
    
    [self createCollectionView];
    
    [self addrefresh];
    
}

-(void) addrefresh
{
    __weak typeof(self) weakSelf = self;
    [_collectionView addHeaderWithCallback:^{
        weakSelf.page = 1;
        [weakSelf loadData];
    } dateKey:nil];
    [_collectionView setHeaderPullToRefreshText:@"下拉刷新·······"];
    [_collectionView setHeaderRefreshingText:@"正在刷新·······"];
    [_collectionView setHeaderReleaseToRefreshText:@"页面刷新完成"];
    
    [_collectionView addFooterWithCallback:^{
        weakSelf.page++;
        [weakSelf loadData];
    }];
    [_collectionView setFooterPullToRefreshText:@"下拉刷新·····"];
    [_collectionView setFooterRefreshingText:@"正在刷新······"];
    [_collectionView setFooterReleaseToRefreshText:@"刷新完成"];
}

#pragma mark - 表格代理方法实现
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XRZInfoModel *model = _dataArray[indexPath.row];
    XRZInfoDetailController *detailView = [[XRZInfoDetailController alloc] init];
    detailView.ID = model.ID;
    detailView.pageIndex = _pageIndex;
    [self.navigationController pushViewController:detailView animated:YES];    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XRZInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XRZInfoCell" owner:self options:nil]firstObject];
    }
    XRZInfoModel *model = _dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

#pragma mark - 创建表格视图
-(void) createCollectionView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(150.0/320 * SCREEN_W , 180.0/568 * SCREEN_H);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64-49) collectionViewLayout:flow];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"XRZInfoCell" bundle:nil] forCellWithReuseIdentifier:@"cellID"];
    [self.view addSubview:_collectionView];
    
}

-(void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:Info_main_Url,_pageIndex,_page] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (self.page == 1) {
            [_dataArray removeAllObjects];
        }
        for (NSDictionary *dict in array) {
            XRZInfoModel *model = [[XRZInfoModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            model.ID = dict[@"id"];
            [_dataArray addObject:model];
        }
        [_collectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        _pageIndex = arc4random()%7;
        _page = 1;
    }];
    if (_dataArray == nil) {
        _pageIndex = arc4random()%7;
        [self loadData];
    }
    if (self.page == 1) {
        [_collectionView headerEndRefreshing];
    }else{
        [_collectionView footerEndRefreshing];
    }
}

-(void)makeUI
{
    _pageIndex = arc4random()%7;
    while (_pageIndex == 1 || _pageIndex == 5) {
        _pageIndex = 0;
    }
    _page = 1;
    _dataArray = [NSMutableArray array];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64-49)];
    bgView.image = [UIImage imageNamed:@"info_bg.png"];
    [self.view addSubview:bgView];

}

@end
