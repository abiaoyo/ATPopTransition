//
//  ATPopPresentationController.h
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/3/23.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ATPopTransition.h"
NS_ASSUME_NONNULL_BEGIN

@interface ATPopPresentationController : UIPresentationController<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong, nullable) UIScreenEdgePanGestureRecognizer * gestureRecognizer;

@end

NS_ASSUME_NONNULL_END
