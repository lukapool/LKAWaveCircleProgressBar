//
//  ViewController.m
//  WaveAnimation
//
//  Created by Luka on 2017/8/23.
//  Copyright © 2017年 Luka. All rights reserved.
//

#import "ViewController.h"
#import "WaveLayer.h"

@interface ViewController ()
@property (nonatomic, strong)  WaveLayer *sinWavelayer;
@property (nonatomic, strong)  WaveLayer *cosWavelayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    WaveLayer *sinLayer = [WaveLayer layer];
    sinLayer.W = 2 * M_PI / 320 * 0.5;
    sinLayer.A = -25;
    sinLayer.C = 0.5;
    sinLayer.color = [UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.4];
    [self.view.layer addSublayer:sinLayer];
    self.sinWavelayer = sinLayer;
    
    WaveLayer *cosLayer = [WaveLayer layer];
    cosLayer.offsetU = M_PI_2 * 0.9;
    cosLayer.W = 2 * M_PI / 320 * 0.6;
    cosLayer.A = -25;
    cosLayer.C = 0.5;
    [self.view.layer addSublayer:cosLayer];
    self.cosWavelayer = cosLayer;
    
    
    UIBezierPath *mask = [UIBezierPath bezierPathWithOvalInRect:self.view.bounds];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = mask.CGPath;
//    self.view.layer.mask = maskLayer;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.sinWavelayer.frame = self.view.bounds;
    self.cosWavelayer.frame = self.view.bounds;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CABasicAnimation *waveAnimation = [CABasicAnimation animationWithKeyPath:@"U"];
    waveAnimation.fromValue = @0;
    waveAnimation.toValue = @(M_PI * 2);
    waveAnimation.duration = 1;
    waveAnimation.repeatCount = HUGE_VALF;
    [self.sinWavelayer addAnimation:waveAnimation forKey:nil];
    waveAnimation.duration = 2;
    [self.cosWavelayer addAnimation:waveAnimation forKey:nil];
    
    CABasicAnimation *percentAnimation = [CABasicAnimation animationWithKeyPath:@"C"];
    percentAnimation.fromValue = @0;
    percentAnimation.toValue = @0.5;
    percentAnimation.duration = 10;
    percentAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.sinWavelayer addAnimation:percentAnimation forKey:nil];
    [self.cosWavelayer addAnimation:percentAnimation forKey:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
