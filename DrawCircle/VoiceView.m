//
//  VoiceView.m
//  DrawCircle
//
//  Created by foreveross－bj on 15/6/8.
//  Copyright (c) 2015年 foreveross－bj. All rights reserved.
//

#import "VoiceView.h"

@interface VoiceBaseView ()

@property (nonatomic, assign) CGFloat beginRange;
@property (nonatomic, assign) CGFloat range;
@property (nonatomic, assign) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;

@end
@implementation VoiceBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.range = 0;
        self.count = 0;
        self.beginRange = 0;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        _status = VoiceAnimationStopStatus;
    }
    return self;
}
/**
 * 开始动画
 * @param beginRange
 */
- (void)startAnimationWithBeginRange:(CGFloat)beginRange{
    _status = VoiceAnimationStartStatus;
    self.range = beginRange;
    self.beginRange = beginRange;
    _count = 1;
    if (_timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval / 3 target:self selector:@selector(reDraw) userInfo:nil repeats:YES];
    }
    _timer.fireDate = [NSDate distantPast];
}

/**
 * 停止动画
 */
- (void)stopAnimation{
    _status = VoiceAnimationStopStatus;
    _count = 0;
    _range = 0;
    [self setNeedsDisplay];
    _timer.fireDate = [NSDate distantFuture];
}

- (void)reDraw{
    if (_count <= kCount * 3 * 2) {
        _status = VoiceAnimationAnimatingStatus;
        _range += 2;
        if (_count % (kCount * 3) == 1) {
            _range = _beginRange;
        }
        [self setNeedsDisplay];
    }else{
        [self stopAnimation];
    }
    
    
}

- (void)drawRect:(CGRect)rect{
    if (self.range > 0) {
        CGFloat alpha = ((kCount * 3) - (_count - 1) % (kCount * 3)) / (float)(kCount * 3);
        [[_color colorWithAlphaComponent:alpha] set];
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        bezierPath.lineCapStyle = kCGLineCapRound;
        bezierPath.lineWidth = 0.5;
        
        [bezierPath addArcWithCenter:self.center radius:_range / 2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        [bezierPath stroke];
        _count ++;
    }else{
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        
        bezierPath.lineJoinStyle = kCGLineJoinRound;
        bezierPath.lineCapStyle = kCGLineCapRound;
        bezierPath.lineWidth = 0.5;
        
        [bezierPath addArcWithCenter:self.center radius:_range / 2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        [bezierPath stroke];
    }
}


@end



@interface VoiceView ()

@property (nonatomic, strong) NSMutableArray *voiceBaseViews;

@end
@implementation VoiceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.voiceBaseViews = [[NSMutableArray alloc] init];
        for (int i = 0; i < kCount; i++) {
            VoiceBaseView *voiceBaseView = [[VoiceBaseView alloc] initWithFrame:self.bounds];
            voiceBaseView.color = [UIColor redColor];
            [self addSubview:voiceBaseView];
            [_voiceBaseViews addObject:voiceBaseView];
        }
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        
    }
    return self;
}

- (void)startAnimation{
    if (self.status != VoiceAnimationStopStatus) {
        [self stopAnimation];
    }
    for (int i = 0; i < kCount; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kTimeInterval * i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_voiceBaseViews[i] startAnimationWithBeginRange:self.frame.size.width - kWidth * (kCount - 1) - 4];
        });
    }
}


- (void)stopAnimation{
    [_voiceBaseViews makeObjectsPerformSelector:@selector(stopAnimation)];
}

- (void)setColor:(UIColor *)color{
    _color = color;
    for (int i = 0; i < kCount; i++) {
        [_voiceBaseViews[i] setColor:color];
    }
}

- (VoiceAnimationStatus)status{
    NSInteger currentStatus = [_voiceBaseViews[0] status];
    for (int i = 1; i < kCount; i++) {
        currentStatus |= [_voiceBaseViews[i] status];
    }
    if (currentStatus != 1 && currentStatus != 4 ) {
        return VoiceAnimationAnimatingStatus;
    }else if(currentStatus == 1){
        return VoiceAnimationStartStatus;
    }else{
        return VoiceAnimationStopStatus;
    }
}
@end
