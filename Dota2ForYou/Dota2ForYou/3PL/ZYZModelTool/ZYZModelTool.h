//
//  ZYZModelTool.h
//  03-KVC
//
//  Created by Jarvan on 15/12/24.
//  Copyright (c) 2015年 Jarvan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYZModelTool : NSObject

/** 
 无返回值;
 dict:传入要转模型的字典;
 modelName:将字典转成的模型类名
 注:Number也是用NSString来处理
 */
+ (void)modelToolWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName;


@end
