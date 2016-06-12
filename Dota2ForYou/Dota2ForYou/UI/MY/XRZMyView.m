//
//  XRZMyView.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/3/31.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZMyView.h"
#import "XRZLuckyViewController.h"
#import "XRZMyInfoController.h"
@interface XRZMyView ()<UIAlertViewDelegate>
- (IBAction)luckyButton:(UIButton *)sender;
- (IBAction)clearDataButton:(UIButton *)sender;
- (IBAction)goToApp:(UIButton *)sender;
- (IBAction)infoOfUsButton:(UIButton *)sender;
@end

@implementation XRZMyView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)luckyButton:(UIButton *)sender {
    XRZLuckyViewController *luckyView = [[XRZLuckyViewController alloc] init];
    [self.navigationController pushViewController:luckyView animated:YES];
}

- (IBAction)clearDataButton:(UIButton *)sender {
    float size = [[SDImageCache sharedImageCache] getSize];
    NSString *str = [NSString stringWithFormat:@"共有%.2fM缓存",size/1024/1024];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"是否清除缓存？" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.delegate = self;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[SDImageCache sharedImageCache] clearDisk];
    }
}

- (IBAction)goToApp:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/le-you-bao-zhu-shou/id1103088584?mt=8"]];
}

- (IBAction)infoOfUsButton:(UIButton *)sender {
    XRZMyInfoController *myView = [[XRZMyInfoController alloc] init];
    [self.navigationController pushViewController:myView animated:YES];
}
@end
