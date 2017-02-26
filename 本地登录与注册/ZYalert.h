//
//  ZYalert.h
//  本地登录与注册
//
//  Created by 周亚-Sun on 2017/2/16.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZYalert : NSObject

/**
 提醒信息

 @param _msg 告知信息的内容
 */
+(void)alert:(NSString *)_msg;
/**
 删除空格

 @param _string 要处理的字符串
 @return 处理后的字符串
 */
+(NSString *)Trim:(NSString *)_string;
/**
 检验有效性

 @param _str 获取的字符串
 @param _msg 警告知的信息
 @return 是或否
 */
+(BOOL)check:(NSString *)_str andMessage:(NSString *)_msg;

@end
