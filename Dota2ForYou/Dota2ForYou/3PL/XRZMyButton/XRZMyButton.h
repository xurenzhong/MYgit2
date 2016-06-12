//
//  XRZMyButton.h
//  LoveLimitFree
//
//  Created by XuRenzhong on 16/3/22.
//  Copyright © 2016年 XuRenzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XRZMyButton ;

typedef void(^MyBlcok)(XRZMyButton *button);

@interface XRZMyButton : UIButton

@property (nonatomic,copy) MyBlcok buttonBlock;

/** 类方法，快速实例化按钮*/
+ (instancetype)addBlockButtonWithFrame:(CGRect)frame
                                  title:(NSString *)title
                                  image:(UIImage *)image
                                bgImage:(UIImage *)bgImage
                                    tag:(int)tag
                            actionBlock:(MyBlcok)actionBlock;


@end
