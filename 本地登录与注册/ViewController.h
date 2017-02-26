//
//  ViewController.h
//  本地登录与注册
//
//  Created by 周亚-Sun on 2017/2/15.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYalert.h"
#import "ZYDataBase.h"
@interface ViewController : UIViewController
{
    BOOL isRember;//是否记住
}
/** 用户名 */
@property (weak, nonatomic) IBOutlet UITextField *userName;
/** 密码 */
@property (weak, nonatomic) IBOutlet UITextField *password;
/** 记住按钮 */
@property (weak, nonatomic) IBOutlet UIButton *isRemberButton;
/** 登录按钮 */
@property (weak, nonatomic) IBOutlet UIButton *loadButton;
/** 注册按钮 */
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
/** 点击输入框关闭键盘 */
- (IBAction)closeKeyBoard:(UITextField *)sender;
/** 点击其他区域关闭键盘 */
- (IBAction)closeKey:(id)sender;


/** 是否记住事件 */
- (IBAction)isRemberClick:(UIButton *)sender;
/** 登录事件 */
- (IBAction)loadClick:(UIButton *)sender;
/** 注册事件 */
- (IBAction)registerClick:(UIButton *)sender;

@end

