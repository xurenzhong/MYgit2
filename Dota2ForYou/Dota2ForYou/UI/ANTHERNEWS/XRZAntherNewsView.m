//
//  XRZAntherNewsView.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/3/31.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZAntherNewsView.h"
#import "BookLayout.h"
#import "BookCell.h"
#import "XRZOtherDetailController.h"
@interface XRZAntherNewsView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) NSMutableArray *arrayStr;

@property (nonatomic,strong) UIImageView *fotView;

@property (nonatomic,strong) UIImageView *backGroundView;


@end

@implementation XRZAntherNewsView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackground];
    
    [self addBookView];
    
}

#pragma mark - 代理实现
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = @[@"",@"魔兽世界",@"风暴英雄",@"炉石传说",@"暗黑破坏神3",@"星际2",@"守望先锋",@"攻略",@"幻化",@""];
    BookCell *cell = (BookCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.row > 1 && indexPath.row < 10) {
        XRZOtherDetailController *detailView = [[XRZOtherDetailController alloc] init];
        detailView.navigationController.navigationBar.hidden = NO;
        detailView.title = cell.textLabel.text;
        [self.navigationController pushViewController:detailView animated:YES];
    }else if (indexPath.row == 10 ) {
        XRZOtherDetailController *detailView = [[XRZOtherDetailController alloc] init];
        detailView.navigationController.navigationBar.hidden = NO;
        int number = collectionView.contentOffset.x / (300.0/320 * SCREEN_W);
        if (number < 4) {
        detailView.title = array[2*number+1];
        [self.navigationController pushViewController:detailView animated:YES];
        }
    }else
    {
        return;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_array[indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _arrayStr[indexPath.row]];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.imageView.tag = indexPath.row;
    cell.textLabel.font = [UIFont systemFontOfSize:15 weight:1.2];
    return cell;
}

static NSString *const reuseIdentifier = @"cell";

#pragma mark - 添加书签视图
-(void)addBookView
{
    BookLayout *layout = [[BookLayout alloc] init];
    UICollectionView *book = [[UICollectionView alloc] initWithFrame:CGRectMake(10.0/320 * SCREEN_W, 30.0/SCREEN_H * SCREEN_H, 300.0/320 * SCREEN_W, 500.0/568 * SCREEN_H) collectionViewLayout:layout];
    book.delegate = self;
    book.dataSource = self;
    book.backgroundColor = [UIColor clearColor];
    [book registerClass:[BookCell class] forCellWithReuseIdentifier:reuseIdentifier];
    book.showsHorizontalScrollIndicator = NO;
    _array = (NSMutableArray *)@[@"",@"封面.jpg",@"wower.jpg",@"wind.jpg",@"stone.jpg",@"dark3.jpg",@"stars2.jpg",@"watch.jpg",@"blz.jpg",@"cosplay.jpg",@"封底.jpg",@""];
    _arrayStr = (NSMutableArray *)@[@"",@"",@"魔兽世界",@"风暴英雄",@"炉石传说",@"暗黑破坏神3",@"星际2",@"守望先锋",@"攻略",@"幻化",@"",@""];
    [self.view addSubview:book];
}

-(void)setBackground
{
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.translucent = NO;
    _backGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, self.view.frame.size.height)];
    _backGroundView.image = [UIImage imageNamed:@"anther_bg.jpg"];
    [self.view addSubview:_backGroundView];
}
@end
