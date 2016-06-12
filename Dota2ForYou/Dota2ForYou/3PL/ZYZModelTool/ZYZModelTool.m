
//
//  ZYZModelTool.m
//  03-KVC
//
//  Created by Jarvan on 15/12/24.
//  Copyright (c) 2015年 Jarvan. All rights reserved.
//

#import "ZYZModelTool.h"

@implementation ZYZModelTool

+ (void)modelToolWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName{
    printf("\n@interface %s : NSObject\n",modelName.UTF8String);
    
    
    for (NSString *key in dict) {
        if ([dict[key] isKindOfClass:[NSString class]]) { // 字符串类型
            NSString *type = @"NSString";
            printf("@property (nonatomic,copy) %s *%s;\n",type.UTF8String,key.UTF8String);
        }else if ([dict[key] isKindOfClass:[NSArray class]]){ // 数组类型
            NSString *type = @"NSArray";
            printf("@property (nonatomic,strong) %s *%s;\n",type.UTF8String,key.UTF8String);
        }else if ([dict[key] isKindOfClass:[NSNumber class]]){   // 整形
//            NSString *type = @"NSNumber";
//            printf("@property (nonatomic,assign) %s *%s;\n",type.UTF8String,key.UTF8String);
            // 整形也用字符串接收
            NSString *type = @"NSString";
            printf("@property (nonatomic,copy) %s *%s;\n",type.UTF8String,key.UTF8String);
        }
    }
    
    
    printf("@end\n");
}

@end
