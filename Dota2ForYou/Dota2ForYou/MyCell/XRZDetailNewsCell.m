//
//  XRZDetailNewsCell.m
//  Dota2ForYou
//
//  Created by XuRenzhong on 16/4/7.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import "XRZDetailNewsCell.h"


@interface XRZDetailNewsCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation XRZDetailNewsCell

- (void)awakeFromNib {
    
}

-(void)setModel:(XRZNewsModel *)model
{
    _model = model;
    _titleLabel.text = model.title;
    _postTimeLabel.text = model.posttime;
    _siteLabel.text = model.site;
    _descLabel.text = [NSString stringWithFormat:@"      %@",model.desc];
    _webView.scalesPageToFit = YES;
    [_webView loadHTMLString:model.content baseURL:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
