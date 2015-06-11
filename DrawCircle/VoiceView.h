//
//  VoiceView.h
//  DrawCircle
//
//  Created by foreveross－bj on 15/6/8.
//  Copyright (c) 2015年 foreveross－bj. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTimeInterval 0.5
#define kCount 4
#define kWidth 6

typedef NS_ENUM(NSInteger, VoiceAnimationStatus) {
    VoiceAnimationStartStatus = 1 << 0,
    VoiceAnimationAnimatingStatus = 1 << 1,
    VoiceAnimationStopStatus =  1 << 2,
};

@interface VoiceBaseView : UIView

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, assign) VoiceAnimationStatus status;

/**
 * 开始动画
 * @param beginRange
 */
- (void)startAnimationWithBeginRange:(CGFloat)beginRange;

/**
 * 停止动画
 */
- (void)stopAnimation;
@end


@interface VoiceView : UIView

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, readonly) VoiceAnimationStatus status;

/**
 * 开始动画
 */
- (void)startAnimation;

/**
 * 停止动画
 */
- (void)stopAnimation;

@end
