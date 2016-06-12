//
//  XRZHerosView.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/3/31.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZHerosView.h"
#import "XRZHerosCell.h"
#import "XRZHerosModel.h"
#import "XRZHerosHeaderView.h"
#import "XRZDetailHero.h"
/** 视图的宽度*/
#define VIEW_W 70.0/320 * SCREEN_W
/** 视图的高度*/
#define VIEW_H 25.0/568 * SCREEN_H
/** 总的个数*/
#define SIZE 12
/** 单行个数*/
#define NUM 4
/** 行距*/
#define MARGIN_Y 5.0/568 * SCREEN_H
/** 状态栏高度[方便整体调整]*/
#define START_H 42.0/568 * SCREEN_H

@interface XRZHerosView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/** 查找的label*/
@property (nonatomic,strong) UIView *topView;
/** 屏幕点击层*/
@property (nonatomic,strong) UIView *fotView;
/** 滚动视图*/
@property (nonatomic,strong) UICollectionView *collectionView;
/** 导出数据库数据*/
@property (nonatomic,strong) NSMutableArray *dataArray;
/** 备份数据库数据*/
@property (nonatomic,strong) NSMutableArray *backupArray;
/** 数据库控制器*/
@property (nonatomic,strong) FMDatabase *dbmanager;

@property (nonatomic,strong) NSArray *headTitle;


@end

@implementation XRZHerosView

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 初始化数据*/
    [self readyInit];
    /** 创建CollectionView*/
    [self createCollectionView];
    /** 数据库处理*/
    [self loadDataFromSQLite];
}

#pragma mark - 加载数据库数据
-(void)loadDataFromSQLite
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dota2db" ofType:@"db"];
    _dbmanager = [[FMDatabase alloc] initWithPath:path];
    BOOL isSucceed = [_dbmanager open];
    if (isSucceed == YES) {
        NSString *sql_1 = @"select * from dota2_heroid left join sqllite_dota2_hero on dota2_heroid.hero_name=sqllite_dota2_hero._id";
        FMResultSet *result_1 = [_dbmanager executeQuery:sql_1];
        NSMutableArray *array_strenth = [NSMutableArray array];
        NSMutableArray *array_intelligence = [NSMutableArray array];
        NSMutableArray *array_agility = [NSMutableArray array];
        while ([result_1 next]) {
            XRZHerosModel *model = [[XRZHerosModel alloc] init];
            model.hero_id = [result_1 stringForColumn:@"hero_id"];
            model.hero_name = [result_1 stringForColumn:@"hero_name"];
            model.hero_cnname = [result_1 stringForColumn:@"hero_cnname"];
            model.AttackCapabilities = [result_1 stringForColumn:@"AttackCapabilities"];
            model.AttributePrimary = [result_1 stringForColumn:@"AttributePrimary"];
            NSString *json_roles = [result_1 stringForColumn:@"Roles"];
            model.Roles = [NSJSONSerialization JSONObjectWithData:[json_roles dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            NSString *jsom_abilities = [result_1 stringForColumn:@"Abilities"];
            model.Abilities = [NSJSONSerialization JSONObjectWithData:[jsom_abilities dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            NSString *jsom_recommendSkills = [result_1 stringForColumn:@"RecommendSkills"];
            model.RecommendSkills = [NSJSONSerialization JSONObjectWithData:[jsom_recommendSkills dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            model.level_1_hp = [result_1 stringForColumn:@"level_1_hp"];
            model.level_1_mp = [result_1 stringForColumn:@"level_1_mp"];
            model.story = [result_1 stringForColumn:@"背景故事"];
            model.VisionDaytimeRange = [result_1 stringForColumn:@"VisionDaytimeRange"];
            model.VisionNighttimeRange = [result_1 stringForColumn:@"VisionNighttimeRange"];
            model.AttackArange = [result_1 stringForColumn:@"AttackRange"];
            model.ProjectileSpeed = [result_1 stringForColumn:@"ProjectileSpeed"];
            model.AttackAnimationPiont = [result_1 stringForColumn:@"AttackAnimationPoint"];
            model.AttributeBaseStrength = [result_1 stringForColumn:@"AttributeBaseStrength"];
            model.AttributeBaseAgility = [result_1 stringForColumn:@"AttributeBaseAgility"];
            model.AttributeBaseIntelligence = [result_1 stringForColumn:@"AttributeBaseIntelligence"];
            model.AttributeStrengthGain = [result_1 stringForColumn:@"AttributeStrengthGain"];
            model.AttributeAgilityGain = [result_1 stringForColumn:@"AttributeAgilityGain"];
            model.AttributeIntelligenceGain = [result_1 stringForColumn:@"AttributeIntelligenceGain"];
            model.level_1_ap_min = [result_1 stringForColumn:@"level_1_ap_min"];
            model.level_1_ap_max = [result_1 stringForColumn:@"level_1_ap_max"];
            model.level_1_armor = [result_1 stringForColumn:@"level_1_armor"];
            model.MovementSpeed = [result_1 stringForColumn:@"MovementSpeed"];
            model.OneEq = [result_1 stringForColumn:@"出门装备"];
            model.twoEq = [result_1 stringForColumn:@"前期装备"];
            model.threeEq = [result_1 stringForColumn:@"核心装备"];
            model.fourEq = [result_1 stringForColumn:@"可选装备"];
            model.thinkWay = [result_1 stringForColumn:@"RecommendSkillsDesc"];
            if ([model.AttributePrimary isEqualToString:@"力量"]) {
                [array_strenth addObject:model];
            }else if ([model.AttributePrimary isEqualToString:@"智力"]) {
                [array_intelligence addObject:model];
            }else{
                [array_agility addObject:model];
            }
        }
        [_dataArray addObject:array_strenth];
        [_dataArray addObject:array_agility];
        [_dataArray addObject:array_intelligence];
        [_backupArray addObject:array_strenth];
        [_backupArray addObject:array_agility];
        [_backupArray addObject:array_intelligence];
        
    }else{
        NSLog(@"失败");
    }
    [_dbmanager close];
    [_collectionView reloadData];
}

#pragma mark - 创建Collectionview
-(void)createCollectionView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(95.0/320 * SCREEN_W , 75.0/568 * SCREEN_H);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H -64- 49) collectionViewLayout:flow];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    [self setNav];
    [_collectionView registerNib:[UINib nibWithNibName:@"XRZHerosCell" bundle:nil] forCellWithReuseIdentifier:@"cellID"];
    [_collectionView registerClass:[XRZHerosHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerIdentifier"];
}

#pragma mark - 代理方法实现
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr = _dataArray[section];
    return arr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XRZHerosCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XRZHerosCell" owner:self options:nil] firstObject];
    }
    XRZHerosModel *model = _dataArray[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 8, 5);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    XRZHerosHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerIdentifier" forIndexPath:indexPath];
    if (!headerView) {
        headerView = [[XRZHerosHeaderView alloc] init];
    }
    NSString *str = _headTitle[indexPath.section];
    headerView.label.text = str;
    return headerView;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_W, 20);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = _dataArray[indexPath.section];
    XRZHerosModel *model = array[indexPath.row];
    XRZDetailHero *detailView = [[XRZDetailHero alloc] init];
    detailView.model = model;
    [self.navigationController pushViewController:detailView animated:YES];
}

#pragma mark - topView中button点击方法
-(void)controlButtons:(UIButton *)button
{
    if (button.selected == NO) {
        button.selected = YES;
    }else{
        button.selected = NO;
    }
    if ([button.titleLabel.text isEqualToString:@"全部英雄"]) {
        UIButton *btn = [self.view viewWithTag:2049];
        btn.selected = NO;
        UIButton *btn_2 = [self.view viewWithTag:2050];
        btn_2.selected = NO;
        UIButton *btn_3 = [self.view viewWithTag:2051];
        btn_3.selected = NO;
        for (int i = 1; i <= 12; i++) {
            UIButton *btn = [self.view viewWithTag:i];
            btn.selected = NO;
        }
        [_dataArray removeAllObjects];
        for (NSArray *array in _backupArray) {
            [_dataArray addObject:array];
        }
        [_collectionView reloadData];
    }
    if ([button.titleLabel.text isEqualToString:@"收藏英雄"]) {
        UIButton *btn_1 = [self.view viewWithTag:2048];
        btn_1.selected = NO;
        UIButton *btn_2 = [self.view viewWithTag:2050];
        btn_2.selected = NO;
        UIButton *btn_3 = [self.view viewWithTag:2051];
        btn_3.selected = NO;
        for (int i = 1; i <= 12; i++) {
            UIButton *btn = [self.view viewWithTag:i];
            btn.selected = NO;
        }
    }
    if (button.tag >=1 && button.tag <= 12) {
        UIButton *btn = [self.view viewWithTag:2048];
        btn.selected = NO;
        UIButton *btn1 = [self.view viewWithTag:2049];
        btn1.selected = NO;
        UIButton *btn_2 = [self.view viewWithTag:2050];
        btn_2.selected = NO;
        UIButton *btn_3 = [self.view viewWithTag:2051];
        btn_3.selected = NO;
        NSMutableArray *array_strenth = [NSMutableArray array];
        NSMutableArray *array_intelligence = [NSMutableArray array];
        NSMutableArray *array_agility = [NSMutableArray array];
        if (button.selected == YES) {
            for (NSArray *arr in _dataArray) {
                for (XRZHerosModel *model in arr) {
                    for (NSString *str in model.Roles) {
                        if ([button.titleLabel.text isEqualToString:str]) {
                            if ([model.AttributePrimary isEqualToString:@"力量"]) {
                                [array_strenth addObject:model];
                            }else if ([model.AttributePrimary isEqualToString:@"智力"]) {[array_intelligence addObject:model];
                            }else{
                                [array_agility addObject:model];
                            }
                        }
                    }
                }
            }
        }
        [_dataArray removeAllObjects];
        [_dataArray addObject:array_strenth];
        [_dataArray addObject:array_agility];
        [_dataArray addObject:array_intelligence];
        [_collectionView reloadData];
    }
    
    if ([button.titleLabel.text isEqualToString:@"近战"]) {
        UIButton *btn = [self.view viewWithTag:2048];
        btn.selected = NO;
        UIButton *btn1 = [self.view viewWithTag:2049];
        btn1.selected = NO;
        UIButton *btn_2 = [self.view viewWithTag:2051];
        btn_2.selected = NO;
        [_dataArray removeAllObjects];
        for (NSArray *array in _backupArray) {
            [_dataArray addObject:array];
        }
        for (int i = 1; i <= 12; i++) {
            UIButton *btn = [self.view viewWithTag:i];
            btn.selected = NO;
        }
        NSMutableArray *array_strenth = [NSMutableArray array];
        NSMutableArray *array_intelligence = [NSMutableArray array];
        NSMutableArray *array_agility = [NSMutableArray array];
        if (button.selected == YES) {
            for (NSArray *arr in _dataArray) {
                for (XRZHerosModel *model in arr) {
                    if ([model.AttackCapabilities isEqualToString:@"近战"]) {
                        if ([model.AttributePrimary isEqualToString:@"力量"]) {
                            [array_strenth addObject:model];
                        }else if ([model.AttributePrimary isEqualToString:@"智力"]) {[array_intelligence addObject:model];
                        }else{
                            [array_agility addObject:model];
                        }
                    }
                }
            }
        }
        [_dataArray removeAllObjects];
        [_dataArray addObject:array_strenth];
        [_dataArray addObject:array_agility];
        [_dataArray addObject:array_intelligence];
        [_collectionView reloadData];
    }
    if ([button.titleLabel.text isEqualToString:@"远程"] && button.tag == 2051) {
        UIButton *btn = [self.view viewWithTag:2048];
        btn.selected = NO;
        UIButton *btn1 = [self.view viewWithTag:2049];
        btn1.selected = NO;
        UIButton *btn_2 = [self.view viewWithTag:2050];
        btn_2.selected = NO;
        [_dataArray removeAllObjects];
        for (NSArray *array in _backupArray) {
            [_dataArray addObject:array];
        }
        for (int i = 1; i <= 12; i++) {
            UIButton *btn = [self.view viewWithTag:i];
            btn.selected = NO;
        }
        NSMutableArray *array_strenth = [NSMutableArray array];
        NSMutableArray *array_intelligence = [NSMutableArray array];
        NSMutableArray *array_agility = [NSMutableArray array];
        if (button.selected == YES) {
            for (NSArray *arr in _dataArray) {
                for (XRZHerosModel *model in arr) {
                    if ([model.AttackCapabilities isEqualToString:@"远程"]) {
                        if ([model.AttributePrimary isEqualToString:@"力量"]) {
                            [array_strenth addObject:model];
                        }else if ([model.AttributePrimary isEqualToString:@"智力"]) {[array_intelligence addObject:model];
                        }else{
                            [array_agility addObject:model];
                        }
                    }
                }
            }
        }
        [_dataArray removeAllObjects];
        [_dataArray addObject:array_strenth];
        [_dataArray addObject:array_agility];
        [_dataArray addObject:array_intelligence];
        [_collectionView reloadData];
    }
}
#pragma mark - 设置弹出隐藏效果
-(void) changeTopViewState
{
    if (_topView.hidden == YES) {
        _topView.hidden = NO;
        _fotView.hidden = NO;
    }else{
        _topView.hidden = YES;
        _fotView.hidden = YES;
    }
}

-(void)changeTOPviewToHidden
{
    _topView.hidden = YES;
    _fotView.hidden = YES;
}

#pragma mark - 添加导航栏按钮，设置弹出视图
-(void) setNav
{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H * 175.0/568 )];
    _topView.backgroundColor = [UIColor blackColor];
    _topView.alpha = 0.8;
    _topView.userInteractionEnabled = YES;
    _fotView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H * 175.0/568, SCREEN_W, SCREEN_H - SCREEN_H * 175.0/568 - 64 -49)];
    _fotView.alpha = 1;
    _fotView.backgroundColor = [UIColor clearColor];
    _fotView.userInteractionEnabled = YES;
    for (int i = 0; i < 2; i++) {
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40/175.0 * _topView.frame.size.height + _topView.frame.size.height * i * 100/175.0, SCREEN_W, 1)];
        lineView.image = [UIImage imageNamed:@"grid_line.png"];
        [_topView addSubview:lineView];
        
    }
    NSArray *btn_1_array = @[@"全部英雄"];
    for (int i = 0; i<1; i++) {
        UIButton *button_1 = [[UIButton alloc] initWithFrame:CGRectMake(4 + 70.0/320 * SCREEN_W * i + 15 * i, 4 ,70.0/320 * SCREEN_W, 32/175.0 * _topView.frame.size.height)];
        [button_1 setBackgroundImage:[UIImage imageNamed:@"tmall_button_buynow_normal.png"] forState:UIControlStateSelected];
        [button_1 setTitle:btn_1_array[i] forState:UIControlStateNormal];
        button_1.titleLabel.font = [UIFont systemFontOfSize:15];
        [button_1 addTarget:self action:@selector(controlButtons:) forControlEvents:UIControlEventTouchUpInside];
        button_1.tag = 2048 + i;
        [_topView addSubview:button_1];
    }
    CGFloat margin_x = (SCREEN_W - NUM * VIEW_W) / (NUM + 1);
    CGFloat margin_y = MARGIN_Y;
    NSArray *titleArray = @[@"辅助",@"控制",@"核心",@"高爆发",@"先手",@"对线辅助",@"逃生",@"打野",@"推进",@"耐久",@"爆发",@"远程"];
    for (int i=0; i<SIZE; i++) {
        int row = i % NUM;
        CGFloat view_x = margin_x + (VIEW_W + margin_x) * row;
        int low = i / NUM;
        CGFloat view_y = (START_H + margin_y) + (VIEW_H + margin_y) * low;
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(view_x, view_y, VIEW_W, VIEW_H);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setBackgroundImage:[UIImage imageNamed:@"tmall_button_buynow_normal.png"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(controlButtons:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 1;
        [_topView addSubview:button];
    }
    UILabel *label_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, _topView.frame.size.height - 35.0/568 * SCREEN_H + 5, 70.0/320 * SCREEN_W, 25.0/568 * SCREEN_H)];
    label_1.text = @"攻击类型:";
    label_1.font = [UIFont systemFontOfSize:15];
    label_1.textColor = [UIColor whiteColor];
    label_1.textAlignment = NSTextAlignmentRight;
    [_topView addSubview:label_1];
    NSArray *btn_2_array = @[@"近战",@"远程"];
    for (int i = 0; i < 2; i++) {
        UIButton *button_1 = [[UIButton alloc] initWithFrame:CGRectMake(70.0/320 *SCREEN_W + 70.0/320 * SCREEN_W * i + 15 * i, _topView.frame.size.height - 35.0/568 * SCREEN_H + 5 ,70.0/320 * SCREEN_W, 24/175.0 * _topView.frame.size.height)];
        [button_1 setBackgroundImage:[UIImage imageNamed:@"tmall_button_buynow_normal.png"] forState:UIControlStateSelected];
        [button_1 setTitle:btn_2_array[i] forState:UIControlStateNormal];
        button_1.titleLabel.font = [UIFont systemFontOfSize:15];
        [button_1 addTarget:self action:@selector(controlButtons:) forControlEvents:UIControlEventTouchUpInside];
        button_1.tag = 2050 + i;
        [_topView addSubview:button_1];
    }
    [self.view addSubview:_topView];
    [self.view addSubview:_fotView];
    _topView.hidden = YES;
    _fotView.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTOPviewToHidden)];
    [_fotView addGestureRecognizer:tap];
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 60, 35) title:nil image:[UIImage imageNamed:@"menu_icon.png"] bgImage:[UIImage imageNamed:@"newsRefreshBtnBg.png"] tag:1024 actionBlock:^(XRZMyButton *button) {
        [self changeTopViewState];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

-(void)readyInit
{
    _backupArray = [[NSMutableArray alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    _headTitle = @[@"力量",@"敏捷",@"智力"];
}

@end
