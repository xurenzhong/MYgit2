//
//  XRZSkillCell.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/7.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZSkillCell.h"

@interface XRZSkillCell ()

@property (nonatomic,strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *skillNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *vidoButton;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIView *skillView;

@end


@implementation XRZSkillCell

-(void)setModel:(XRZSkillModel *)model
{
    _model = model;
    _iconView.image = [UIImage imageNamed:model.icon];
    _skillNameLabel.text = [NSString stringWithFormat:@"%@[%@]",model.name,model.hotkey];
    _descLabel.text = model.Description;
//    [_vidoButton setBackgroundImage:[UIImage imageNamed:@"tbmessage_button_banner.png"] forState:UIControlStateNormal];
//    [_vidoButton setTitle:@"视频演示" forState:UIControlStateNormal];
//    [_vidoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSData *data = [_model.lines dataUsingEncoding:NSUTF8StringEncoding];
    _dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (int i = 0 ; i < _dataArray.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 * i + 1, SCREEN_W, 13)];
        label.text = _dataArray[i];
        label.font = [UIFont systemFontOfSize:12];
        [_skillView addSubview:label];
    }
}

- (void)awakeFromNib {
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
