//
//  XRZAvPlayViewController.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/9.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZAvPlayViewController.h"

@interface XRZAvPlayViewController ()

@end

@implementation XRZAvPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
}

-(void)setNav
{
    self.tabBarController.tabBar.hidden = YES;
    self.title = [NSString stringWithFormat:@"视频播放"];
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:nil image:[UIImage imageNamed:@"common_back_button.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

    


@end
