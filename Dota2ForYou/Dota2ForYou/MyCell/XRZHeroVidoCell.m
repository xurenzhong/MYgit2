//
//  XRZHeroVidoCell.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/9.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZHeroVidoCell.h"

@interface XRZHeroVidoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *vidoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;

@end

@implementation XRZHeroVidoCell

- (void)awakeFromNib {
}

-(void)setModel:(XRZVidoModel *)model
{
    _model = model;
    [_vidoView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"noimage_xiangqing.png"]];
    _titleLabel.text = model.name;
    _timeLabel.numberOfLines = 2;
    _timeLabel.text = [NSString stringWithFormat:@"时长:%@",model.length];
    NSTimeInterval time = [model.time doubleValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *str = [[NSString stringWithFormat:@"%@",confromTimesp] substringToIndex:10];
    _updateLabel.text = [NSString stringWithFormat:@"更新时间:%@",str];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
