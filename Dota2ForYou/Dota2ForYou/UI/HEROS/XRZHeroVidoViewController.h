//
//  XRZHeroVidoViewController.h
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/9.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRZHerosModel.h"
#import "XRZVidoModel.h"

@interface XRZHeroVidoViewController : UIViewController
@property (nonatomic,strong) XRZHerosModel *model;
@property (nonatomic,strong) XRZVidoModel *vidoModel;
@end
