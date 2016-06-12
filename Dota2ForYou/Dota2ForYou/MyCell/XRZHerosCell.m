//
//  XRZHerosCell.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/5.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZHerosCell.h"

@interface XRZHerosCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;

@end

@implementation XRZHerosCell

-(void)setModel:(XRZHerosModel *)model
{
    _model = model;
    _iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",model.hero_name]];
    _iconLabel.text = model.hero_cnname;
}

- (void)awakeFromNib {

}

@end
