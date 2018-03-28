//
//  UIView+Extension.m
//  MoveView
//
//  Created by wenHao Qiu on 2017/7/25.
//  Copyright © 2017年 fahai. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

#pragma mark ------------ Setters ------------
- (void)setX:(CGFloat)x {
    
    CGRect nF      = self.frame;
    
    nF.origin.x    = x;
    
    self.frame     = nF;
}

- (void)setY:(CGFloat)y {
    
    CGRect nF      = self.frame;
    
    nF.origin.y    = y;
    
    self.frame     = nF;
    
}

- (void)setWidth:(CGFloat)width {
    
    CGRect nF      = self.frame;
    
    nF.size.width  = width;
    
    self.frame     = nF;
    
}

- (void)setHeight:(CGFloat)height {
    
    CGRect nF      = self.frame;
    
    nF.size.height = height;
    
    self.frame     = nF;
}

- (void)setOrigin:(CGPoint)origin {
    
    self.x         = origin.x;
    
    self.y         = origin.y;
}

- (void)setSize:(CGSize)size {
    
    self.width     = size.width;
    
    self.height    = size.height;
    
}

- (void)setRight:(CGFloat)right {
    
    self.x         = right - self.width;
}

- (void)setBottom:(CGFloat)bottom {
    
    self.y         = bottom - self.height;
    
}

- (void)setCenterX:(CGFloat)centerX {
    
    self.center    = CGPointMake(centerX, self.center.y);
    
}

- (void)setCenterY:(CGFloat)centerY {
    
    self.center    = CGPointMake(self.center.x, centerY);
    
}

#pragma mark ------------ Getter ------------
- (CGFloat)x {
    
    return self.frame.origin.x;
}

- (CGFloat)y {
    
    return self.frame.origin.y;
}

- (CGFloat)width {
    
    return self.frame.size.width;
}

- (CGFloat)height {
    
    return self.frame.size.height;
}

- (CGPoint)origin {
    
    return self.frame.origin;
}

- (CGSize)size {
    
    return self.frame.size;
}

- (CGFloat)right {
    
    return self.x + self.width;
}

- (CGFloat)bottom {
    
    return self.y + self.height;
}

- (CGFloat)centerX {
    
    return self.center.x;
}

- (CGFloat)centerY {
    
    return self.center.y;
}

- (UIView *)lastSubviewOnX {
    
    if(self.subviews.count > 0){
        
        UIView *outView = self.subviews[0];
        
        for(UIView *v in self.subviews)
        {
            if(v.x > outView.x)
            {
                outView = v;
            }
        }
        return outView;
    }
    
    return nil;
}

- (UIView *)lastSubviewOnY {
    
    if(self.subviews.count > 0){
        
        UIView *outView = self.subviews[0];
        
        for (UIView *v in self.subviews)
        {
            if (v.y > outView.y)
            {
                outView = v;
            }
        }
        return outView;
    }
    
    return nil;
}

#pragma mark ------------ 移除此view上的所有子视图 ------------
- (void)removeAllSubviews {
    
    for (UIView *v in self.subviews)
    {
        [v removeFromSuperview];
    }
    return;
}

#pragma mark ------------ 弹窗 ------------
+ (void)showAlertView:(NSString *)title andMessage:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    });
}

#pragma mark ------------ 带代理的弹窗 ------------
+ (void)showAlertView:(NSString *)title
           andMessage:(NSString *)message
         withDelegate:(UIViewController<UIAlertViewDelegate> *)delegate {
    
    dispatch_async(dispatch_get_main_queue() , ^{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        alert = nil;
        
    });
    
}

#pragma mark ------------ 多个提示按钮 ------------
+ (void)showAlertView:(NSString *)title andMessage:(NSString *)message withDelegate:(UIViewController<UIAlertViewDelegate> *)delegate tag:(NSInteger)tag cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    //dispatch_async(dispatch_get_main_queue() , ^{
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    
    alert.title = title;
    
    alert.message = message;
    
    alert.delegate = delegate;
    
    alert.tag = tag;
    
    if (cancelButtonTitle)
    {
        [alert addButtonWithTitle:cancelButtonTitle];
    }
    if (otherButtonTitles) {
        
        [alert addButtonWithTitle:otherButtonTitles];
        
        NSString *buttonTitle = nil;
        
        va_list argumentList;
        
        va_start(argumentList, otherButtonTitles);
        
        while ((buttonTitle = va_arg(argumentList, NSString *)))
        {
            [alert addButtonWithTitle:buttonTitle];
        }
        
        va_end(argumentList);
    }
    
    [alert show];
    
    alert = nil;
    
    // });
    
}

@end
