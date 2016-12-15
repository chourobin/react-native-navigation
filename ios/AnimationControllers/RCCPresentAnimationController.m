//
//  RCCPresentAnimationController.m
//  ReactNativeNavigation
//
//  Created by Robin Chou on 12/14/16.
//  Copyright © 2016 artal. All rights reserved.
//

#import "RCCPresentAnimationController.h"

@implementation RCCPresentAnimationController

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
    
    CGRect offscreenBottom = CGRectOffset(containerView.bounds, 0, CGRectGetHeight(containerView.bounds));
    CGRect fullScreen = [transitionContext finalFrameForViewController:toVC];
    
    UIView *fromSnapshotContainer = [[UIView alloc] initWithFrame:fullScreen];
    fromSnapshotContainer.backgroundColor = [UIColor blackColor];
    UIView *fromSnapshot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    fromSnapshot.frame = fromSnapshotContainer.bounds;
    [fromSnapshotContainer addSubview:fromSnapshot];
    
    CGAffineTransform scaleDown = CGAffineTransformMakeScale(0.9, 0.9);
    scaleDown = CGAffineTransformTranslate(scaleDown, 0, 5);
    
    UIView *toSnapshot = [toVC.view snapshotViewAfterScreenUpdates:YES];
    toSnapshot.frame = offscreenBottom;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromSnapshotContainer];
    [containerView addSubview:toSnapshot];
    toVC.view.hidden = YES;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        fromSnapshot.alpha = [self animateFade] ? 0.6 : 1.0;
        fromSnapshot.transform = [self animateScale] ? scaleDown : CGAffineTransformIdentity;
        toSnapshot.frame = fullScreen;
    } completion:^(BOOL finished) {
        toVC.view.hidden = NO;
        [toSnapshot removeFromSuperview];
        [fromSnapshotContainer removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
