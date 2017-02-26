//
//  deleteViewController.m
//  本地登录与注册
//
//  Created by 周亚-Sun on 2017/2/16.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "deleteViewController.h"

#import "ViewController.h"
@interface deleteViewController ()

@end

@implementation deleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)deleteClick:(UIButton *)sender {
    

    //获取用户信息，密码
    NSString *userName=self.usersName.text;
    NSString *password=self.password.text;
    userName=[ZYalert Trim:userName];
    password=[ZYalert Trim:password];
    if ([ZYalert check:userName andMessage:@"请输入要删除的用户名！"]==NO) {
        return;
    }
    if ([ZYalert check:password andMessage:@"请输入用户名对应的密码！"]==NO) {
        return;
    }
    
    //判断用户是否存在
    sqlite3_stmt *stmt;
   char *sql="select * from t_users where userName=? and password=? ";
    if (sqlite3_prepare_v2([ZYDataBase db], sql, -1, &stmt, NULL)!=SQLITE_OK)
    {
        [ZYalert alert:@"操作数据库失败！"];
        sqlite3_finalize(stmt);
    }
    if(sqlite3_bind_text(stmt, 1, [userName UTF8String], -1, NULL)!=SQLITE_OK){
        [ZYalert alert:@"用户名绑定失败！"];
        sqlite3_finalize(stmt);
        
    }
    if(sqlite3_bind_text(stmt, 2, [password UTF8String], -1, NULL)!=SQLITE_OK){
        [ZYalert alert:@"密码绑定失败！"];
        sqlite3_finalize(stmt);
    }
    if (sqlite3_step(stmt)!=SQLITE_ROW) {
        [ZYalert alert:@"用户或密码输入错误，请重新确认！"];
        
        sqlite3_finalize(stmt);
        return;
    }
    else{
        char *sql ="delete from t_users where userName=?";
        if (sqlite3_prepare_v2([ZYDataBase db], sql, -1, &stmt, NULL)!=SQLITE_OK) {
            [ZYalert alert:@"预处理失败！"];
            sqlite3_finalize(stmt);
            return;
        }
        if (sqlite3_bind_text(stmt, 1, [userName UTF8String], -1, NULL)!=SQLITE_OK) {
            [ZYalert alert:@"删除-绑定失败！"];
            sqlite3_finalize(stmt);
        }
        if (sqlite3_step(stmt)!=SQLITE_DONE) {
            [ZYalert alert:@"删除失败！"];
            sqlite3_finalize(stmt);
            return;
        }
        else{
            [ZYalert alert:@"删除成功！"];
            for (UIViewController *viewController in self.navigationController.viewControllers) {
                if ([viewController isKindOfClass:[ViewController class]]) {
                    [self.navigationController popToViewController:viewController animated:YES];
                }
            }
            
            sqlite3_finalize(stmt);
            return;
        }
    }
}


@end
