//
//  XRZInfoDetailController.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/11.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZInfoDetailController.h"
#import "XRZInfoDetailModel.h"
@interface XRZInfoDetailController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIImagePickerController *pickController;

@property (nonatomic,strong) UIImageView *imgView;
@end

@implementation XRZInfoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self loadData];
    
}

#pragma mark - 保存图片
-(void) saveImageToPhone
{
    UIImageWriteToSavedPhotosAlbum(self.imgView.image, nil, nil, nil);
    _pickController = [[UIImagePickerController alloc] init];
    _pickController.delegate = self;
    _pickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self  presentViewController:_pickController animated:YES completion:nil];
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int number = _scrollView.contentOffset.x/SCREEN_W + 1;
    XRZInfoDetailModel *model = _dataArray[number-1];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.title = [NSString stringWithFormat:@"%d of %lu",number,(unsigned long)_dataArray.count];
}


#pragma mark - 创建滚动视图
-(void) createScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64)];
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(SCREEN_W * _dataArray.count, SCREEN_H - 64);
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_W * _dataArray.count, SCREEN_W, SCREEN_H)];
    XRZInfoDetailModel *model = _dataArray[0];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.url]];
    [_scrollView addSubview:_imgView];
    for (int i = 0; i < _dataArray.count; i++) {
        XRZInfoDetailModel *model = _dataArray[i];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_W * i, 0 , SCREEN_W, SCREEN_H- 64)];
        bgView.userInteractionEnabled = YES;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H -64-100)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"2back2.png"]];
        [bgView addSubview:imgView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_H - 64 - 100, SCREEN_W, 25)];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = model.add_intro;
        [bgView addSubview:label];
        UIImageView *saveView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        saveView.center = CGPointMake(SCREEN_W/2, SCREEN_H - 64 - 50 - 12.5);
        saveView.image = [UIImage imageNamed:@"wall_down.png"];
        saveView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveImageToPhone)];
        [saveView addGestureRecognizer:tap];
        [bgView addSubview:saveView];
        bgView.backgroundColor = [UIColor blackColor];
        [_scrollView addSubview:bgView];
    }
    [self.view addSubview:_scrollView];
}

-(void) loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:Info_detail_Url,_pageIndex,_ID] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in array) {
            XRZInfoDetailModel *model = [[XRZInfoDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [_dataArray addObject:model];
        }
        self.title = [NSString stringWithFormat:@"1 of %ld",_dataArray.count];
        [self createScrollView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"下载数据失败");
    }];
}

-(void) setNav
{
    _dataArray = [NSMutableArray array];
    self.tabBarController.tabBar.hidden = YES;
    XRZMyButton *leftButton = [XRZMyButton addBlockButtonWithFrame:CGRectMake(0, 0, 65, 35) title:nil image:[UIImage imageNamed:@"common_back_button.png"] bgImage:nil tag:1024 actionBlock:^(XRZMyButton *button) {
        self.tabBarController.tabBar.hidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}


@end
