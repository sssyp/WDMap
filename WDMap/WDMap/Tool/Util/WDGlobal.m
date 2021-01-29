//
//  WDGlobal.m
//  Class
//
//  Created by wbb on 2020/3/4.
//  Copyright © 2020 WD. All rights reserved.
//

#import "WDGlobal.h"
#import "WDBaseTabBarController.h"
#import "WDLoginVC.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation WDGlobal

/// 是否是老师
+ (BOOL)isTeacher {
    
    NSString *role = [WDUtil getInfoForKey:WD_USERROLE];
    if (role && role.length > 0) {
        return [role integerValue] == 2 ? YES : NO;
    }
    return NO;
}
+ (NSString *)token {
    NSString *token = [WDUtil getInfoForKey:WD_TOKEN];
    if (token && token.length > 0) {
        return token;
    }
    return @"";
}

+ (BOOL)isLogin {
    if ([WDGlobal token].length>0) {
        return YES;
    }
    return NO;
}

+ (NSString *)getName {
    NSString *userName = [WDUtil getInfoForKey:WD_USERNAME];
    NSString *realName = [WDUtil getInfoForKey:WD_REALNAME];
    if (realName&&realName.length>0) {
        return realName;
    }
    return userName?:@"";
}

+ (WDBiometryType )biometryType {
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        if (@available(iOS 11.0, *)) {
            switch (context.biometryType) {
                case LABiometryTypeNone:
                {
                    return WDBiometryNone;
                }
                    break;
                case LABiometryTypeTouchID:
                {
                    return WDBiometryTypeTouchID;
                }
                    break;
                case LABiometryTypeFaceID:
                {
                    return WDBiometryTypeFaceID;
                }
                    break;
                default:
                    break;
            }
        } else {
            return WDBiometryTypeTouchID;
        }
    }
    return WDBiometryNone;
    
}
+ (UIViewController *)getCurrentViewController {
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    //获取根控制器
    UIViewController* currentViewController = window.rootViewController;
    //获取当前页面控制器
    BOOL runLoopFind = YES;
    while (runLoopFind){
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]){
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            } else {
                return currentViewController;
            }
        }
    }
    return currentViewController;
}

+ (void)showAlertView:(NSString *)msg {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [[WDGlobal getCurrentViewController] presentViewController:alertController animated:YES completion:nil];
}



+ (void)ty_alertController:(NSString *)title message:(nullable NSString *)message currentContorller:(UIViewController *)controller cancelButtonTitle:(nullable NSString *)cancelButtonTitle sureButtonTitle:(nullable NSString *)sureButtonTitle cancelHandler:(void (^)(void))cancelHandler sureHandler:(void (^)(void))sureHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    if (sureButtonTitle) {
        [alert addAction:[UIAlertAction actionWithTitle:sureButtonTitle
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
            sureHandler();
        }]];
    }
    
    if (cancelButtonTitle) {
         [alert addAction:[UIAlertAction actionWithTitle:cancelButtonTitle
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action) {
               cancelHandler();
           }]];
    }
   
//    UIView *subView1 = alert.view.subviews[0];
//    UIView *subView2 = subView1.subviews[0];
//    UIView *subView3 = subView2.subviews[0];
//    UIView *subView4 = subView3.subviews[0];
//    UIView *subView5 = subView4.subviews[0];
//    //取title和message：
//    UILabel *message1 = subView5.subviews[1];
//    message1.textAlignment = NSTextAlignmentLeft;

    [controller presentViewController:alert animated:YES completion:nil];
}

+ (NSString *)ty_jsonStringforDic:(NSDictionary *)dic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;

    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (void)changeRootVCToTabbarVC {
    WDBaseTabBarController *tabBar = [[WDBaseTabBarController alloc] init];
    CATransition *transtition = [CATransition animation];
    transtition.duration = 0.5;
    transtition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transtition forKey:@"animation"];
}
+ (void)changeRootVCToLoginVC {
    WDLoginVC *tabBar = [[WDLoginVC alloc] init];
    CATransition *transtition = [CATransition animation];
    transtition.duration = 0.5;
    transtition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transtition forKey:@"animation"];
}
// 根据文字大小和控件宽度计算控件高度
+ (CGFloat)heightForText:(NSString *)text textFont:(CGFloat)fontSize standardWidth:(CGFloat)controlWidth
{
    if ([text length]==0) {
        return 0;
    }else {
        NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
        return [text boundingRectWithSize:CGSizeMake(controlWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.height;
    }
}

+ (CGFloat)widthForText:(NSString *)text textFont:(CGFloat)fontSize  standardHeight:(CGFloat)controlHeight
{
    if ([text length]==0) {
        return 0;
    }else {
        NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
        return  [text boundingRectWithSize:CGSizeMake(1000,controlHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.width;
    }
}

@end
