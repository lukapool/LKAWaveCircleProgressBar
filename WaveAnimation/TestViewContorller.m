//
//  TestViewContorller.m
//  WaveAnimation
//
//  Created by Luka on 2017/8/23.
//  Copyright © 2017年 Luka. All rights reserved.
//

#import "TestViewContorller.h"
#import "LKAWaveCircleProgressBar.h"

@interface TestViewContorller ()
@property (weak, nonatomic) IBOutlet LKAWaveCircleProgressBar *wcView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *timeSegment;
@property (weak, nonatomic) IBOutlet UISlider *progressView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *waveAnimationDurationSegment;

@end

@implementation TestViewContorller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.wcView.progressAnimationDuration = 0.7;
    
    self.waveAnimationDurationSegment.selectedSegmentIndex = 1;
    self.timeSegment.selectedSegmentIndex = 2;
    
    self.wcView.completion = ^{
        self.progressView.value = self.wcView.progress;
    };
    
    [self.wcView startWaveRollingAnimation];
}

- (IBAction)waveAnimDuration:(UISegmentedControl *)sender {
    self.wcView.waveRollingDuration = 0.5 * (sender.selectedSegmentIndex + 1);
}

- (IBAction)progressValueChanged:(UISlider *)sender {
    [self.wcView setProgress:sender.value];
}

- (IBAction)timeSegmentChanged:(UISegmentedControl *)sender {
//    NSLog(@"%ld", (long)sender.selectedSegmentIndex);
    [self.wcView setProgress:0.25 * sender.selectedSegmentIndex animated:YES];
}

- (IBAction)changeTinColor:(UIButton *)sender {
    self.wcView.progressTintColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:0.7];
//      [self.wcView stopWaveRollingAnimation];
}

- (IBAction)changeBorderColor:(UIButton *)sender {
    self.wcView.borderColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:0.7];
//      [self.wcView startWaveRollingAnimation];
}

- (IBAction)changeBorderWidth:(UIButton *)sender {
    self.wcView.borderWidth = arc4random() % 5;
}



@end
