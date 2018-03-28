//
//  SlideGameView.h
//  MoveView
//
//  Created by wenHao Qiu on 2017/7/25.
//  Copyright © 2017年 fahai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideGameDelegate <NSObject>

- (void)gameIsOver;

@optional

- (void)changeSpeed;

@end

@interface SlideGameView : UIView

/**
 X轴方向移动速度
 */
@property (nonatomic, assign) CGFloat speed;

@property (nonatomic, weak) id <SlideGameDelegate> delegate;

/**
 得分
 */
@property (nonatomic, assign) CGFloat score;

/**
 是否困难 默认是NO
 */
@property (nonatomic, assign) BOOL isHard;

-(void)startMove;

-(void)endBtnClick;

- (void)pauseBtnClick;

- (void)goOnClick;

@end
