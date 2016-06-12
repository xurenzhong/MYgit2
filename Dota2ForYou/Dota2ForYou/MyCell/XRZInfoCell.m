//
//  XRZInfoCell.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/11.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZInfoCell.h"
@interface XRZInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation XRZInfoCell


-(void)setModel:(XRZInfoModel *)model
{
    _model = model;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.cover_url] placeholderImage:[UIImage imageNamed:@"2back1.png"]];
    _titleLabel.text = model.title;
}


- (void)awakeFromNib {
    // Initialization code
}

@end
