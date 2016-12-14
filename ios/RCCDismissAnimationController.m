//
//  RCCDismissAnimationController.m
//  ReactNativeNavigation
//
//  Created by Robin Chou on 12/14/16.
//  Copyright © 2016 artal. All rights reserved.
//

#import "RCCDismissAnimationController.h"

@implementation RCCDismissAnimationController

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _animateFade = YES;
    _animateScale = NO;
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    CGRect fullScreen = containerView.bounds;
    CGRect offscreenBottom = CGRectOffset(fullScreen, 0, CGRectGetHeight(containerView.bounds));
    
    UIView *toSnapshotContainer = [[UIView alloc] initWithFrame:fullScreen];
    toSnapshotContainer.backgroundColor = [UIColor blackColor];
    
    UIView *toSnapshot = [toVC.view snapshotViewAfterScreenUpdates:YES];
    toSnapshot.frame = toSnapshotContainer.bounds;
    [toSnapshotContainer addSubview:toSnapshot];
    
    CGAffineTransform scaleDown = CGAffineTransformMakeScale(0.9, 0.9);
    scaleDown = CGAffineTransformTranslate(scaleDown, 0, 5);
    toSnapshot.transform = self.animateScale ? scaleDown : CGAffineTransformIdentity;
    toSnapshot.alpha = self.animateFade ? 0.6 : 1.0;
    
    UIView *fromSnapshot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    fromSnapshot.frame = fullScreen;
    
    [containerView addSubview:toSnapshotContainer];
    [containerView addSubview:fromSnapshot];
    fromVC.view.hidden = YES;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toSnapshot.alpha = 1;
        toSnapshot.transform = CGAffineTransformIdentity;
        fromSnapshot.frame = offscreenBottom;
    } completion:^(BOOL finished) {
        fromVC.view.hidden = NO;
        [toSnapshotContainer removeFromSuperview];
        [fromSnapshot removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
