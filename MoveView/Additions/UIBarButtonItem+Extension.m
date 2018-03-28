//
//  UIBarButtonItem+Extension.m
//  Objective-C新浪微博
//
//  Created by Changqing Qu on 2017/2/9.
//  Copyright © 2017年 Changqing Qu. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)title:(NSString *)title
                  fontSize:(CGFloat)fontSize
                    target:(id)target
                    action:(SEL)action{
    
    UIButton * btn = [UIButton cz_textButton:title
                                    fontSize:fontSize
                                 normalColor:[UIColor darkGrayColor]
                            highlightedColor:[UIColor orangeColor]];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}

@end
