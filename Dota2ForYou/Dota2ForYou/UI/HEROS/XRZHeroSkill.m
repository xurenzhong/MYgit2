//
//  XRZHeroSkill.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/7.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZHeroSkill.h"
#import "FMDatabase.h"
#import "XRZSkillCell.h"
@interface XRZHeroSkill ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) FMDatabase *dbManager;


@end

@implementation XRZHeroSkill

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 初始化*/
    [self readyInit];
    /** 返回设置*/
    [self setNav];
    /** 数据载入*/
    [self loadData];
    /** 创建表格视图*/
    [self createTableView];
    
}

#pragma mark - 表格视图代理实现
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XRZSkillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XRZSkillCell" owner:self options:nil] firstObject];
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

#pragma mark - 创建表格视图
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64-20)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 200;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_tableView];
}
#pragma mark - 数据载入
-(void) loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dota2db" ofType:@"db"];
    _dbManager = [[FMDatabase alloc] initWithPath:path];
    BOOL isSucceed = [_dbManager open];
    if (isSucceed) {
        NSString *str1 = @"%";
        NSString *str2 = @"%";
        NSString *str = [NSString stringWithFormat:@"%@%@%@",str1,_herosModel.hero_name,str2];
        NSString *sql = [NSString stringWithFormat:@"select * from sqllite_dota2_skill where heroId like '%@'",str];
        FMResultSet *result = [_dbManager executeQuery:sql];
        while ([result next]) {
            XRZSkillModel *model = [[XRZSkillModel alloc] init];
            model._id = [result stringForColumn:@"_id"];
            model.icon = [result stringForColumn:@"icon"];
            model.Description = [result stringForColumn:@"Description"];
            model.AbilityDuration = [result stringForColumn:@"AbilityDuration"];
            model.AbilityDamage = [result stringForColumn:@"AbilityDamage"];
            model.hotkey = [result stringForColumn:@"hotkey"];
            model.lines = [result stringForColumn:@"lines"];
            model._abilityData = [result stringForColumn:@"_abilityData"];
            model.name = [result stringForColumn:@"name"];
            [_dataArray addObject:model];
        }
    }else{
        NSLog(@"数据库打开失败");
    }
}

-(void) setNav
{
    self.tabBarController.tabBar.hidden = YES;
    self.title = _herosModel.hero_cnname;
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:nil image:[UIImage imageNamed:@"common_back_button.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

-(void)readyInit
{
    _dataArray = [NSMutableArray array];
}
@end
