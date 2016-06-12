//
//  XRZMyInfoController.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/12.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZMyInfoController.h"

@interface XRZMyInfoController ()

@end

@implementation XRZMyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    
}

-(void) makeUI
{
    self.tabBarController.tabBar.hidden = YES;
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:nil image:[UIImage imageNamed:@"common_back_button.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        self.tabBarController.tabBar.hidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

@end
