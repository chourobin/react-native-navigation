#import <UIKit/UIKit.h>
#import "RCTBridge.h"

@class RCCPresentAnimationController;
@class RCCDismissAnimationController;
@class RCCDismissInteractionController;

@interface RCCNavigationController : UINavigationController

@property (strong, nonatomic) RCCPresentAnimationController *presentAnimationController;

@property (strong, nonatomic) RCCDismissAnimationController *dismissAnimationController;

@property (strong, nonatomic) RCCDismissInteractionController *dismissInteractionController;

- (instancetype)initWithProps:(NSDictionary *)props children:(NSArray *)children globalProps:(NSDictionary*)globalProps bridge:(RCTBridge *)bridge;

- (void)performAction:(NSString*)performAction actionParams:(NSDictionary*)actionParams bridge:(RCTBridge *)bridge;

@end
