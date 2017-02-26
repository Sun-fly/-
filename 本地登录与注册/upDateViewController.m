//
//  upDateViewController.m
//  本地登录与注册
//
//  Created by 周亚-Sun on 2017/2/16.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "upDateViewController.h"
#import "ViewController.h"
@interface upDateViewController ()

@end

@implementation upDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateUsrsNameClick:(UIButton *)sender {
    NSString *oldUserName=self.oldUsersName.text;
    NSString *userName=self.userName.text;
    oldUserName=[ZYalert Trim:oldUserName];
    userName=[ZYalert Trim:userName];
    if ([ZYalert check:oldUserName andMessage:@"原用户名不能为空！"]==NO) {
        return;
    }
    if ([ZYalert check:userName andMessage:@"新用户名不能为空！"]==NO) {
        return;
    }
    //判断
    sqlite3_stmt *stmt;
    char *sql="select * from t_users where userName=?";
    if (sqlite3_prepare_v2([ZYDataBase db], sql, -1, &stmt, NULL)!=SQLITE_OK) {
        [ZYalert alert:@"数据库操作失败！"];
        sqlite3_finalize(stmt);
        return;
    }
    sqlite3_bind_text(stmt, 1, [oldUserName UTF8String], -1, NULL);
    if (sqlite3_step(stmt)!=SQLITE_ROW) {
        [ZYalert alert:@"原用户名不存在"];
        sqlite3_finalize(stmt);
        return;
    }
    else{
        char *sql="update t_users set userName=? ";
        if (sqlite3_prepare_v2([ZYDataBase db], sql, -1, &stmt, NULL)!=SQLITE_OK) {
            [ZYalert alert:@"数据库操作失败"];
            sqlite3_finalize(stmt);
            return;
        }
        
        sqlite3_bind_text(stmt, 1, [userName UTF8String], -1, NULL);
        
        if (sqlite3_step(stmt)!=SQLITE_DONE) {
            [ZYalert alert:@"用户名修改失败"];
            sqlite3_finalize(stmt);
            return;
        }
        else{
            [ZYalert alert:@"恭喜你，用户名修改成功！"];
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[ViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
            sqlite3_finalize(stmt);
            return;
        }
    }
}

- (IBAction)updatePaswordClick:(UIButton *)sender {
    NSString *oldpassword=self.oldPassword.text;
    NSString *password=self.passwords.text;
    oldpassword=[ZYalert Trim:oldpassword];
    password=[ZYalert Trim:password];
    if ([ZYalert check:oldpassword andMessage:@"原密码不能为空！"]==NO) {
        return;
    }
    if ([ZYalert check:password andMessage:@"新密码不能为空！"]==NO) {
        return;
    }
    //判断
    sqlite3_stmt *stmt;
    char *sql="select * from t_users where password=?";
    if (sqlite3_prepare_v2([ZYDataBase db], sql, -1, &stmt, NULL)!=SQLITE_OK) {
        [ZYalert alert:@"数据库操作失败！"];
        sqlite3_finalize(stmt);
        return;
    }
    sqlite3_bind_text(stmt, 1, [oldpassword UTF8String], -1, NULL);
    
    if (sqlite3_step(stmt)!=SQLITE_ROW) {
        [ZYalert alert:@"原密码不存在"];
        sqlite3_finalize(stmt);
        return;
    }
    else{
        char *sql="update t_users set password=? ";
        if (sqlite3_prepare_v2([ZYDataBase db], sql, -1, &stmt, NULL)!=SQLITE_OK) {
            [ZYalert alert:@"数据库操作失败"];
            sqlite3_finalize(stmt);
            return;
        }
         sqlite3_bind_text(stmt, 1, [password UTF8String], -1, NULL);
        
        if (sqlite3_step(stmt)!=SQLITE_DONE) {
            [ZYalert alert:@"密码修改失败"];
            sqlite3_finalize(stmt);
            return;
        }
        else{
            [ZYalert alert:@"恭喜你，密码修改成功！"];
            //跳转页面
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[ViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
            sqlite3_finalize(stmt);
            return;
        }
     }
}
@end
