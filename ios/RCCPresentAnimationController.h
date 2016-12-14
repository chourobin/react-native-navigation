//
//  RCCPresentAnimationController.h
//  ReactNativeNavigation
//
//  Created by Robin Chou on 12/14/16.
//  Copyright © 2016 artal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCCPresentAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) BOOL animateFade; // default is YES

@property (assign, nonatomic) BOOL animateScale; // default is NO

@end
