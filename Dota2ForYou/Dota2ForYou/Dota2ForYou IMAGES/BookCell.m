//
//  BookCell.m
//  Mood
//
//  Created by hehe on 15/9/19.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "BookCell.h"

@implementation BookCell

{
    BOOL isRightPage;
}

//初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景
        self.bgView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        
        //添加图片
        self.imageView = [[UIImageView alloc] initWithFrame:self.bgView.bounds];
        [self.bgView addSubview:self.imageView];
        
        //添加星座label
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
        self.textLabel.center = CGPointMake(self.bgView.bounds.size.width / 2 + 20, self.bgView.bounds.size.height + 70.0/568 * SCREEN_H);
        UIImageView *textbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
        textbg.image = [UIImage imageNamed:@"other_book_bg.jpg"];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        textbg.layer.cornerRadius = 2;
        textbg.clipsToBounds = YES;
        [self.textLabel addSubview:textbg];
        [self.contentView addSubview:self.textLabel];
        //开启反锯齿
        self.layer.allowsEdgeAntialiasing = YES;
        
    }
    return self;
}

//默认自定义布局,布局圆角 和 中心线
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    //判断cell的奇数偶数
    if (layoutAttributes.indexPath.item % 2 == 0) {
        //如果偶数,则中心线在左边,页面右边有圆角,左边没有圆角
        isRightPage = YES;
        self.textLabel.center = CGPointMake(self.bgView.bounds.size.width / 2 + 20, self.bgView.bounds.size.height + 70.0/568 * SCREEN_H);
        self.layer.anchorPoint = CGPointMake(0, 0.5);
    } else {
        isRightPage = NO;
        self.textLabel.center = CGPointMake(self.bgView.bounds.size.width / 2 + 20, self.bgView.bounds.size.height + 70.0/568 * SCREEN_H);
        self.layer.anchorPoint = CGPointMake(1, 0.5);
    }
    
    //圆角设置
    UIRectCorner corner = isRightPage ? UIRectCornerTopRight | UIRectCornerBottomRight : UIRectCornerTopLeft | UIRectCornerBottomLeft;
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(16, 16)];
    //CAShapeLayer: 通过给定的贝塞尔曲线UIBezierPath,在空间中作图
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bgView.bounds;
    maskLayer.path = bezier.CGPath;
    self.bgView.layer.mask = maskLayer;
    self.bgView.clipsToBounds = YES;
}
@end
