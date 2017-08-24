//
//  WaveLayer.h
//  WaveAnimation
//
//  Created by Luka on 2017/8/23.
//  Copyright © 2017年 Luka. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface WaveLayer : CALayer
@property (nonatomic, assign) CGFloat U;
@property (nonatomic, assign) CGFloat C;


@property (nonatomic, assign) CGFloat A;
@property (nonatomic, assign) CGFloat W;
@property (nonatomic, assign) CGFloat offsetU;
@property (nonatomic, strong) UIColor *color;

@end
