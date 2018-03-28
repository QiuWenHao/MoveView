//
//  SlideGameView.m
//  MoveView
//
//  Created by wenHao Qiu on 2017/7/25.
//  Copyright © 2017年 fahai. All rights reserved.
//

#import "SlideGameView.h"

#import "AnimationView.h"

#import <AudioToolbox/AudioToolbox.h>

#define topEdge    CGRectMake(0, 0, self.width, 0)          //上边界

#define bottomEdge CGRectMake(0, self.height, self.width, 0)//下边界

#define leftEdge   CGRectMake(0, 0, 0, self.height)         //左边界

#define rightEdge  CGRectMake(self.width, 0, 0, self.height)//右边界

@interface SlideGameView ()

@property (nonatomic, strong) AnimationView *animationView;

@property (nonatomic, strong) AnimationView *animationView1;

@property (nonatomic, strong) AnimationView *animationView2;

@property (nonatomic, strong) AnimationView *animationView3;

@property (nonatomic, assign) CGFloat score_up;

@property (nonatomic, strong) UIView *touchView;

@property (nonatomic, strong) CADisplayLink *timer;

@property (nonatomic, assign) BOOL isEnd;

@property (nonatomic, assign) CGFloat plusScore;

@property (nonatomic, assign) SystemSoundID soundId;

/**
 将要移动到的点
 */
@property (nonatomic, assign) CGPoint point;

@end

@implementation SlideGameView

- (AnimationView *)animationView {
    
    if (!_animationView) {
        
        _animationView = [[AnimationView alloc]initWithFrame:CGRectMake(20, 30, 60, 60)];
        
        _animationView.backgroundColor = [UIColor blueColor];
        
        _animationView.backColor = _animationView.backgroundColor;
    }
    
    return _animationView;
}

- (AnimationView *)animationView1 {
   
    if (!_animationView1) {
        
        _animationView1 = [[AnimationView alloc]initWithFrame:CGRectMake(260, 60, 55, 55)];
        
        _animationView1.backgroundColor = [UIColor yellowColor];
        
        _animationView1.backColor = _animationView1.backgroundColor;
    }
    
    return _animationView1;
}

- (AnimationView *)animationView2 {
    
    if (!_animationView2) {
        
        _animationView2 = [[AnimationView alloc]initWithFrame:CGRectMake(30, 170, 50, 50)];
        
        _animationView2.backgroundColor = [UIColor magentaColor];
        
        _animationView2.backColor = _animationView2.backgroundColor;
    }
    
    return _animationView2;
}

- (AnimationView *)animationView3 {
    
    if (!_animationView3) {
        
        _animationView3 = [[AnimationView alloc]initWithFrame:CGRectMake(280, 220, 45, 45)];
        
        _animationView3.backgroundColor = [UIColor redColor];
        
        _animationView3.backColor = _animationView3.backgroundColor;
    }
    
    return _animationView3;
}

- (CADisplayLink *)timer {
    
    if (_timer == nil) {
        
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(moveInView)];
        
        [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    return _timer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)createAnimationViewWithView:(AnimationView *)view andPoint:(CGPoint)point {
    
    if (!_speed) {
        
        _speed = 1;
    }
    
    view.initX = view.centerX - point.x;
    
    view.initY = view.centerY - point.y;
    
    view.Y_Bi_X = fabs(view.initY/view.initX);
    
    view.center_X = view.centerX;
    
    view.center_Y = view.centerY;
    
    [self addSubview:view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    //当前的point
    CGPoint currentP = [touch locationInView:self];
    
    //以前的point
    CGPoint preP = [touch previousLocationInView:self];
    
    //x轴偏移的量
    CGFloat offsetX = currentP.x - preP.x;
    
    //Y轴偏移的量
    CGFloat offsetY = currentP.y - preP.y;
    
    self.touchView.transform = CGAffineTransformTranslate(self.touchView.transform, offsetX, offsetY);
}

- (void)setupUI {
    
    _isEnd = YES;
    
    _score = 0;
    
    _score_up = (CGFloat)1/60;
    
    self.userInteractionEnabled = NO;
    
    self.backgroundColor = [UIColor greenColor];
    
    //[self randomPoint];
    
    _point = CGPointMake(150, 150);
    
    [self createAnimationViewWithView:self.animationView andPoint:_point];
    
    [self createAnimationViewWithView:self.animationView1 andPoint:_point];
    
    [self createAnimationViewWithView:self.animationView2 andPoint:_point];
    
    [self createAnimationViewWithView:self.animationView3 andPoint:_point];
    
    _touchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    _touchView.center = self.center;
    
    _touchView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_touchView];
}

//移动的滑块中心随机
- (void)randomPoint {
    
    _point = _animationView.center;
    
    int view_x = self.centerX - 10;
    
    int view_r = view_x + 20;
    
    int view_y = self.centerY - 10;
    
    int view_b = view_y + 20;
    
    //如果与其他view中心x或者y一样将重新随机（因为会出现一直左右或者上下移动）
    while ([self isEqualWithPoint:_point andAnotherPoint:_animationView.center] || [self isEqualWithPoint:_point andAnotherPoint:_animationView1.center] || [self isEqualWithPoint:_point andAnotherPoint:_animationView2.center] || [self isEqualWithPoint:_point andAnotherPoint:_animationView3.center]) {
        
        int x = arc4random()%(view_r - view_x + 1) + view_x;
        
        int y = arc4random()%(view_b - view_y + 1) + view_y;
        
        _point = CGPointMake(x, y);
        
        NSLog(@"===========%@",NSStringFromCGPoint(_point));
    }
}

- (BOOL)isEqualWithPoint:(CGPoint)point andAnotherPoint:(CGPoint)anotherPoint {
    
    return ((point.x == anotherPoint.x) || (point.y == anotherPoint.y));
}
#pragma mark - 开始游戏
- (void)startMove {
    
    self.userInteractionEnabled = YES;
    
    if (_timer == nil) {
        
        [self timer];
    }
}

#pragma mark - 结束游戏
- (void)endBtnClick {
    
    [_timer invalidate];
    
    _timer = nil;
    
    [_animationView removeFromSuperview];
    
    [_animationView1 removeFromSuperview];
    
    [_animationView2 removeFromSuperview];
    
    [_animationView3 removeFromSuperview];
    
    [_touchView removeFromSuperview];
    
    _touchView = nil;
    
    _animationView = nil;
    
    _animationView1 = nil;
    
    _animationView2 = nil;
    
    _animationView3 = nil;
    
    [self setupUI];
}

#pragma mark - 暂停游戏
- (void)pauseBtnClick {
    
    self.userInteractionEnabled = NO;
    
    if (_timer.paused == NO) {
        
        [_timer setPaused:YES];;
    }
}

#pragma mark - 继续
- (void)goOnClick{
    
    self.userInteractionEnabled = YES;
    
    if (_timer.paused == YES) {
        
        [_timer setPaused:NO];
    }
}

- (void)startPlayerWithAnimationView:(AnimationView *)view {
    
    if (_isEnd == YES) {
        
        _isEnd = NO;
        
        view.lbl.hidden = NO;
        
        view.isFlashing = YES;
        
        NSInteger i = arc4random() % view.scoreArr.count;
        
        __block int startTime = [view.scoreArr[i] intValue];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        
        dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),.1*NSEC_PER_SEC, 0); //每0.秒执行一次
        
        dispatch_source_set_event_handler(timer, ^{
         
            if (startTime) {
                
                NSString *timeStr = [NSString stringWithFormat:@"%.1f",startTime *1.0/10];
                
                _plusScore = [timeStr floatValue];
                
                NSLog(@"=============plusScore:%f",_plusScore);
                
                if(startTime%2 == 0){
                    
                    int R = (arc4random() % 255) ;
                    int G = (arc4random() % 255) ;
                    int B = (arc4random() % 255) ;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        view.lbl.text = timeStr;
                        
                        if (!view.hadPlus) {
                            
                            view.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
                        }
                        else {
                            
                            view.backgroundColor = view.backColor;
                        }
                    });
                }else{
                
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        view.lbl.text = timeStr;
                        
                        view.backgroundColor = view.backColor;
                    });
                }
            }
            else {
                
                dispatch_source_cancel(timer);
                
                _isEnd = YES;
                
                view.isFlashing = NO;
                
                view.hadPlus = NO;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    view.lbl.hidden = YES;
                
                    view.backgroundColor = view.backColor;
                });
            }
            
            startTime--;
        });
        
        dispatch_resume(timer);
        
        //***闪动时播放系统音乐***//
        //        view.lbl.hidden = NO;
        //
        //        NSURL *audioPath = nil;
        //NSURL *audioPath = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"bewithyou"ofType:@"wav"]];
        //NSURL *audioPath = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle]pathForResource:@"goalsound"ofType:@"wav"]];
        //定义SystemSoundID
        //        _soundId = [view.soundArr[(arc4random() % view.soundArr.count)] intValue];
        //C语言的方法调用
        //注册服务
        //        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)audioPath, &_soundId);
        //
        //        AudioServicesPlaySystemSoundWithCompletion(_soundId, ^{
        //
        //            _isEnd = YES;
        //
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //
        //                AudioServicesDisposeSystemSoundID(_soundId);
        //
        //                view.lbl.hidden = YES;
        //
        //                view.isFlashing = NO;
        //
        //                view.backgroundColor = view.backColor;
        //
        //                dispatch_source_cancel(timer);
        //            });
        //        });
    }
}

- (void)moveInView {
    
    _score += _score_up;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeSpeed)]) {
        
        [self.delegate changeSpeed];
    }
    
#pragma mark - 碰到view或者边缘结束游戏
    if ((CGRectIntersectsRect(_touchView.frame, self.animationView.frame) && !self.animationView.isFlashing) || (CGRectIntersectsRect(_touchView.frame, self.animationView1.frame) && !self.animationView1.isFlashing) || (CGRectIntersectsRect(_touchView.frame, self.animationView2.frame) && !self.animationView2.isFlashing) || (CGRectIntersectsRect(_touchView.frame, self.animationView3.frame) && !self.animationView3.isFlashing) || CGRectIntersectsRect(_touchView.frame, topEdge) || CGRectIntersectsRect(_touchView.frame, bottomEdge) || CGRectIntersectsRect(_touchView.frame, leftEdge) || CGRectIntersectsRect(_touchView.frame, rightEdge)) {
        
        AudioServicesDisposeSystemSoundID(_soundId);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(gameIsOver)]) {
            
            //NSLog(@"==%f",_score);
            [self.delegate gameIsOver];
        }
    }
    //碰到view如果此view在闪烁，得分加上将此view上的数字
    else if ((CGRectIntersectsRect(_touchView.frame, self.animationView.frame) && self.animationView.isFlashing && !self.animationView.hadPlus)) {
        
        self.animationView.hadPlus = YES;
        
        _score += _plusScore;
    }
    else if ((CGRectIntersectsRect(_touchView.frame, self.animationView1.frame) && self.animationView1.isFlashing && !self.animationView1.hadPlus)) {
        
        self.animationView1.hadPlus = YES;
        
        _score += _plusScore;
    }
    else if ((CGRectIntersectsRect(_touchView.frame, self.animationView2.frame) && self.animationView2.isFlashing && !self.animationView2.hadPlus)) {
        
        self.animationView2.hadPlus = YES;
        
        _score += _plusScore;
    }
    else if((CGRectIntersectsRect(_touchView.frame, self.animationView3.frame) && self.animationView3.isFlashing && !self.animationView3.hadPlus)){
        
        self.animationView3.hadPlus = YES;
        
        _score += _plusScore;
    }
    
    if (self.isHard) {
        
        [self toDealWithView_To_View_MoveWithAnimationView:_animationView andOtherAnimationView:_animationView1];
        
        [self toDealWithView_To_View_MoveWithAnimationView:_animationView andOtherAnimationView:_animationView2];
        
        [self toDealWithView_To_View_MoveWithAnimationView:_animationView andOtherAnimationView:_animationView3];
        
        [self toDealWithView_To_View_MoveWithAnimationView:_animationView1 andOtherAnimationView:_animationView2];
        
        [self toDealWithView_To_View_MoveWithAnimationView:_animationView1 andOtherAnimationView:_animationView3];
        
        [self toDealWithView_To_View_MoveWithAnimationView:_animationView2 andOtherAnimationView:_animationView3];
    }

    [self toDealWithView_To_EdgeMoveWithAnimationView:_animationView];
    
    [self toDealWithView_To_EdgeMoveWithAnimationView:_animationView1];
    
    [self toDealWithView_To_EdgeMoveWithAnimationView:_animationView2];
    
    [self toDealWithView_To_EdgeMoveWithAnimationView:_animationView3];
}

#pragma -mark ----------view与view之间的碰撞---------------
- (void)toDealWithView_To_View_MoveWithAnimationView:(AnimationView *)animationView andOtherAnimationView:(AnimationView *)otherAnimationView {
    
    if ([self leftEdgeIsMeetWithAnimationView:animationView withView:otherAnimationView]) {
        
        animationView.initX = -animationView.initX;
        
        if (otherAnimationView.initX < 0) {
            
            otherAnimationView.initX = -otherAnimationView.initX;
        }
    }
    
    if ([self rightEdgeIsMeetWithAnimationView:animationView withView:otherAnimationView]) {
        
        animationView.initX = -animationView.initX;
        
        if (otherAnimationView.initX > 0) {
            
            otherAnimationView.initX = -otherAnimationView.initX;
        }
    }
    
    if ([self topEdgeIsMeetWithAnimationView:animationView withView:otherAnimationView]) {
        
        animationView.initY = -animationView.initY;
        
        if (otherAnimationView.initY < 0) {
            
            otherAnimationView.initY = -otherAnimationView.initY;
        }
    }
    
    if ([self bottomEdgeIsMeetWithAnimationView:animationView withView:otherAnimationView]) {
        
        animationView.initY = -animationView.initY;
        
        if (otherAnimationView.initY > 0) {
            
            otherAnimationView.initY = -otherAnimationView.initY;
        }
    }
}

#pragma -mark --------oneView左侧与otherView是否有重合----------
- (BOOL)leftEdgeIsMeetWithAnimationView:(AnimationView *)oneView withView:(AnimationView *)otherView {
    
    return CGRectIntersectsRect(CGRectMake(oneView.x, oneView.y, 0, oneView.height), otherView.frame);
}

#pragma -mark --------oneView右侧与otherView是否有重合----------
- (BOOL)rightEdgeIsMeetWithAnimationView:(AnimationView *)oneView withView:(AnimationView *)otherView {
    
    return CGRectIntersectsRect(CGRectMake(oneView.right, oneView.y, 0, oneView.height), otherView.frame);
}

#pragma -mark --------oneView顶部与otherView是否有重合----------
- (BOOL)topEdgeIsMeetWithAnimationView:(AnimationView *)oneView withView:(AnimationView *)otherView {
    
    return CGRectIntersectsRect(CGRectMake(oneView.x, oneView.y, oneView.width, 0), otherView.frame);
}

#pragma -mark --------oneView底部otherView是否有重合----------
- (BOOL)bottomEdgeIsMeetWithAnimationView:(AnimationView *)oneView withView:(AnimationView *)otherView {
    
    return CGRectIntersectsRect(CGRectMake(oneView.x, oneView.bottom, oneView.width, 0), otherView.frame);
}

#pragma -mark ----------view与边界的碰撞---------------
- (void)toDealWithView_To_EdgeMoveWithAnimationView:(AnimationView *)animationView {
    
    if (animationView.right >= rightEdge.origin.x || animationView.x <= leftEdge.origin.x) {
        
        [self startPlayerWithAnimationView:animationView];
        
        animationView.initX = -animationView.initX;
    }
    
    if (animationView.bottom >= bottomEdge.origin.y || animationView.y <= topEdge.origin.y) {
        
        [self startPlayerWithAnimationView:animationView];
        
        animationView.initY = -animationView.initY;
    }
    
    [self moveWithAnimationView:animationView];
}

- (void)moveWithAnimationView:(AnimationView *)view {
    
    if (view.initX < 0 && view.initY < 0) {
        
        view.center_X += _speed;
        
        view.center_Y += _speed * view.Y_Bi_X;
    }
    
    if (view.initX < 0 && view.initY > 0) {
        
        view.center_X += _speed;
        
        view.center_Y -= _speed * view.Y_Bi_X;
    }
    
    if (view.initX > 0 && view.initY > 0) {
        
        view.center_X -= _speed;
        
        view.center_Y -= _speed * view.Y_Bi_X;
    }
    
    if (view.initX > 0 && view.initY < 0) {
        
        view.center_X -= _speed;
        
        view.center_Y += _speed * view.Y_Bi_X;
    }
    
    view.center = CGPointMake(view.center_X, view.center_Y);
}

@end
