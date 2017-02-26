//
//  ZYDataBase.m
//  本地登录与注册
//
//  Created by 周亚-Sun on 2017/2/16.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "ZYDataBase.h"
static sqlite3 *db=NULL;
@implementation ZYDataBase
+(BOOL)openDatabase:(NSString *)_name{
    NSString *path=NSHomeDirectory();
    NSLog(@"path====%@/users.sqlite",path);
    path=[path stringByAppendingPathComponent:_name];
    int result=sqlite3_open([path UTF8String], &db);
    if (result != SQLITE_OK) {
        [ZYalert alert:@"数据库打开失败！"];
        return NO;
    }
    return YES;
}
+(BOOL)exexsql:(NSString *)_sql{
    char *error;
    int result=sqlite3_exec(db, [_sql UTF8String], NULL, NULL, &error);
    if (result !=SQLITE_OK) {
        [ZYalert alert:@"数据库运行失败！"];
        return NO;
    }
    return YES;
}


+(sqlite3 *)db{
    return db;
}
@end
