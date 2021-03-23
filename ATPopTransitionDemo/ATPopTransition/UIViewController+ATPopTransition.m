//
//  UIViewController+ATPopTransition.m
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/3/23.
//

#import "UIViewController+ATPopTransition.h"
#import "ATPopPresentationController.h"

@implementation UIViewController (ATPopTransition)

- (void)ATPop_AddInteractiveGes{
    if(self.navigationController){
        [self.navigationController ATPop_AddInteractiveGes];
    }else{
        UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(ATPop_Dismiss:)];
        gesture.edges = UIRectEdgeLeft;
        [self.view addGestureRecognizer:gesture];
    }
}

- (void)ATPop_Dismiss:(UIGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateBegan && [self.transitioningDelegate isKindOfClass:[ATPopPresentationController class]]) {
        ATPopPresentationController *delegate = (ATPopPresentationController *)self.transitioningDelegate;
        delegate.gestureRecognizer = (UIScreenEdgePanGestureRecognizer *)sender;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)ATPop_Dismiss{
    if(self.navigationController){
        [self.navigationController ATPop_Dismiss];
    }else {
        ATPopPresentationController *delegate = (ATPopPresentationController *)self.transitioningDelegate;
        delegate.gestureRecognizer = nil;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
