//
//  ZYalert.m
//  本地登录与注册
//
//  Created by 周亚-Sun on 2017/2/16.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "ZYalert.h"

@implementation ZYalert
+(void)alert:(NSString *)_msg{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:_msg delegate:self cancelButtonTitle:@"我知道了！" otherButtonTitles:nil, nil];
    [alert show];
}
+(NSString *)Trim:(NSString *)_string{
    return [_string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
}
+(BOOL)check:(NSString *)_str andMessage:(NSString *)_msg{
    if ([_str isEqualToString:@""]) {
        [ZYalert alert:_msg];
        return NO;
    }
    return YES;
}

@end
