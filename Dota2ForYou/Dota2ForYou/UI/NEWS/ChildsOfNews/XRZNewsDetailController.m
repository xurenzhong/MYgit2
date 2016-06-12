//
//  XRZNewsDetailController.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/5.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZNewsDetailController.h"
#import "XRZNewsModel.h"
#import "XRZDetailNewsCell.h"

@interface XRZNewsDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
/** 新闻标题*/
@property (nonatomic,strong) UILabel *titleLabel;
/** 更新时间*/
@property (nonatomic,strong) UILabel *postTime;
/** 数据来源*/
@property (nonatomic,strong) UILabel *siteLabel;
/** 数据*/
@property (nonatomic,strong) XRZNewsModel *dataModel;


@property (nonatomic,strong) UITableView *tableView;


@end

@implementation XRZNewsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    /** 设置导航栏*/
    [self setNav];
    /** 载入数据*/
    [self loadData];
    /** 创建表格视图*/
    [self createTableView];
}

#pragma mark - 表格视图
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64 -49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - 表格视图代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_H - 64 - 49;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRZDetailNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XRZDetailNewsCell" owner:self options:nil]firstObject];
    }
    cell.model = _dataModel;
    return cell;
}

#pragma mark - 数据载入
-(void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:News_Detail_Url,_ID] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        _dataModel = [[XRZNewsModel alloc] init];
        [_dataModel setValuesForKeysWithDictionary:dict];
        [_dataArray addObject:_dataModel];        
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"下载数据失败");
    }];
}

-(void)setNav
{
    self.title = @"内容";
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:@"" image:[UIImage imageNamed:@"back.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        self.tabBarController.tabBar.hidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

-(void)initData
{
    _dataArray = [NSMutableArray array];
}

@end
