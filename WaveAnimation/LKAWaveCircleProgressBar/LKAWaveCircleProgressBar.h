//
//  LKAWaveCircleProgressBar.h
//  WaveAnimation
//
//  Created by Luka on 2017/8/23.
//  Copyright © 2017年 Luka. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Completion)(void);

@interface LKAWaveCircleProgressBar : UIView

@property (nonatomic, assign) NSTimeInterval waveRollingDuration;
@property (nonatomic, assign) NSTimeInterval progressAnimationDuration;
@property (nonatomic, assign) CGFloat progress;
@property(nonatomic, strong) UIColor *progressTintColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, copy) Completion completion;

- (void)setProgress:(float)progress animated:(BOOL)animated;
- (void)stopWaveRollingAnimation;
- (void)startWaveRollingAnimation;

@end
