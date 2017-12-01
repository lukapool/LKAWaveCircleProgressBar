![License MIT](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square) 
![CocoaPods](https://img.shields.io/badge/Pod-v0.0.1-blue.svg?style=flat-square)
![Language](https://img.shields.io/badge/Language-Objective--C-lightgrey.svg?style=flat-square)
![Platform](https://img.shields.io/badge/Platform-iOS-yellow.svg?style=flat-square)

#### `LKAWaveCircleProgressBar` is a circular progress indicator with wave rolling animation, you can customize the `border color`, `border line width`, wave `color`, wave rolling `animation duration`, progress change `animation duration`.

## Screenshots
|Set the progress|Set the progress with animation|Set wave rolling animation’s duration|
|:---:|:---:|:---:|
|![image](SetProgress.gif)|![image](SetProgressAnimation.gif)|![image](WaveAnimDuration.gif)|
|Set other Properties|
|![image](OtherProperties.gif)|
## Installation
#### CocoaPods
1、Add the following line to your Podfile：
```
pod 'LKAWaveCircleProgressBar'
```
2、Then, run the following command:
```
pod install
```
3、In the source files where you need to use the library, import the header file:
```
#import "LKAWaveCircleProgressBar.h"
```
#### Manual install
1、Download the least source files:

2、Drag `WaveAnimation/LKAWaveCircleProgressBar` folder to Xcode project.Make sure to select `Copy items if needed`.

3、In the source files where you need to use the library, import the header file:
```
#import <LKAWaveCircleProgressBar.h>
```
## How To Use
#### Initialization，you can use Autolayout to set the frame. ⚠️`MAKE SURE THE VIEW IS SQUARE`
```
LKAWaveCircleProgressBar *wcView = [[LKAWaveCircleProgressBar alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
```
#### Set indicator's progress, the current progress is represented by a floating-point value between 0.0 and 1.0.
```
// Set the progress without animation
self.wcView.progress = value;
// or
[self.wcView setProgress:value];
// or
[self.wcView setProgress:value animated:NO];

// Set the progress with animation
[self.wcView setProgress:value animated:YES];
```
#### Appearance，Please see the file [WaveAnimation/TestViewContorller.m](WaveAnimation/TestViewContorller.m) and check out the sample app for more details.
```
// Wave Rolling Animation Duration，default：1s
@property (nonatomic, assign) NSTimeInterval waveRollingDuration;
// Progress Change Animation Duration，default：1s
@property (nonatomic, assign) NSTimeInterval progressAnimationDuration;
// Wave Color，default：[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5]
@property(nonatomic, strong) UIColor *progressTintColor;
// Indicator Border Color，default：[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.9]
@property (nonatomic, strong) UIColor *borderColor;
// Indicator Border Line Width，default：2.0
@property (nonatomic, assign) CGFloat borderWidth;
// Progress Change Animation Comletion Block，default is nil，block executes in main thread.
@property (nonatomic, copy) Completion completion;
// Stop Wave Rolling Animation
- (void)stopWaveRollingAnimation;
// Start Wave Rolling Animation
- (void)startWaveRollingAnimation;
```

## License
LKAWaveCircleProgressBar is released under the [MIT license](LICENSE). See LICENSE for details.
