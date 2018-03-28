//
//  UIBarButtonItem+Extension.h
//  Objective-C新浪微博
//
//  Created by Changqing Qu on 2017/2/9.
//  Copyright © 2017年 Changqing Qu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)title:(NSString *)title
                  fontSize:(CGFloat)fontSize
                    target:(id)target
                    action:(SEL)action;

@end
