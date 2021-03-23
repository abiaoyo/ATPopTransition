//
//  ATPopPresentationController.m
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/3/23.
//

#import "ATPopPresentationController.h"
#import "ATPopInteractiveTransition.h"

@interface ATPopPresentationController()
@property (nonatomic, strong) UIView *dismissView;
@property (nonatomic, strong) UIView *replacePresentView;
@end

@implementation ATPopPresentationController

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"--- dealloc ATPopPresentationController ---");
#endif
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
                       presentingViewController:(nullable UIViewController *)presentingViewController{
    
    self =[super initWithPresentedViewController:presentedViewController
                        presentingViewController:presentingViewController];
    if (self) {
        // 自定义modalPresentationStyle
        presentedViewController.modalPresentationStyle= UIModalPresentationCustom;
    }
    return self;
}

//MARK:Override
/**
 present将要执行
 */
- (void)presentationTransitionWillBegin {
    self.replacePresentView = [[UIView alloc] initWithFrame:[self frameOfPresentedViewInContainerView]];
    self.replacePresentView.layer.cornerRadius = 10;
    self.replacePresentView.layer.shadowOpacity = 0.05f;
    self.replacePresentView.layer.shadowRadius = 5.f;
    self.replacePresentView.layer.shadowOffset = CGSizeMake(0, -5.f);
    
    UIView *presentedView = [super presentedView];
    presentedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.replacePresentView addSubview:presentedView];
    
    UIView *dismissView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    [self.containerView addSubview:dismissView];
    self.dismissView = dismissView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDismiss)];
    [self.dismissView addGestureRecognizer:tap];
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    self.dismissView.alpha = 0.f;
    self.dismissView.backgroundColor = [UIColor blackColor];
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        self.dismissView.alpha = 0.25f;
        
    } completion:NULL];
    
}
/**
 present执行结束
 */
- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        self.dismissView = nil;
    }
}
/**
 dismiss将要执行
 */
- (void)dismissalTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dismissView.alpha = 0.f;
    } completion:NULL];
}
/**
 dismiss执行结束
 */
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed == YES){
        self.dismissView = nil;
    }
}

- (UIView *)presentedView {
    return self.replacePresentView;
}

//MARK:Event
- (void)tapDismiss{
    UIViewController * presentedViewController = self.presentedViewController;
    if(presentedViewController && [presentedViewController respondsToSelector:@selector(ATPop_Dismiss)]){
        [presentedViewController ATPop_Dismiss];
    }
}

//MARK:UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.45;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    
    BOOL present = (toVc.presentingViewController == fromVc) ? YES : NO;
    CGFloat targetHeight = UIScreen.mainScreen.bounds.size.height*(530/667.0);
    if (present) {
        toView.frame = CGRectMake(0, containerView.bounds.size.height, containerView.bounds.size.width, targetHeight);
        toVc.view.frame = CGRectMake(0, 0, containerView.bounds.size.width, targetHeight);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.95 initialSpringVelocity:0.05 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            toView.frame = CGRectMake(0, containerView.bounds.size.height - targetHeight, containerView.bounds.size.width, targetHeight);
        } completion:^(BOOL finished) {
            BOOL cancel = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!cancel];
        }];
        
    } else {
        fromView.frame = CGRectMake(0, containerView.bounds.size.height - targetHeight, containerView.bounds.size.width, targetHeight);
        fromVc.view.frame = CGRectMake(0, 0, containerView.bounds.size.width, targetHeight);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.95 initialSpringVelocity:0.05 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            fromView.frame = CGRectMake(0, containerView.bounds.size.height, containerView.bounds.size.width, targetHeight);
        } completion:^(BOOL finished) {
            BOOL cancel = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!cancel];
        }];
    }
}
//MARK:UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
    
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    return self;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    //有手势 返回处理交互协议对象
    if (self.gestureRecognizer) {
        return [[ATPopInteractiveTransition alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:UIRectEdgeLeft];
    }
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    if (self.gestureRecognizer) {
        return [[ATPopInteractiveTransition alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:UIRectEdgeLeft];
    }
    return nil;
}

@end
