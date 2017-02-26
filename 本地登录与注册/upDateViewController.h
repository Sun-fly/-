//
//  upDateViewController.h
//  本地登录与注册
//
//  Created by 周亚-Sun on 2017/2/16.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYalert.h"
#import "ZYDataBase.h"
#import <sqlite3.h>

@interface upDateViewController : UIViewController

/** 原用户名 */
@property (weak, nonatomic) IBOutlet UITextField *oldUsersName;
/** 新用户名 */
@property (weak, nonatomic) IBOutlet UITextField *userName;
/** 原密码 */
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
/** 新密码 */
@property (weak, nonatomic) IBOutlet UITextField *passwords;


///修改用户名事件
- (IBAction)updateUsrsNameClick:(UIButton *)sender;

///修改密码事件
- (IBAction)updatePaswordClick:(UIButton *)sender;




@end
