//
//  XRZStoryOfHero.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/8.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZStoryOfHero.h"

@interface XRZStoryOfHero ()


@end

@implementation XRZStoryOfHero

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self makeUI];
}

-(void)makeUI
{
    UITextView *storyView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    storyView.text = _model.story;
    storyView.font = [UIFont systemFontOfSize:20 weight:1.5];
    [self.view addSubview:storyView];
}

-(void) setNav
{
    self.tabBarController.tabBar.hidden = YES;
    self.title = [NSString stringWithFormat:@"%@",_model.hero_cnname];
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:nil image:[UIImage imageNamed:@"common_back_button.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

@end
