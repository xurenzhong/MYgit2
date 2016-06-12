//
//  XRZSkillModel.h
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/7.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRZSkillModel : NSObject
/** 技能英文名称*/
@property (nonatomic,copy) NSString *_id;
/** 技能中文名称*/
@property (nonatomic,copy) NSString *name;
/** 技能头像*/
@property (nonatomic,copy) NSString *icon;
/** 技能描述*/
@property (nonatomic,copy) NSString *Description;
/** 英雄名称*/
@property (nonatomic,copy) NSString *heroid;
/** 技能冷却时间*/
@property (nonatomic,copy) NSString *AbilityDuration;
/** 技能伤害*/
@property (nonatomic,copy) NSString *AbilityDamage;
/** 热键*/
@property (nonatomic,copy) NSString *hotkey;
/** 技能lines*/
@property (nonatomic,copy) NSString *lines;
/** 技能数据*/
@property (nonatomic,copy) NSString *_abilityData;

@end
