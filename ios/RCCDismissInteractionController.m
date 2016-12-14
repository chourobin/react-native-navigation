//
//  RCCDismissInteractionController.m
//  ReactNativeNavigation
//
//  Created by Robin Chou on 12/14/16.
//  Copyright © 2016 artal. All rights reserved.
//

#import "RCCDismissInteractionController.h"

@interface RCCDismissInteractionController () <UIGestureRecognizerDelegate>

@property (assign, nonatomic) BOOL shouldCompleteTransition;

@property (weak, nonatomic) UIViewController *viewController;

@end

@implementation RCCDismissInteractionController

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _interactionInProgress = NO;
    _shouldCompleteTransition = NO;
    
    return self;
}

- (void)wireToViewController:(UIViewController *)viewController
{
    self.viewController = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView *)view
{
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [gesture setDelegate:self];
    [view addGestureRecognizer:gesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:[gesture.view superview]];
    CGFloat progress = ((2/3) * translation.y / self.viewController.view.bounds.size.height);
    progress = fmin(fmax(progress, 0.0), 1.0);
    
    switch ([gesture state]) {
        case UIGestureRecognizerStateBegan:
            self.interactionInProgress = YES;
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
            self.shouldCompleteTransition = progress > 0.15;
            [self updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
            self.interactionInProgress = NO;
            [self cancelInteractiveTransition];
            break;
        case UIGestureRecognizerStateEnded:
            self.interactionInProgress = NO;
            if (!self.shouldCompleteTransition) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
        default:
            break;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint velocity = [gestureRecognizer velocityInView:[gestureRecognizer view]];
    return fabs(velocity.y) > fabs(velocity.x);
}

@end
