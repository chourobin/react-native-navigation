//
//  RCCDismissInteractionController.h
//  ReactNativeNavigation
//
//  Created by Robin Chou on 12/14/16.
//  Copyright © 2016 artal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCCDismissInteractionController : UIPercentDrivenInteractiveTransition

@property (assign, nonatomic) BOOL interactionInProgress;

- (void)wireToViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
