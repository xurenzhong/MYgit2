//
//  XRZNesCell.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/4.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZNesCell.h"

@interface XRZNesCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation XRZNesCell

-(void)setModel:(XRZNewsModel *)model
{
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"noimage_xiangqing.png"]];
    _titleLabel.text = model.title;
    _descLabel.text = model.desc;
    _postTimeLabel.text = model.posttime;
}

- (void)awakeFromNib {
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
