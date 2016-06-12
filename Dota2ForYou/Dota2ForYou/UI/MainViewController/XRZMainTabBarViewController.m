//
//  XRZMainTabBarViewController.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/3/31.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZMainTabBarViewController.h"

@interface XRZMainTabBarViewController ()

@property (nonatomic,strong) NSMutableArray *viewsController;

@end

@implementation XRZMainTabBarViewController


-(UIViewController *)addtabBarItemsOfViewWithClassName:(NSString *)className image:(UIImage *)image title:(NSString *)title select:(UIImage *)selectImage
{
    Class vcClass = NSClassFromString(className);
    UIViewController *viewControl = [[vcClass alloc]init];
    UINavigationController *navigationControl = [[UINavigationController alloc] initWithRootViewController:viewControl];
    [navigationControl.tabBarItem setTitle:title];
    viewControl.title = title;
    [navigationControl.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [navigationControl.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    navigationControl.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    [navigationControl.navigationBar setBackgroundImage:[[UIImage imageNamed:@"CustomizedNavBarBg.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forBarMetrics:UIBarMetricsDefault];
    
    [navigationControl.tabBarItem setImage:image];
    
    [navigationControl.tabBarItem setSelectedImage:selectImage];
    
    navigationControl.tabBarController.tabBar.translucent = YES;
    [_viewsController addObject:navigationControl];
    self.viewControllers = _viewsController;
    return viewControl;
}

//设置为竖屏
- (BOOL) shouldAutorotate

{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewsController = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
