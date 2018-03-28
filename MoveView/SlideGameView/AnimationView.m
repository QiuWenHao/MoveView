//
//  AnimationView.m
//  MoveView
//
//  Created by wenHao Qiu on 2017/7/26.
//  Copyright © 2017年 fahai. All rights reserved.
//

#import "AnimationView.h"

@implementation AnimationView

- (UIColor *)backColor {
    
    return _backColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _soundArr = [NSArray arrayWithObjects:@"1321",@"1322",@"1323",@"1324",@"1325",@"1326",@"1327",@"1328", nil];
        
        _scoreArr = [NSArray arrayWithObjects:@"10",@"20",@"30",@"10",@"40",@"30",@"10",@"20",@"10",@"20", nil];
        
        _isFlashing = NO;
        
        _hadPlus = NO;
        
        _lbl = [[UILabel alloc] initWithFrame:self.bounds];
        
        _lbl.backgroundColor = [UIColor clearColor];

        _lbl.textAlignment = NSTextAlignmentCenter;

        _lbl.hidden = YES;

        [self addSubview:_lbl];
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
