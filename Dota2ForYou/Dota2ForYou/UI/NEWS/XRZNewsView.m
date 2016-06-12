//
//  XRZNewsView.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/3/31.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZNewsView.h"
#import "InfoScrollerModel.h"
#import "XRZNewsModel.h"
#import "XRZNesCell.h"
#import "XRZNewsRootView.h"
#import "XRZNewsDetailController.h"
@interface XRZNewsView ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
/** 头部视图栏*/
@property (nonatomic,strong) UIView *headView;
/** 主滚动视图*/
@property (nonatomic,strong) UIScrollView *supscrollView;
/** 头部滚动视图数据*/
@property (nonatomic,strong) NSMutableArray *subDataArray;
/** 表格视图数据*/
@property (nonatomic,strong) NSMutableArray *dataArray;
/** 头部滚动视图*/
@property (nonatomic,strong) UIScrollView *subScrollView;
/** 小白点*/
@property (nonatomic,strong) UIPageControl *page;
/** 刷新页面页码*/
@property (nonatomic,assign) int pageIndex;



@end

@implementation XRZNewsView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 数据初始化*/
    [self readyInit];
    
    /** 创建头部button*/
    [self createHeadView];
    
    /** 创建滚动视图*/
    [self createsupScrollview];
    
    /** 第一页滚动视图数据*/
    [self loadHeadScrollViewData];
    
    /** 创建表格视图*/
    [self createTableView];
    
    /** 添加上下拉刷新*/
    [self addRefresh];
    
}
-(void) viewWillAppear:(BOOL)animated
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if(myDelegate.startFlag == 1){
        [NSThread sleepForTimeInterval:2.5];
    }
}

-(void) viewWillDisappear:(BOOL)animated
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.startFlag++;
}

#pragma mark - 添加上下拉刷新
-(void)addRefresh
{
    for (int i = 0; i < 4; i++) {
    __weak typeof(self) weakSelf = self;
        UITableView *tableView = [self.view viewWithTag:300+i];
    [tableView addHeaderWithCallback:^{
        weakSelf.pageIndex = 1;
        [weakSelf loadTableViewData];
    } dateKey:nil];
    [tableView setHeaderPullToRefreshText:@"下拉刷新·······"];
    [tableView setHeaderRefreshingText:@"正在刷新·······"];
    [tableView setHeaderReleaseToRefreshText:@"页面刷新完成"];
    
    [tableView addFooterWithCallback:^{
        weakSelf.pageIndex++;
        [weakSelf loadTableViewData];
    }];
    [tableView setFooterPullToRefreshText:@"下拉刷新·····"];
    [tableView setFooterRefreshingText:@"正在刷新······"];
    [tableView setFooterReleaseToRefreshText:@"刷新完成"];
    }
}

#pragma mark - 创建表格视图
-(void)createTableView
{
    for (int i = 0; i <= 3; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H - 64 - 49 - 30) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 300+i;
        UIView *view = [self.view viewWithTag:200+i];
        [view addSubview:tableView];
    }
    /** 加载表格视图数据*/
    [self loadTableViewData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRZNesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XRZNesCell" owner:self options:nil]firstObject];
    }
    XRZNewsModel *model = _dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


#pragma mark - 创建头部滚动视图
-(void)createHeadScrollView
{
    _subScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H * 140 / 568)];
    _subScrollView.tag = 16;
    self.subScrollView.pagingEnabled = YES;
    _subScrollView.contentSize = CGSizeMake(SCREEN_W * (_subDataArray.count+2), SCREEN_H * 140 / 568);
    _subScrollView.userInteractionEnabled = YES;
    _subScrollView.delegate = self;
    for (int i = 0; i < _subDataArray.count; i++){
        XRZNewsModel *model = _subDataArray[i];
        if (i == 0 && _subDataArray.count > 1) {
            UIImageView *img_i = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H * 140/568)];
            XRZNewsModel *model_i = _subDataArray[_subDataArray.count - 1];
            [img_i sd_setImageWithURL:[NSURL URLWithString:model_i.img]];
            [_subScrollView addSubview:img_i];
        }
        if (i == _subDataArray.count - 1 && _subDataArray.count > 1) {
            UIImageView *img_i = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W * (_subDataArray.count + 1), 0, SCREEN_W, SCREEN_H * 140/568)];
            XRZNewsModel *model_0 = _subDataArray[0];
            [img_i sd_setImageWithURL:[NSURL URLWithString:model_0.img]];
            [_subScrollView addSubview:img_i];
        }
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W * (i+1), 0, SCREEN_W, SCREEN_H * 140/568)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailScroll)];
        imgView.userInteractionEnabled = YES;
        [imgView addGestureRecognizer:tap];
        [imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"BannerLoading.png"]];
        [_subScrollView addSubview:imgView];
    }
    _subScrollView.showsHorizontalScrollIndicator = NO;
    _subScrollView.showsVerticalScrollIndicator = NO;
    _subScrollView.contentOffset = CGPointMake(SCREEN_W, 0);
    UITableView *tableView = [self.view viewWithTag:300];
    tableView.tableHeaderView = _subScrollView;
    if (_subDataArray.count > 1) {
        _page = [[UIPageControl alloc] init];
        _page.frame = CGRectMake(SCREEN_W/4, _subScrollView.frame.size.height - 40, SCREEN_W/4, 20);
        _page.center = CGPointMake(SCREEN_W/2, _subScrollView.frame.size.height - 20);
        _page.numberOfPages = _subDataArray.count;
        [tableView addSubview:_page];
    }
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 16 && _subDataArray.count > 1) {
    NSInteger number = _subScrollView.contentOffset.x / SCREEN_W - 1;
        if (number == -1) {
            _subScrollView.contentOffset = CGPointMake(SCREEN_W * _subDataArray.count, 0);
            number = _subDataArray.count - 1;
        }
        if (number == _subDataArray.count) {
            _subScrollView.contentOffset = CGPointMake(SCREEN_W, 0);
            number = 0;
        }
    _page.currentPage = number;
    }
    if (scrollView.tag == 32) {
        NSInteger number = _supscrollView.contentOffset.x / SCREEN_W;
        UIButton *button = [self.view viewWithTag:100 + number];
        if (button.tag != 100) {
            UIButton *btn_1 = [self.view viewWithTag:100];
            btn_1.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn_1 setBackgroundColor:[UIColor clearColor]];
            [btn_1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn_1.selected = NO;
        }
        if (button.tag != 101) {
            UIButton *btn_1 = [self.view viewWithTag:101];
            btn_1.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn_1 setBackgroundColor:[UIColor clearColor]];
            [btn_1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn_1.selected = NO;
        }
        if (button.tag != 102) {
            UIButton *btn_1 = [self.view viewWithTag:102];
            btn_1.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn_1 setBackgroundColor:[UIColor clearColor]];
            [btn_1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn_1.selected = NO;
        }
        if(button.tag != 103) {
            UIButton *btn_1 = [self.view viewWithTag:103];
            btn_1.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn_1 setBackgroundColor:[UIColor clearColor]];
            [btn_1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn_1.selected = NO;
        }
        //滚动完成数据处理
        [_dataArray removeAllObjects];
        [self loadTableViewData];
        [button setBackgroundColor:[UIColor darkGrayColor]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16 weight:1.5];
    }
}
#pragma mark - 数据载入
-(void) loadTableViewData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSInteger number = _supscrollView.contentOffset.x/SCREEN_W;
    UITableView *tableView = [self.view viewWithTag:300 + number];
    XRZNewsRootView *view = [self.view viewWithTag:200 + number];
    [manager GET:[NSString stringWithFormat:view.urlStr,_pageIndex] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (self.pageIndex == 1) {
            [_dataArray removeAllObjects];
        }
        for (NSDictionary *dict in array) {
            XRZNewsModel *model = [[XRZNewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            model.ID = dict[@"id"];
            [_dataArray addObject:model];
        }
        [tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"下载数据失败");
    }];
    if (self.pageIndex == 1) {
        [tableView headerEndRefreshing];
    }else{
        [tableView footerEndRefreshing];
    }
}

-(void) loadHeadScrollViewData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    UITableView *tableView = [self.view viewWithTag:300];
    [manager GET:News_Top_Url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *subDict in array) {
                XRZNewsModel *model = [[XRZNewsModel alloc] init];
            [model setValuesForKeysWithDictionary:subDict];
            model.ID = subDict[@"id"];
                [_subDataArray addObject:model];
            }
            if (_subDataArray.count != 0) {
            [self createHeadScrollView];
            [tableView reloadData];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"下载数据失败");
    }];
}
#pragma mark - 跳转到cell详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRZNewsDetailController *detailView = [[XRZNewsDetailController alloc] init];
    XRZNewsModel *model = _dataArray[indexPath.row];
    detailView.ID = model.ID;
    [self.navigationController pushViewController:detailView animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)detailScroll
{
    XRZNewsDetailController *detailView = [[XRZNewsDetailController alloc] init];
    NSInteger number = _subScrollView.contentOffset.x/SCREEN_W - 1;
    XRZNewsModel *model = _subDataArray[number];
    detailView.ID = model.ID;
    [self.navigationController pushViewController:detailView animated:YES];
}

#pragma mark - 创建主滚动视图
-(void)createsupScrollview
{
    _supscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 34, SCREEN_W, SCREEN_H)];
    _supscrollView.pagingEnabled = YES;
    _supscrollView.delegate = self;
    _supscrollView.tag = 32;
    _supscrollView.contentSize = CGSizeMake(SCREEN_W * 4, SCREEN_H);
    for (int i = 0; i < 4; i++) {
        XRZNewsRootView *view = [[XRZNewsRootView alloc] init];
        view.tag = 200 + i;
        if (i == 0) {
            view.urlStr = News_Info_Url;
        }
        if (i == 1) {
            view.urlStr = News_GovernMent_Url;
        }
        if (i == 2) {
            view.urlStr = News_Match_Url;
        }
        if (i == 3) {
            view.urlStr = News_Updata_Url;
        }
        view.frame = CGRectMake(SCREEN_W * i, 0, SCREEN_W, SCREEN_H - 35 - 64);
        [_supscrollView addSubview:view];
    }
    [self.view addSubview:_supscrollView];
}

/** 创建头部选择视图*/
-(void)createHeadView
{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_W , 35)];
    UIImageView *imgV= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_W, 35)];
    imgV.image = [UIImage imageNamed:@"contentview_graylongbutton_highlighted.png"];
    [_headView addSubview:imgV];
    NSArray *itemsArr = @[@"最新",@"官方新闻",@"赛事资讯",@"更新/公告"];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( (SCREEN_W - 4 - 5*3)/4 * i + 2 + 5*i, 5, (SCREEN_W - 4 - 5*3)/4, 24)];
        button.layer.cornerRadius = 14;
        button.clipsToBounds = YES;
        [button setTitle:itemsArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [button setBackgroundColor:[UIColor darkGrayColor]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:16 weight:1.5];
            button.selected = YES;
        }
        [_headView addSubview:button];
    }
    [self.view addSubview:_headView];
}

/** 头部视图按钮点击方法*/
-(void) buttonClick:(UIButton *)button
{
    if (button.tag != 100) {
        UIButton *btn_1 = [self.view viewWithTag:100];
        btn_1.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn_1 setBackgroundColor:[UIColor clearColor]];
        [btn_1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn_1.selected = NO;
    }
    if (button.tag != 101) {
        UIButton *btn_1 = [self.view viewWithTag:101];
        btn_1.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn_1 setBackgroundColor:[UIColor clearColor]];
        [btn_1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn_1.selected = NO;
    }
    if (button.tag != 102) {
        UIButton *btn_1 = [self.view viewWithTag:102];
        btn_1.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn_1 setBackgroundColor:[UIColor clearColor]];
        [btn_1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn_1.selected = NO;
    }
    if(button.tag != 103) {
        UIButton *btn_1 = [self.view viewWithTag:103];
        btn_1.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn_1 setBackgroundColor:[UIColor clearColor]];
        [btn_1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn_1.selected = NO;
    }
    [button setBackgroundColor:[UIColor darkGrayColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16 weight:1.5];
    _supscrollView.contentOffset = CGPointMake(SCREEN_W * (button.tag - 100), 0);
    [_dataArray removeAllObjects];
    [self loadTableViewData];
}

-(void) readyInit
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.startFlag = 1;
    _subDataArray = [[NSMutableArray alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    _pageIndex = 1;
}



@end
