//
//  AnimationView.h
//  MoveView
//
//  Created by wenHao Qiu on 2017/7/26.
//  Copyright © 2017年 fahai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationView : UIView

/**
 移动view与点的X值之差
 */
@property (nonatomic, assign) CGFloat initX;

/**
 移动view与点的Y值之差
 */
@property (nonatomic, assign) CGFloat initY;

/**
 Y轴方向与X方向的的速比
 */
@property (nonatomic, assign) CGFloat Y_Bi_X;

/**
 移动view中心的X值
 */
@property (nonatomic, assign) CGFloat center_X;

/**
 移动view中心的Y值
 */
@property (nonatomic, assign) CGFloat center_Y;

/**
 可触碰view上的字体
 */
@property (nonatomic, strong) UILabel *lbl;

/**
 view背景颜色
 */
@property (nonatomic, strong) UIColor *backColor;

/**
 声音数组
 */
@property (nonatomic, strong) NSArray *soundArr;

/**
 随机分数数组
 */
@property (nonatomic, strong) NSArray *scoreArr;

/**
 正在闪烁
 */
@property (nonatomic, assign) BOOL isFlashing;

/**
 已经加过分数
 */
@property (nonatomic, assign) BOOL hadPlus;

@end
