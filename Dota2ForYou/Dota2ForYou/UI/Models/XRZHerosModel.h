//
//  XRZHerosModel.h
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/5.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRZHerosModel : NSObject
/** 英雄id*/
@property (nonatomic,copy) NSString *hero_id;
/** 英雄英文名称*/
@property (nonatomic,copy) NSString *hero_name;
/** 英雄中文名称*/
@property (nonatomic,copy) NSString *hero_cnname;
/** 英雄定位*/
@property (nonatomic,strong) NSArray *Roles;
/** 英雄技能*/
@property (nonatomic,strong) NSArray *Abilities;
/** 英雄属性*/
@property (nonatomic,copy) NSString *AttackCapabilities;
/** 攻击频率*/
@property (nonatomic,copy) NSString *AttackRate;
/** 攻击前摇*/
@property (nonatomic,copy) NSString *AttackAnimationPiont;
/** 攻击距离*/
@property (nonatomic,copy) NSString *AttackArange;
/** 导弹速度*/
@property (nonatomic,copy) NSString *ProjectileSpeed;
/** 英雄类型*/
@property (nonatomic,copy) NSString *AttributePrimary;
/** 基础力量*/
@property (nonatomic,copy) NSString *AttributeBaseStrength;
/** 基础智力*/
@property (nonatomic,copy) NSString *AttributeBaseIntelligence;
/** 基础敏捷*/
@property (nonatomic,copy) NSString *AttributeBaseAgility;
/** 力量成长*/
@property (nonatomic,copy) NSString *AttributeStrengthGain;
/** 智力成长*/
@property (nonatomic,copy) NSString *AttributeIntelligenceGain;
/** 敏捷成长*/
@property (nonatomic,copy) NSString *AttributeAgilityGain;
/** 移动速度*/
@property (nonatomic,copy) NSString *MovementSpeed;
/** 白天视野*/
@property (nonatomic,copy) NSString *VisionDaytimeRange;
/** 夜晚视野*/
@property (nonatomic,copy) NSString *VisionNighttimeRange;
/** 初始血量*/
@property (nonatomic,copy) NSString *level_1_hp;
/** 初始蓝量*/
@property (nonatomic,copy) NSString *level_1_mp;
/** 背景故事*/
@property (nonatomic,copy) NSString *story;
/** 英雄技能*/
@property (nonatomic,strong) NSArray *RecommendSkills;
/** 初始最低攻击力*/
@property (nonatomic,copy) NSString *level_1_ap_min;
/** 初始最高攻击力*/
@property (nonatomic,copy) NSString *level_1_ap_max;
/** 基础护甲*/
@property (nonatomic,copy) NSString *level_1_armor;
/** 出门装备*/
@property (nonatomic,copy) NSString *OneEq;
/** 前期装备*/
@property (nonatomic,copy) NSString *twoEq;
/** 中期装备*/
@property (nonatomic,copy) NSString *threeEq;
/** 可选装备*/
@property (nonatomic,copy) NSString *fourEq;
/** 技能加点*/
@property (nonatomic,copy) NSString *skillAdd;
/** 出装思路*/
@property (nonatomic,copy) NSString *thinkWay;





@end
