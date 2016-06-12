//
//  XRZDetailHero.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/6.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZDetailHero.h"
#import <MediaPlayer/MediaPlayer.h>
#import "XRZHeroSkill.h"
#import "XRZSkillModel.h"
#import "XRZTaticController.h"
#import "XRZStoryOfHero.h"
#import "XRZHeroEquipmentController.h"
#import "XRZHeroVidoViewController.h"
@interface XRZDetailHero ()
/** 覆盖层*/
@property (nonatomic,strong) UIView *allView;
/** 头部背景图*/
@property (nonatomic,strong) UIImageView *topBackgroundView;
/** 英雄名*/
@property (nonatomic,strong) UILabel *nameLabel;
/** 收藏按钮*/
@property (nonatomic,strong) XRZMyButton *collectButton;
/** 英雄类型*/
@property (nonatomic,strong) UILabel *atributeLabel;
/** 英雄定位*/
@property (nonatomic,strong) UILabel *rolesLabel;
/** 等级*/
@property (nonatomic,strong) UILabel *levelLabel;
/** 血量*/
@property (nonatomic,strong) UILabel *hpLabel;
/** 蓝量*/
@property (nonatomic,strong) UILabel *mpLabel;
/** 升级滑竿*/
@property (nonatomic,strong) UISlider *slider;
/** 底部视图view*/
@property (nonatomic,strong) UIImageView *bottomView;
/** 中间背景*/
@property (nonatomic,strong) UIImageView *centerView;
/** 头像视频播放*/
@property (nonatomic,strong) MPMoviePlayerController *playIcon;

@end

@implementation XRZDetailHero

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设置导航栏*/
    [self setNav];
    /** 设置UI界面*/
    [self makeUI];
}
-(void)changeHPAndMPForSlider
{
    _levelLabel.text = [NSString stringWithFormat:@"等级:%d",(int)_slider.value];
    int number = (int)_slider.value;
    int hp_number = 32 * number + [_model.level_1_hp intValue];
    int mp_number = 32 * number + [_model.level_1_mp intValue];
    _hpLabel.text = [NSString stringWithFormat:@"%d",hp_number];
    _mpLabel.text = [NSString stringWithFormat:@"%d",mp_number];
}

#pragma mark - 设置UI界面
-(void) makeUI
{
    _allView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64)];
    _allView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_allView];
    _centerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 105.0/568 * SCREEN_H, SCREEN_W, 350.0/568 * SCREEN_H)];
    _centerView.image = [UIImage imageNamed:@"hero_bg.jpg"];
    [_allView addSubview:_centerView];
    _topBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 105.0/568 * SCREEN_H)];
    _topBackgroundView.image = [UIImage imageNamed:@"hero_top_bg.jpg"];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0/320 * SCREEN_W, 10.0/568 * SCREEN_H, 100.0/320 * SCREEN_W, 15.0/568 * SCREEN_H)];
    _nameLabel.text = self.model.hero_cnname;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:15 weight:1.5];
    [_allView addSubview:_topBackgroundView];
    [_allView addSubview:_nameLabel];
    //头像视频播放
    NSString *path = [[NSBundle mainBundle] pathForResource:_model.hero_name ofType:@"m4v"];
    NSURL *filePath = [NSURL fileURLWithPath:path];
    _playIcon = [[MPMoviePlayerController alloc] initWithContentURL:filePath];
    _playIcon.view.frame = CGRectMake(8.0/320 * SCREEN_W, 35.0/568 * SCREEN_H, 90.0/320 * SCREEN_W , 100.0/568 * SCREEN_H);
    _playIcon.controlStyle = MPMovieControlStyleNone;
    _playIcon.scalingMode = MPMovieScalingModeFill;
    [self.view addSubview:_playIcon.view];
    _playIcon.repeatMode = MPMovieRepeatModeOne;
    [_playIcon play];
    _atributeLabel = [[UILabel alloc] initWithFrame:CGRectMake(105.0/320 * SCREEN_W, 55.0/568 * SCREEN_H, 100, 12.0/568 * SCREEN_H)];
    _atributeLabel.text = [NSString stringWithFormat:@"%@  %@",_model.AttributePrimary,_model.AttackCapabilities];
    _atributeLabel.textColor = [UIColor whiteColor];
    _atributeLabel.font = [UIFont systemFontOfSize:12];
    [_allView addSubview:_atributeLabel];
    _rolesLabel = [[UILabel alloc] initWithFrame:CGRectMake(105.0/320 * SCREEN_W, 85.0/568 * SCREEN_H, 150, 12.0/568 * SCREEN_H)];
    _rolesLabel.textColor = [UIColor whiteColor];
    _rolesLabel.text = @"";
    _rolesLabel.font = [UIFont systemFontOfSize:12];
    for (NSString *str in _model.Roles) {
        _rolesLabel.text = [NSString stringWithFormat:@"%@ %@",_rolesLabel.text,str];
    }
    [_allView addSubview:_rolesLabel];
    NSArray *title_pic = @[@"liliang.png",@"minjie.png",@"zhili.png",@"gongjili.png",@"yidongsudu.png",@"hujia.png"];
    NSArray *title_name = @[[NSString stringWithFormat:@"力量: %@(%@)",_model.AttributeBaseStrength,_model.AttributeStrengthGain],[NSString stringWithFormat:@"敏捷: %@(%@)",_model.AttributeBaseAgility,_model.AttributeAgilityGain],[NSString stringWithFormat:@"智力: %@(%@)",_model.AttributeBaseIntelligence,_model.AttributeIntelligenceGain],[NSString stringWithFormat:@"攻击力: %@-%@",_model.level_1_ap_min,_model.level_1_ap_max],[NSString stringWithFormat:@"移动速度: %@",_model.MovementSpeed],[NSString stringWithFormat:@"护甲: %@",_model.level_1_armor]];
    for (int i = 0 ; i < 3; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8.0/320 * SCREEN_W, 140.0/568 * SCREEN_H + 20.0/320 *SCREEN_W * i + 2, 20.0/320 * SCREEN_W, 20.0/320 * SCREEN_W)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30.0/320 * SCREEN_W, 140.0/568 * SCREEN_H + 20.0/320 *SCREEN_W * i + 2, 110.0/320 * SCREEN_W, 20.0/320 * SCREEN_W)];
        label.text = title_name[i];
        label.font = [UIFont systemFontOfSize:12];
        imgView.image = [UIImage imageNamed:title_pic[i]];
        imgView.layer.cornerRadius = imgView.frame.size.width/2;
        imgView.clipsToBounds = YES;
        [_allView addSubview:imgView];
        [_allView addSubview:label];
    }
    for (int i = 3 ; i < 6; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(145.0/320 * SCREEN_W, 140.0/568 * SCREEN_H + 20.0/320 *SCREEN_W * (i-3) + 2, 20.0/320 * SCREEN_W, 20.0/320 * SCREEN_W)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(175.0/320 * SCREEN_W, 140.0/568 * SCREEN_H + 20.0/320 *SCREEN_W * (i-3) + 2, 110.0/320 * SCREEN_W, 20.0/320 * SCREEN_W)];
        label.text = title_name[i];
        label.font = [UIFont systemFontOfSize:12];
        imgView.image = [UIImage imageNamed:title_pic[i]];
        imgView.layer.cornerRadius = imgView.frame.size.width/2;
        imgView.clipsToBounds = YES;
        [_allView addSubview:imgView];
        [_allView addSubview:label];
    }
    UILabel *viewLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0/320 * SCREEN_W, 215.0/568 * SCREEN_H, 100.0/320 * SCREEN_W, 15.0/568 * SCREEN_H)];
    viewLabel.text = [NSString stringWithFormat:@"视野:%@/%@",_model.VisionDaytimeRange,_model.VisionNighttimeRange];
    viewLabel.font = [UIFont systemFontOfSize:12];
    [_allView addSubview:viewLabel];
    UILabel *speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0/320 * SCREEN_W, 235.0/568 * SCREEN_H, 100.0/320 * SCREEN_W, 15.0/568 * SCREEN_H)];
    speedLabel.text = [NSString stringWithFormat:@"弹道速度:%@",_model.ProjectileSpeed];
    speedLabel.font = [UIFont systemFontOfSize:12];
    [_allView addSubview:speedLabel];
    UILabel *beatLabel = [[UILabel alloc] initWithFrame:CGRectMake(145.0/320 * SCREEN_W, 215.0/568 * SCREEN_H, 100.0/320 * SCREEN_W, 15.0/568 * SCREEN_H)];
    beatLabel.text = [NSString stringWithFormat:@"攻击距离:%@",_model.AttackArange];
    beatLabel.font = [UIFont systemFontOfSize:12];
    [_allView addSubview:beatLabel];
    UILabel *beatStopLabel = [[UILabel alloc] initWithFrame:CGRectMake(145.0/320 * SCREEN_W, 235.0/568 * SCREEN_H, 100.0/320 * SCREEN_W, 15.0/568 * SCREEN_H)];
    beatStopLabel.text = [NSString stringWithFormat:@"攻击前摇:%@",_model.AttackAnimationPiont];
    beatStopLabel.font = [UIFont systemFontOfSize:12];
    [_allView addSubview:beatStopLabel];
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(8.0/320 * SCREEN_W, 270.0/568 * SCREEN_H, 304.0/320 * SCREEN_W, 10)];
    [_allView addSubview:_slider];
    _slider.value = 1;
    _slider.minimumValue = 1;
    _slider.maximumValue = 25;
    [_slider addTarget:self action:@selector(changeHPAndMPForSlider) forControlEvents:UIControlEventValueChanged];
#pragma mark - 滑竿控制功能
    _levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0/320 * SCREEN_W, 110.0/568 * SCREEN_H, 60.0/320 * SCREEN_W, 17)];
    _levelLabel.text = [NSString stringWithFormat:@"等级:%@",@"1"];
    _levelLabel.font = [UIFont systemFontOfSize:15];
    [_allView addSubview:_levelLabel];
    _hpLabel = [[UILabel alloc] initWithFrame:CGRectMake(165.0/320 * SCREEN_W, 110.0/568 * SCREEN_H, 68.0/320 * SCREEN_W, 17)];
    _hpLabel.backgroundColor = [UIColor greenColor];
    _hpLabel.text = [NSString stringWithFormat:@"HP:%@",_model.level_1_hp];
    _hpLabel.font = [UIFont systemFontOfSize:12];
    _hpLabel.textAlignment = NSTextAlignmentCenter;
    _hpLabel.textColor = [UIColor whiteColor];
    [_allView addSubview:_hpLabel];
    _mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(240.0/320 * SCREEN_W, 110.0/568 * SCREEN_H, 68.0/320 * SCREEN_W, 17)];
    _mpLabel.backgroundColor = [UIColor blueColor];
    _mpLabel.text = [NSString stringWithFormat:@"MP:%@",_model.level_1_mp];
    _mpLabel.font = [UIFont systemFontOfSize:12];
    _mpLabel.textAlignment = NSTextAlignmentCenter;
    _mpLabel.textColor = [UIColor whiteColor];
    [_allView addSubview:_mpLabel];
    NSArray *hero_btn_array = @[@"hero_btn_bg1.png",@"hero_btn_bg2.png",@"hero_btn_bg3.png",@"hero_btn_bg4.png",@"hero_btn_bg5.png"];
#pragma mark - 点击跳转
    NSArray *hero_btn_title = @[@"技能",@"出装",@"攻略",@"背景"];
    for (int i = 0; i < 4; i++) {
        XRZMyButton *button = [XRZMyButton addBlockButtonWithFrame:CGRectMake(10 + 60.0/320 * SCREEN_W * i + 18*i, 300.0/568 * SCREEN_H, 56.0/320 * SCREEN_W, 40.0/568 * SCREEN_H) title:hero_btn_title[i] image:nil bgImage:[UIImage imageNamed:hero_btn_array[i]] tag:100 + i actionBlock:^(XRZMyButton *button) {
            if (button.tag == 100) {
                XRZHeroSkill *heroSkill = [[XRZHeroSkill alloc]init];
                heroSkill.herosModel = _model;
                [self.navigationController pushViewController:heroSkill animated:YES];
            }
            if (button.tag == 101) {
                XRZHeroEquipmentController *equipmentView = [[XRZHeroEquipmentController alloc] init];
                equipmentView.model = _model;
                [self.navigationController pushViewController:equipmentView animated:YES];
            }
            if (button.tag == 102) {
                XRZTaticController *taticView = [[XRZTaticController alloc] init];
                taticView.model = _model;
                taticView.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:taticView animated:YES];
            }
            if (button.tag == 103) {
                XRZStoryOfHero *storyView = [[XRZStoryOfHero alloc] init];
                storyView.model = _model;
                storyView.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:storyView animated:YES];
            }
        }];
        [_allView addSubview:button];
    }
    _bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0,  445.0/568 * SCREEN_H, SCREEN_W, 70.0/568 * SCREEN_H)];
    _bottomView.image = [UIImage imageNamed:@"hero_bottom.jpg"];
    [_allView addSubview:_bottomView];
}

-(void) setNav
{
    self.tabBarController.tabBar.hidden = YES;
    self.title = _model.hero_cnname;
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:nil image:[UIImage imageNamed:@"common_back_button.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        self.tabBarController.tabBar.hidden = NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}


@end
