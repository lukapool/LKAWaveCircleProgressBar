//
//  TestAViewController.m
//  WaveAnimation
//
//  Created by Luka on 2018/5/12.
//  Copyright © 2018 Luka. All rights reserved.
//

#import "TestAViewController.h"
#import "LKAWaveCircleProgressBar.h"

@interface TestAViewController ()

@end

@implementation TestAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LKAWaveCircleProgressBar * wcView = [[LKAWaveCircleProgressBar alloc] initWithFrame:CGRectMake(62.5,125.5,248.5,248.5)];
    [wcView setProgress:0.8 animated:YES];
    wcView.progressAnimationDuration = 0.7;
    [self.view addSubview:wcView];
    [wcView startWaveRollingAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
