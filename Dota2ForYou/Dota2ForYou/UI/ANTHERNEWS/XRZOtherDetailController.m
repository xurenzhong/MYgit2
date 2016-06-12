//
//  XRZOtherDetailController.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/11.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZOtherDetailController.h"
#import "XRZOtherModel.h"
#import "XRZOtherHeadModel.h"
#import "XRZOtherCell.h"
#import "XRZGameDetail.h"
@interface XRZOtherDetailController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *headArray;

@property (nonatomic,copy) NSString *urlStr;

@property (nonatomic,strong) UIScrollView *subScrollView;

@property (nonatomic,strong) UIPageControl *page;

@property (nonatomic,assign) int pageIndex;

@end

@implementation XRZOtherDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self readyInit];
    
    [self loadData];
    
    [self createTableView];
    
}
#pragma mark - 创建滚动视图
-(void)headScrollView
{
    _subScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H * 140 / 568)];
    _subScrollView.tag = 16;
    self.subScrollView.pagingEnabled = YES;
    _subScrollView.contentSize = CGSizeMake(SCREEN_W * (_headArray.count+2), SCREEN_H * 140 / 568);
    _subScrollView.userInteractionEnabled = YES;
    _subScrollView.delegate = self;
    for (int i = 0; i < _headArray.count; i++){
        XRZOtherHeadModel *model = _headArray[i];
        if (i == 0 && _headArray.count > 1) {
            UIImageView *img_i = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H * 140/568)];
            XRZOtherHeadModel *model_i = _headArray[_headArray.count - 1];
            [img_i sd_setImageWithURL:[NSURL URLWithString:model_i.litpic]];
            [_subScrollView addSubview:img_i];
        }
        if (i == _headArray.count - 1 && _headArray.count > 1) {
            UIImageView *img_i = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W * (_headArray.count + 1), 0, SCREEN_W, SCREEN_H * 140/568)];
            XRZOtherHeadModel *model_0 = _headArray[0];
            [img_i sd_setImageWithURL:[NSURL URLWithString:model_0.litpic]];
            [_subScrollView addSubview:img_i];
        }
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W * (i+1), 0, SCREEN_W, SCREEN_H * 140/568)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailScroll)];
        imgView.userInteractionEnabled = YES;
        [imgView addGestureRecognizer:tap];
        [imgView sd_setImageWithURL:[NSURL URLWithString:model.litpic] placeholderImage:[UIImage imageNamed:@"BannerLoading.png"]];
        [_subScrollView addSubview:imgView];
    }
    _subScrollView.showsHorizontalScrollIndicator = NO;
    _subScrollView.showsVerticalScrollIndicator = NO;
    _subScrollView.contentOffset = CGPointMake(SCREEN_W, 0);
    _tableView.tableHeaderView = _subScrollView;
    if (_headArray.count > 1) {
        _page = [[UIPageControl alloc] init];
        _page.frame = CGRectMake(SCREEN_W/4, _subScrollView.frame.size.height - 40, SCREEN_W/4, 20);
        _page.center = CGPointMake(SCREEN_W/2, _subScrollView.frame.size.height - 20);
        _page.numberOfPages = _headArray.count;
        [_tableView addSubview:_page];
    }
}

-(void)detailScroll
{
    NSInteger number = _subScrollView.contentOffset.x / SCREEN_W - 1;
    XRZOtherHeadModel *model = _headArray[number];
    XRZGameDetail *gameView = [[XRZGameDetail alloc] init];
    gameView.headModel = model;
    gameView.title = @"详情";
    [self.navigationController pushViewController:gameView animated:YES];

}

#pragma mark - 滚动视图代理方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_dataArray removeObjectAtIndex:indexPath.row];
    [_tableView reloadData];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger number = _subScrollView.contentOffset.x / SCREEN_W - 1;
    if (number == -1) {
        _subScrollView.contentOffset = CGPointMake(SCREEN_W * _headArray.count, 0);
        number = _headArray.count - 1;
    }
    if (number == _headArray.count) {
        _subScrollView.contentOffset = CGPointMake(SCREEN_W, 0);
        number = 0;
    }
    _page.currentPage = number;
}

#pragma mark - 表格视图代理实现
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRZOtherModel *model = _dataArray[indexPath.row];
    XRZGameDetail *gameView = [[XRZGameDetail alloc] init];
    gameView.otherModel = model;
    gameView.title = @"详情";
    [self.navigationController pushViewController:gameView animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRZOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XRZOtherCell" owner:self options:nil]firstObject];
    }
    XRZOtherModel *selfmodel = _dataArray[indexPath.row];
    cell.model = selfmodel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(void) createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)loadData
{
    if ([self.title isEqualToString:@"魔兽世界"]) {
        _urlStr = Other_wow_Url;
    }
    if ([self.title isEqualToString:@"风暴英雄"]) {
        _urlStr = Other_wind_Url;
    }
    if ([self.title isEqualToString:@"炉石传说"]) {
        _urlStr = Other_stone_Url;
    }
    if ([self.title isEqualToString:@"星际2"]) {
        _urlStr = Other_star_Url;
    }
    if ([self.title isEqualToString:@"幻化"]) {
        _urlStr = Other_cosplay_Url;
    }
    if ([self.title isEqualToString:@"守望先锋"]) {
        _urlStr = Other_watch_Url;
    }
    if ([self.title isEqualToString:@"攻略"]) {
        _urlStr = Other_idea_Url;
    }
    if ([self.title isEqualToString:@"暗黑破坏神3"]) {
        _urlStr = Other_dark_Url;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:_urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *supDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *subDict = supDict[@"data"];
        NSArray *head_arr = subDict[@"indexpic"];
        NSArray *list_arr = subDict[@"list"];
        for (NSDictionary *dict_1 in head_arr) {
            XRZOtherHeadModel *model = [[XRZOtherHeadModel alloc] init];
            [model setValuesForKeysWithDictionary:dict_1];
            [_headArray addObject:model];
        }
        for (NSDictionary *dict_2 in list_arr) {
            XRZOtherModel *model = [[XRZOtherModel alloc] init];
            [model setValuesForKeysWithDictionary:dict_2];
            [_dataArray addObject:model];
        }
        if (_headArray.count >= 1) {
        [self headScrollView];
        }
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"下载数据失败");
    }];
}
-(void)readyInit
{
    _pageIndex = 0;
    _dataArray = [NSMutableArray array];
    _headArray = [NSMutableArray array];
}

-(void)setNav
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:nil image:[UIImage imageNamed:@"common_back_button.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        self.tabBarController.tabBar.hidden = NO;
        self.tabBarController.tabBar.translucent = NO;
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    XRZMyButton *rightButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake( SCREEN_W*(320 - 65)/320, 0, 65, 35) title:@"编辑" image:nil bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        
        self.tableView.allowsMultipleSelectionDuringEditing = YES;
        
        self.tableView.editing = !self.tableView.editing;
        
        if (self.tableView.editing) {
            
            rightButton.hidden = NO; 
            
            [button setTitle:@"完成" forState:UIControlStateNormal];
            
        }else{
            
            rightButton.hidden = YES;
            
            [button setTitle:@"删除" forState:UIControlStateNormal];
            
        }
        

        
    }];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}
@end
