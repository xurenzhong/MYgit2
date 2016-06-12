//
//  XRZOtherCell.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/11.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZOtherCell.h"
@interface XRZOtherCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation XRZOtherCell


-(void)setModel:(XRZOtherModel *)model
{
    _model = model;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.litpic] placeholderImage:[UIImage imageNamed:@"noimage_xiangqing.png"]];
    _numberLabel.text = model.click;
    _timeLabel.text = model.pubdate;
    _titleLabel.text = model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
