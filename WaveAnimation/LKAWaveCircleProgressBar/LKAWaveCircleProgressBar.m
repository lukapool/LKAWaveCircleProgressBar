//
//  LKAWaveCircleProgressBar.m
//  WaveAnimation
//
//  Created by Luka on 2017/8/23.
//  Copyright © 2017年 Luka. All rights reserved.
//
#import "LKAWaveCircleProgressBar.h"
#import "WaveLayer.h"

@interface LKAWaveCircleProgressBar () <CAAnimationDelegate>

@property (nonatomic, strong)  NSMutableArray *waves;
@property (nonatomic, strong) CALayer *containerLayer;
@property (nonatomic, assign) BOOL isStop;
@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation LKAWaveCircleProgressBar

#pragma mark - custom view initialization
- (void)initialization {
    _waveRollingDuration = 1.0;
    _progressAnimationDuration = 1.0;
    _progress = 0.5;
    _progressTintColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
    _borderColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.9];
    _borderWidth = 2.0;
    _isStop = YES;
    _isAnimating = NO;
    
    for (NSUInteger i = 0; i < 2; i++) {
        WaveLayer *waveLayer = [WaveLayer layer];
        waveLayer.color = _progressTintColor;
        waveLayer.C = _progress;
        waveLayer.offsetU = i * M_PI * 0.8;
        [self.containerLayer addSublayer:waveLayer];
        [self.waves addObject:waveLayer];
    }
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(startWaveRollingAnimation) name:UIApplicationDidBecomeActiveNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(stopWaveRollingAnimation) name:UIApplicationWillResignActiveNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

#pragma mark - lazy loading property
- (CALayer *)containerLayer {
    if (!_containerLayer) {
        _containerLayer = [CALayer layer];
        _containerLayer.contentsScale = [UIScreen mainScreen].scale;
        _containerLayer.masksToBounds = YES;
        _containerLayer.borderColor = self.borderColor.CGColor;
        _containerLayer.borderWidth = self.borderWidth;
        [self.layer addSublayer:self.containerLayer];
    }
    return _containerLayer;
}

- (NSMutableArray *)waves {
    if (!_waves) {
        _waves = [NSMutableArray arrayWithCapacity:2];
    }
    return _waves;
}

#pragma mark - api property
    // progress
- (void)setProgress:(CGFloat)progress {
    [self updateProgress:progress animated:NO];
}

- (void)updateProgress:(float)progress animated:(BOOL)animated {
    CGFloat lastProgress = self.progress;
    _progress = MIN(1, MAX(0, progress));
    for (int i = 0; i < self.waves.count; i++) {
        WaveLayer *waveLayer = self.waves[i];
        waveLayer.C = self.progress;
    }
    if (animated) {
        [self addProgressAnimationFromValue: lastProgress to: self.progress];
    }
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
    [self updateProgress:progress animated:animated];
}

- (void)addProgressAnimationFromValue: (NSTimeInterval)fromValue to: (NSTimeInterval)toValue {
    CABasicAnimation *progressAnimation = [CABasicAnimation animationWithKeyPath:@"C"];
    progressAnimation.fromValue = @(fromValue);
    progressAnimation.toValue = @(toValue);
    progressAnimation.duration = self.progressAnimationDuration;
    progressAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [progressAnimation setValue:@"ProgressAnimation" forKey:@"Name"];
    for (int i = 0; i < self.waves.count; i++) {
        if (i == 0) {
            progressAnimation.delegate = self;
        } else {
            progressAnimation.delegate = nil;
        }
        WaveLayer *layer = self.waves[i];
        [layer addAnimation:progressAnimation forKey:@"ProgressAnimation"];
    }
}

    // progress tint color
- (void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressTintColor = progressTintColor;
    for (WaveLayer *layer in self.waves) {
        layer.color = progressTintColor;
    }
}

    // border Color
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.containerLayer.borderColor = borderColor.CGColor;
}

    // border Width
- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.containerLayer.borderWidth = borderWidth;
//    [self layoutIfNeeded];
    [self setNeedsLayout];
}
    // wave Rolling Duration
- (void)setWaveRollingDuration:(NSTimeInterval)waveRollingDuration {
    _waveRollingDuration = waveRollingDuration;
    if (!self.isStop)
        [self startWaveRollingAnimation];
}

#pragma mark - prepare to layout
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.bounds);
    NSAssert(width == CGRectGetHeight(self.bounds), @"LKAWaveCircleProgressBar MUST BE SQUARE!");
    self.containerLayer.frame = self.bounds;
    self.containerLayer.cornerRadius = width / 2.0 + 0.5;

    CGRect waveFrame = CGRectInset(self.bounds, self.borderWidth, self.borderWidth);
    
    
    for (int i = 0; i < self.waves.count; i++) {
        WaveLayer *waveLayer = self.waves[i];
        waveLayer.frame = waveFrame;
        waveLayer.A = waveFrame.size.width * ( -0.05 - 0.03 * i);
        waveLayer.W = 2 * M_PI / waveFrame.size.width * 0.8;
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (!self.isStop)
        [self startWaveRollingAnimation];
}

- (void)addWaveRollingAnimation {
    CABasicAnimation *waveRollingAnim = [CABasicAnimation animationWithKeyPath:@"U"];
    waveRollingAnim.fromValue = @0;
    waveRollingAnim.toValue = @(M_PI * 2);
    waveRollingAnim.repeatCount = HUGE_VALF;
    waveRollingAnim.removedOnCompletion = NO;
    waveRollingAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    for (int i = 0; i < self.waves.count; i++) {
        waveRollingAnim.duration = self.waveRollingDuration + (i * 0.3);
        [self.waves[i] addAnimation:waveRollingAnim forKey:@"WaveRollingAnimation"];
    }
}

- (void)stopWaveRollingAnimation {
    self.isStop = YES;
    if (self.isAnimating) {
        self.isAnimating = NO;
        [self removeWaveRollingAnimation];
    }
}

- (void)startWaveRollingAnimation {
    self.isStop = NO;
    if (!self.isAnimating) {
        self.isAnimating = YES;
        [self addWaveRollingAnimation];
    }
}

- (void)removeWaveRollingAnimation {
    for (WaveLayer *layer in self.waves) {
        [layer removeAnimationForKey:@"WaveRollingAnimation"];
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *name = [anim valueForKey:@"Name"];
    if ([name isEqualToString:@"ProgressAnimation"]) {
        if (self.completion) {
                self.completion();
        }
    }
}

@end
