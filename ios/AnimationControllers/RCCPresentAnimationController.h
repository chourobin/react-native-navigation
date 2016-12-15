//
//  RCCPresentAnimationController.h
//  ReactNativeNavigation
//
//  Created by Robin Chou on 12/14/16.
//  Copyright © 2016 artal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCCPresentAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) BOOL animateFade; // default is YES

@property (assign, nonatomic) BOOL animateScale; // default is NO

@end

NS_ASSUME_NONNULL_END
