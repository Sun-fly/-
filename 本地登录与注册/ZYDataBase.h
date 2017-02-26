//
//  ZYDataBase.h
//  本地登录与注册
//
//  Created by 周亚-Sun on 2017/2/16.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ZYalert.h"
@interface ZYDataBase : NSObject
/**
 打开数据库

 @param _name 数据库名
 @return 打开成功或失败
 */
+(BOOL)openDatabase:(NSString *)_name;
/**
 运行数据库

 @param _sql sql
 @return 运行成功或失败
 */
+(BOOL)exexsql:(NSString *)_sql;
/**
 获取db

 @return db
 */
+(sqlite3 *)db;
@end
