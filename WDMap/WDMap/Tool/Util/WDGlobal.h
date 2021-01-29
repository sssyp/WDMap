//
//  WDGlobal.h
//  Class
//
//  Created by wbb on 2020/3/4.
//  Copyright © 2020 WD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WDBiometryType) {
    WDBiometryTypeFaceID,//人脸识别
    WDBiometryTypeTouchID,//指纹识别
    WDBiometryNone
};

@interface WDGlobal : NSObject
/// 是否是老师
+ (BOOL)isTeacher;
// 用户token
+ (NSString *)token;
// 登录成功
+ (BOOL)isLogin;
// 用户名字
+ (NSString *)getName;
// 识别type
+ (WDBiometryType )biometryType;
// 获取当前controller
+ (UIViewController *)getCurrentViewController;
// 提示弹框
+ (void)showAlertView:(NSString *)msg;
// 弹框
+ (void)ty_alertController:(NSString *)title message:(nullable NSString *)message currentContorller:(UIViewController *)controller cancelButtonTitle:(nullable NSString *)cancelButtonTitle sureButtonTitle:(nullable NSString *)sureButtonTitle cancelHandler:(void (^)(void))cancelHandler sureHandler:(void (^)(void))sureHandler;
// 字典转json
+ (NSString *)ty_jsonStringforDic:(NSDictionary *)dic;
// 修改根视图 到tabbar
+ (void)changeRootVCToTabbarVC;
// 修改根视图 到LoginVC
+ (void)changeRootVCToLoginVC;

// 根据文字大小和控件宽度计算控件高度
+ (CGFloat)heightForText:(NSString *)text textFont:(CGFloat)fontSize standardWidth:(CGFloat)controlWidth;

// 根据文字大小和控件高度计算控件宽度
+ (CGFloat)widthForText:(NSString *)text textFont:(CGFloat)fontSize  standardHeight:(CGFloat)controlHeight;

@end

NS_ASSUME_NONNULL_END
