//
//  UIView+Extension.h
//  MoveView
//
//  Created by wenHao Qiu on 2017/7/25.
//  Copyright © 2017年 fahai. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth                   [[UIScreen mainScreen] bounds].size.width

#define ScreenHeight                  [[UIScreen mainScreen] bounds].size.height

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, strong, readonly) UIView *lastSubviewOnX;

@property (nonatomic, strong, readonly) UIView *lastSubviewOnY;

/**
 移除此view上的所有子视图
 */
- (void)removeAllSubviews;

/**
 弹窗
 
 @param title    弹窗标题
 @param message  弹窗信息
 */
+ (void)showAlertView:(NSString *)title andMessage:(NSString *)message;

/**
 弹窗
 
 @param title    弹窗标题
 @param message  弹窗信息
 @param delegate 弹窗代理
 */
+ (void)showAlertView:(NSString *)title
           andMessage:(NSString *)message
         withDelegate:(UIViewController<UIAlertViewDelegate> *)delegate;

/**
 弹窗
 
 @param title 弹窗标题
 @param message 弹窗信息
 @param delegate 弹窗代理
 @param tag tag值
 @param cancelButtonTitle 取消按钮title
 @param otherButtonTitles 其它按钮title
 */

+ (void)showAlertView:(NSString *)title
           andMessage:(NSString *)message
         withDelegate:(UIViewController<UIAlertViewDelegate> *)delegate tag:(NSInteger)tag
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");

@end
