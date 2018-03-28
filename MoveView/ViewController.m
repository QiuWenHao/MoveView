//
//  ViewController.m
//  MoveView
//
//  Created by wenHao Qiu on 2017/7/25.
//  Copyright © 2017年 fahai. All rights reserved.
//

#import "ViewController.h"

#import "SlideGameView.h"

@interface ViewController ()<SlideGameDelegate,UIAlertViewDelegate> {
    
    UIButton *_startBtn;
    
    UIButton *_endBtn;
    
    UIButton *_pauseBtn;
    
    UIButton *_goOnBtn;
    
    UILabel  *_scoreLbl;
    
}

@property (nonatomic, strong) SlideGameView *animation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _animation = [[SlideGameView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];

    _animation.delegate = self;
    
    [self.view addSubview:_animation];
    
    [self createBtn];
    
    [self createScoreLabel];
    
    [UIView showAlertView:@"亲爱的小伙伴" andMessage:@"请选择游戏难度" withDelegate:self tag:100 cancelButtonTitle:@"简单" otherButtonTitles:@"困难", nil];
    
}

- (void)changeSpeed {
    
    _scoreLbl.text = [NSString stringWithFormat:@"%.1f",_animation.score];
    
    if ((_animation.score > 5 && _animation.score <= 5 + (CGFloat)1/60) ||(_animation.score > 10 && _animation.score <= 10 + (CGFloat)1/60)|| (_animation.score > 15 && _animation.score <= 15 + (CGFloat)1/60) || (_animation.score > 20 && _animation.score <= 20 + (CGFloat)1/60) || (_animation.score > 25 && _animation.score <= 25 + (CGFloat)1/60)) {
        
        _animation.speed += .2;

    }
}

- (void)gameIsOver {
    
    [self pause];
    
    NSString *score = [NSString stringWithFormat:@"你的得分是:%.0f",_animation.score];
    
    NSString *honor = nil;
    
    if (_animation.score >= 20) {
        
        honor = @"技术不错哦！";
        
    }
    
    if (_animation.score >= 40) {
        
        honor = @"666,高手啊！";
        
    }
    
    if (_animation.score >= 60) {
        
        honor = @"我操,牛逼啊！";
        
    }
    
    if (_animation.score >= 80) {
        
        honor = @"妈的,还有谁！";
        
    }
    
    [UIView showAlertView:@"游戏结束" andMessage:score withDelegate:self tag:101 cancelButtonTitle:@"更改难度" otherButtonTitles:@"重新开始",honor, nil];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 100) {
        
        if (buttonIndex == 0) {
            
            _animation.isHard = NO;
            
            _animation.speed = 1;
            
        }
        
        if (buttonIndex == 1) {
            
            _animation.isHard = YES;
            
            _animation.speed = 2;
            
        }
        
    }
    
    if (alertView.tag == 101) {
        
        if (buttonIndex == 0) {
        
            [self end];
            
            [UIView showAlertView:@"亲爱的小伙伴" andMessage:@"请选择游戏难度" withDelegate:self tag:100 cancelButtonTitle:@"简单" otherButtonTitles:@"困难", nil];
            
        }
        
        if (buttonIndex == 1) {
            
            [self end];
            
            if (_animation.isHard == YES) {
                
                _animation.speed = 2;
                
            }
            
            if (_animation.isHard == NO) {
                
                _animation.speed = 1;
                
            }
            
        }
        
        if (buttonIndex == 2) {
            
            [self end];
            
            if (_animation.isHard == YES) {
                
                _animation.speed = 2;
                
            }
            
            if (_animation.isHard == NO) {
                
                _animation.speed = 1;
                
            }
            
        }
        
    }
    
}

- (void)createBtn {
    
    _startBtn = [UIButton cz_textButton:@"开始游戏" fontSize:16 normalColor:[UIColor redColor] highlightedColor:[UIColor orangeColor]];
    
    [_startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    _startBtn.center = _animation.center;
    
    _startBtn.y = _animation.bottom + 20;
    
    _endBtn = [UIButton cz_textButton:@"重新开始" fontSize:16 normalColor:[UIColor redColor] highlightedColor:[UIColor orangeColor]];
    
    [_endBtn addTarget:self action:@selector(end) forControlEvents:UIControlEventTouchUpInside];
    
    _endBtn.center = _startBtn.center;
    
    _endBtn.hidden = YES;
    
    _pauseBtn = [UIButton cz_textButton:@"暂停" fontSize:16 normalColor:[UIColor redColor] highlightedColor:[UIColor orangeColor]];
    
    [_pauseBtn addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    
    _pauseBtn.center = _startBtn.center;
    
    _pauseBtn.centerY = _startBtn.centerY + 50;
    
    _pauseBtn.hidden = YES;
    
    _goOnBtn = [UIButton cz_textButton:@"继续" fontSize:16 normalColor:[UIColor redColor] highlightedColor:[UIColor orangeColor]];
    
    [_goOnBtn addTarget:self action:@selector(goOn) forControlEvents:UIControlEventTouchUpInside];
    
    _goOnBtn.center = _pauseBtn.center;

    _goOnBtn.hidden = YES;
    
    [self.view addSubview:_startBtn];
    
    [self.view addSubview:_endBtn];
    
    [self.view addSubview:_pauseBtn];
    
    [self.view addSubview:_goOnBtn];
    
}

- (void)createScoreLabel {
    
    _scoreLbl = [UILabel cz_labelWithText:[NSString stringWithFormat:@"%.1f",_animation.score] fontSize:100 color:[UIColor blackColor]];
    
    _scoreLbl.textAlignment = NSTextAlignmentCenter;
    
    _scoreLbl.width = self.view.width;
    
    _scoreLbl.backgroundColor = [UIColor cyanColor];
    
    _scoreLbl.height = _scoreLbl.width/2;
    
    _scoreLbl.center = _startBtn.center;
    
    _scoreLbl.bottom = self.view.bottom;
    
    [self.view addSubview:_scoreLbl];
    
}

- (void)start {
    
    [_animation startMove];
    
    _startBtn.hidden = YES;
    
    _pauseBtn.hidden = NO;
    
    _goOnBtn.hidden = YES;
    
    _endBtn.hidden = YES;
    
}

- (void)end {
    
    [_animation endBtnClick];
    
    _startBtn.hidden = NO;
    
    _pauseBtn.hidden = YES;
    
    _goOnBtn.hidden = YES;
    
    _endBtn.hidden = YES;
    
    _scoreLbl.text = @"0";
    
}

- (void)pause {
    
    [_animation pauseBtnClick];
    
    _startBtn.hidden = YES;
    
    _pauseBtn.hidden = YES;
    
    _goOnBtn.hidden = NO;
    
    _endBtn.hidden = NO;
    
}

- (void)goOn{
    
    [_animation goOnClick];
    
    _startBtn.hidden = YES;
    
    _pauseBtn.hidden = NO;
    
    _goOnBtn.hidden = YES;
    
    _endBtn.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
