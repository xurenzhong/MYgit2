//
//  XRZTaticController.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/8.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZTaticController.h"
#import "XRZNewsModel.h"
#import "XRZNesCell.h"
#import "XRZNewsDetailController.h"
@interface XRZTaticController ()<UITableViewDataSource,UITableViewDelegate>
/** 数据存储*/
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation XRZTaticController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    /** 数据载入*/
    [self loadData];
    
    [self createTableView];
}
#pragma mark - 代理实现
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRZNewsDetailController *detailView = [[XRZNewsDetailController alloc] init];
    XRZNewsModel *model = _dataArray[indexPath.row];
    detailView.ID = model.ID;
    [self.navigationController pushViewController:detailView animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRZNesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XRZNesCell" owner:self options:nil]firstObject];
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - 数据载入
-(void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:Hero_list_Url,_model.hero_name] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in array) {
            XRZNewsModel *model = [[XRZNewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            model.ID = dict[@"id"];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"数据载入失败");
    }];
}

-(void)setNav
{
    _dataArray = [NSMutableArray array];
    self.tabBarController.tabBar.hidden = YES;
    self.title = [NSString stringWithFormat:@"%@攻略",_model.hero_cnname];
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:nil image:[UIImage imageNamed:@"common_back_button.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}
@end
