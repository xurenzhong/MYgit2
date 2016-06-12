//
//  XRZMainTabBarViewController.h
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/3/31.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRZMainTabBarViewController : UITabBarController

/** 创建基本视图*/
-(UIViewController *) addtabBarItemsOfViewWithClassName:(NSString *)className
                                                  image:(UIImage *)image
                                                  title:(NSString *)title
                                                 select:(UIImage *)selectImage;

@end
