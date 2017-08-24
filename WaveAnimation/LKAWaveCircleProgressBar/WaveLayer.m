//
//  WaveLayer.m
//  WaveAnimation
//
//  Created by Luka on 2017/8/23.
//  Copyright © 2017年 Luka. All rights reserved.
//

#import "WaveLayer.h"


@interface WaveLayer ()
@end

@implementation WaveLayer
    // 可以进行 Core Animation 的属性需要 dynamic，UIKit 自动生成 access method
@dynamic U;
@dynamic C;

    // 用来生成 presentation layer
- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        if ([layer isKindOfClass:[WaveLayer class]]) {
            WaveLayer *waveLayer = (WaveLayer *)layer;
            self.A = waveLayer.A;
            self.W = waveLayer.W;
            self.C = waveLayer.C;
            self.U = waveLayer.U;
            self.offsetU = waveLayer.offsetU;
            self.color = waveLayer.color;
        }
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentsScale = [UIScreen mainScreen].scale;
        _A = 1.0;
        _W = 2 * M_PI / 320 * 0.8;
        self.C = 0;
        self.U = 0;
        _offsetU = 0;
        _color = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}
    // 定义哪个属性为可动画
+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"U"] || [key isEqualToString:@"C"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

    // 绘图
- (void)drawInContext:(CGContextRef)ctx {
    CGMutablePathRef clipPath = CGPathCreateMutable();
    CGPathAddEllipseInRect(clipPath, NULL, self.bounds);
    CGContextAddPath(ctx, clipPath);
    CGContextClip(ctx);
    CGPathRelease(clipPath);
    
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);

    CGMutablePathRef sinPath = CGPathCreateMutable();
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    CGFloat offsetY = (1 - self.C) * height;
    CGPathMoveToPoint(sinPath, NULL, 0.0f, height);
    CGPathAddLineToPoint(sinPath, NULL, 0.0f, offsetY);
    

    for (int x = 0; x <= width; x++) {
        CGFloat y = _A * sinf( _W * x + self.U + _offsetU) + offsetY;
        CGPathAddLineToPoint(sinPath, NULL, x, y);
    }
    
    CGPathAddLineToPoint(sinPath, NULL, width, height);
    CGPathCloseSubpath(sinPath);
    CGContextBeginPath(ctx);
    CGContextAddPath(ctx, sinPath);
    CGContextFillPath(ctx);
    
    CGPathRelease(sinPath);
}

@end
