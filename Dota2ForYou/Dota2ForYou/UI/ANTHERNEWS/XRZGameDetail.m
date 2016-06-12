//
//  XRZGameDetail.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/11.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZGameDetail.h"
#import <AVFoundation/AVFoundation.h>
@interface XRZGameDetail ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic,copy) NSString *urlStr;

@property (nonatomic,strong) UIActivityIndicatorView *actView;

@end

@implementation XRZGameDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self loadData];
    
}

-(void)loadData
{
    if (_headModel.aid.length == 0) {
        _urlStr = [NSString stringWithFormat:Other_detail_Url,_otherModel.aid];
    }else{
        _urlStr = [NSString stringWithFormat:Other_detail_Url,_headModel.aid];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64)];
    _actView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(SCREEN_W/2, SCREEN_H/2, 0, 0)];
    _actView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:_actView];
    _webView.scrollView.bounces = NO;
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    [_webView setDelegate:self];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}


-(void)setNav
{
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:nil image:[UIImage imageNamed:@"common_back_button.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [_actView stopAnimating];
    
    NSLog(@"加载完成");
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"已经在加载");
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [_actView startAnimating];
    
    return YES;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end
