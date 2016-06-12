//
//  XRZHeroEqumentCell.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/9.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZHeroEqumentCell.h"

@interface XRZHeroEqumentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *oneEqImg;
@property (weak, nonatomic) IBOutlet UIImageView *twoImgView;
@property (weak, nonatomic) IBOutlet UIImageView *threeImgView;
@property (weak, nonatomic) IBOutlet UIImageView *fourImgView;
@property (weak, nonatomic) IBOutlet UIImageView *skillView;
@property (weak, nonatomic) IBOutlet UIImageView *thinkView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation XRZHeroEqumentCell


-(void)setModel:(XRZHerosModel *)model
{
    _model = model;
    _nameLabel.text = model.hero_cnname;
    _iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",model.hero_name]];
    NSArray *array_1 = [NSJSONSerialization JSONObjectWithData:[model.OneEq dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%ld",array_1.count);
    for (int i = 0; i < array_1.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(35 * i + 2, 4, 35, 30)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",array_1[i]]];
        [_oneEqImg addSubview:imgView];
    }
    NSArray *array_2 = [NSJSONSerialization JSONObjectWithData:[model.twoEq dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    for (int i = 0; i < array_2.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(35 * i + 2, 4, 35, 30)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",array_2[i]]];
        [_twoImgView addSubview:imgView];
    }
    NSArray *array_3 = [NSJSONSerialization JSONObjectWithData:[model.threeEq dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    for (int i = 0; i < array_3.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(35 * i + 2, 4, 35, 30)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",array_3[i]]];
        [_threeImgView addSubview:imgView];
    }
    NSArray *array_4 = [NSJSONSerialization JSONObjectWithData:[model.fourEq dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    for (int i = 0; i < array_4.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(35 * i + 2, 4, 35, 30)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",array_4[i]]];
        [_fourImgView addSubview:imgView];
    }
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8.0/320 *SCREEN_W * (1+j) + 40*j , 5 * (i+1) + 40*i, 40, 40)];
            imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ability_%@.jpg",model.RecommendSkills[i*5+j]]];
            [_skillView addSubview:imgView];
        }
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 320)];
    label.text = model.thinkWay;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    [_thinkView addSubview:label];
    
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
