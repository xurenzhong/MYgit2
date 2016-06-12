//
//  XRZHeroVidoViewController.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/9.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZHeroVidoViewController.h"
#import "XRZHeroVidoCell.h"
#import "XRZAvPlayViewController.h"
@interface XRZHeroVidoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation XRZHeroVidoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self loadData];
    
    [self createTableView];
}

#pragma mark - 表格视图代理方法实现
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRZAvPlayViewController *playView = [[XRZAvPlayViewController alloc] init];
    playView.model = _vidoModel;
    playView.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:playView animated:YES];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRZHeroVidoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XRZHeroVidoCell" owner:self options:nil]firstObject];
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0;
}

#pragma mark - 创建表格视图
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


#pragma mark - 数据载入
-(void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:Hero_vido_Url,_model.hero_name] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in array) {
            XRZVidoModel *model = [[XRZVidoModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            model.ID = dict[@"id"];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"数据下载失败");
    }];
}

-(void)setNav{
    _dataArray = [NSMutableArray array];
    self.tabBarController.tabBar.hidden = YES;
    self.title = [NSString stringWithFormat:@"%@视频",_model.hero_cnname];
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:nil image:[UIImage imageNamed:@"common_back_button.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}



@end
