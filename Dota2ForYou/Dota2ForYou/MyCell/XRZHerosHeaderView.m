//
//  XRZHerosHeaderView.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/6.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZHerosHeaderView.h"

@implementation XRZHerosHeaderView

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}

-(void)makeUI
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 20)];
    _label.textColor = [UIColor whiteColor];
    _label.backgroundColor = [UIColor grayColor];
    [self addSubview:_label];
}

@end
