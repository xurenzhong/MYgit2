//
//  XRZLuckyViewController.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/12.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZLuckyViewController.h"

@interface XRZLuckyViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation XRZLuckyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
}

-(void) makeUI
{
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.translucent = YES;
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:nil image:[UIImage imageNamed:@"common_back_button.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        self.tabBarController.tabBar.hidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:My_lucky_Url]];
    _webView.scalesPageToFit = YES;
    [_webView loadRequest:request];
}
@end
