//
//  XRZHeroEquipmentController.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/9.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZHeroEquipmentController.h"
#import "XRZHeroEqumentCell.h"
@interface XRZHeroEquipmentController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation XRZHeroEquipmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self loadData];
    [self createTableView];
    
}

#pragma mark - 创建表格视图
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 846.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRZHeroEqumentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XRZHeroEqumentCell" owner:self options:nil]firstObject];
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)loadData
{
    [_dataArray addObject:_model];
    [_tableView reloadData];
}

-(void)setNav{
    _dataArray = [NSMutableArray array];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"[推荐出装加点]";
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:nil image:[UIImage imageNamed:@"common_back_button.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}
@end
