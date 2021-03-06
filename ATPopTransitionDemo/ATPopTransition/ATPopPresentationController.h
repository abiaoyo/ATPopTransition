//
//  ATPopPresentationController.h
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/3/23.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ATPopTransition.h"
#import "ATPopScreenEdgePanGestureRecognizer.h"
NS_ASSUME_NONNULL_BEGIN




@interface ATPopPresentationController : UIPresentationController<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong, nullable) ATPopScreenEdgePanGestureRecognizer * gestureRecognizer;

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(nullable UIViewController *)presentingViewController
                                  contentHeight:(CGFloat)contentHeight;

@end

NS_ASSUME_NONNULL_END
