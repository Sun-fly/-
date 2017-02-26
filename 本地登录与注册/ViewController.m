//
//  ViewController.m
//  本地登录与注册
//
//  Created by 周亚-Sun on 2017/2/15.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "ViewController.h"
#import "ZYDataBase.h"
#import "ZYalert.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isRember=NO;
    [self.isRemberButton setBackgroundImage:[UIImage imageNamed:@"wei"] forState:UIControlStateNormal];
    //如果打开数据库失败
    if ([ZYDataBase openDatabase:@"users.sqlite"]==NO) {
        self.view.userInteractionEnabled = NO;
    }
    
    //如果运行数据库失败
    NSString *sql=@"create table if not exists t_users(userName text not null,password text not null)";
    if ([ZYDataBase exexsql:sql]==NO) {
        self.view.userInteractionEnabled=NO;
    }
    
    NSString *usersName=[[NSUserDefaults standardUserDefaults]objectForKey:@"USERSNAME"];
    NSString *password=[[NSUserDefaults standardUserDefaults]objectForKey:@"PASSWORD"];
    if (usersName.length>0 &&password.length>0) {
        isRember=YES;
        [self.isRemberButton setBackgroundImage:[UIImage imageNamed:@"yi.png"] forState:UIControlStateNormal];
        self.userName.text=usersName;
        self.password.text=password;
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)isRemberClick:(UIButton *)sender {
    if (isRember==NO) {
        [self.isRemberButton setBackgroundImage:[UIImage imageNamed:@"yi"] forState:UIControlStateNormal];
        isRember=YES;
    }else{
        [self.isRemberButton setBackgroundImage:[UIImage imageNamed:@"wei"] forState:UIControlStateNormal];
        isRember=NO;
    }
}

- (IBAction)loadClick:(UIButton *)sender {
    NSLog(@"登录按钮");
    NSString *userName=self.userName.text;
    NSString *password=self.password.text;
    userName =[ZYalert Trim:userName];
    password =[ZYalert Trim:password];
    if ([ZYalert check:userName andMessage:@"账号不能为空,你必须填写!"] ==NO ) {
        return;
    }
    if ([ZYalert check:password andMessage:@"密码不能为空，你必须填写!"] ==NO) {
        return;
    }
    [self closeKey:nil];
    [self lockview:NO andshowtitle:@"正在登录中。。。" andSender:self.loadButton];
    //判断用户是否存在
    sqlite3_stmt *stmt;
    char *sql="select * from t_users where userName=? and password=?";
    if(sqlite3_prepare_v2([ZYDataBase db], sql, -1, &stmt, NULL)!=SQLITE_OK){
        [ZYalert alert:@"数据库操作失败！"];
        sqlite3_finalize(stmt);
        
    }
    if(sqlite3_bind_text(stmt, 1, [userName UTF8String], -1, NULL)!=SQLITE_OK){
        [ZYalert alert:@"绑定用户失败！"];
        sqlite3_finalize(stmt);
        return;
    }
    if(sqlite3_bind_text(stmt, 2, [password UTF8String], -1, NULL)!=SQLITE_OK){
        [ZYalert alert:@"绑定密码失败！"];
        sqlite3_finalize(stmt);
        return;
    }
    if (sqlite3_step(stmt)==SQLITE_ROW) {
        NSLog(@"登录成功！");
        if (isRember) {
            [[NSUserDefaults standardUserDefaults]setObject:userName forKey:@"USERSNAME"];
            [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"PASSWORD"];
        }
        else{
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"USERSNAME"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"PASSWORD"];
        }
        
        [self performSegueWithIdentifier:@"zypush" sender:nil];
    }else{
        [ZYalert alert:@"登录失败，请仔细核对你的信息！"];
        [self lockview:YES andshowtitle:@"登录" andSender:self.loadButton];
        sqlite3_finalize(stmt);
        return;
    }
    [self lockview:YES andshowtitle:@"登录" andSender:self.loadButton];
    
    
}

- (IBAction)registerClick:(UIButton *)sender {
    NSLog(@"注册按钮");
    NSString *userName=self.userName.text;
    NSString *password=self.password.text;
    userName=[ZYalert Trim:userName];
    password=[ZYalert Trim:password];
    if ([ZYalert check:userName andMessage:@"账号不能为空，你必须填写！"]==NO) {
        return;
    }
    if ([ZYalert check:password andMessage:@"密码不能为空，你必须填写!"] ==NO) {
        return;
    }
    [self closeKey:nil];
    [self lockview:NO andshowtitle:@"正在注册中。。。" andSender:self.registerButton ];
    //判断用户是否存在
    sqlite3_stmt *stmt;
    char *sql="select * from t_users where userName=? ";
    
    if(sqlite3_prepare_v2([ZYDataBase db], sql, -1, &stmt, NULL)!=SQLITE_OK)
    {
        [ZYalert alert:@"数据库操作失败！"];
        sqlite3_finalize(stmt);
        
    }
    if(sqlite3_bind_text(stmt, 1, [userName UTF8String], -1, NULL)!=SQLITE_OK){
        [ZYalert alert:@"数据绑定失败，请稍后再试！"];
        sqlite3_finalize(stmt);
        
    }
        
    if (sqlite3_step(stmt)==SQLITE_ROW) {
        [ZYalert alert:@"用户已经存在，请更换用户名！"];
        [self lockview:YES andshowtitle:@"注册" andSender:self.registerButton];
        sqlite3_finalize(stmt);
    }
    else{
        sqlite3_finalize(stmt);
        char *sql="insert into t_users values(?,?)";
        if(sqlite3_prepare_v2([ZYDataBase db], sql, -1, &stmt, NULL)!=SQLITE_OK){
            [ZYalert alert:@"数据库操作失败！"];
            sqlite3_finalize(stmt);
        }
        if(sqlite3_bind_text(stmt, 1, [userName UTF8String], -1, NULL)!=SQLITE_OK){
            [ZYalert alert:@"绑定用户失败！"];
            sqlite3_finalize(stmt);
            return;
        }
        if(sqlite3_bind_text(stmt, 2, [password UTF8String], -1, NULL)){
            [ZYalert alert:@"绑定密码失败！"];
            sqlite3_finalize(stmt);
            return;
        }
        if (sqlite3_step(stmt)!=SQLITE_DONE) {
            [ZYalert alert:@"注册失败，请稍后再试！"];
            sqlite3_finalize(stmt);
            return;
            
        }else{
            [ZYalert alert:@"注册成功！"];
            [self lockview:YES andshowtitle:@"注册" andSender:self.registerButton ];
            sqlite3_finalize(stmt);
            return;
       }
        }
    
    [self lockview:YES andshowtitle:@"注册" andSender:self.registerButton ];
    
    
}
///锁定视图和更换按钮文本
-(void)lockview:(BOOL)_lock andshowtitle:(NSString *)_str andSender:(UIButton *)_sender
{
    [_sender setTitle:_str forState:UIControlStateNormal];
    self.view.userInteractionEnabled=_lock;
}

- (IBAction)closeKeyBoard:(UITextField *)sender {
    
}

- (IBAction)closeKey:(id)sender {
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
}




@end
