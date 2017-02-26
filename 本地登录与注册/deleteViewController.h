//
//  deleteViewController.h
//  本地登录与注册
//
//  Created by 周亚-Sun on 2017/2/16.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYDataBase.h"
#import "ZYalert.h"
#import <sqlite3.h>

@interface deleteViewController : UIViewController

/** 用户名 */
@property (weak, nonatomic) IBOutlet UITextField *usersName;
/** 密码*/
@property (weak, nonatomic) IBOutlet UITextField *password;
/** 删除按钮*/
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
///删除事件
- (IBAction)deleteClick:(UIButton *)sender;

@end
