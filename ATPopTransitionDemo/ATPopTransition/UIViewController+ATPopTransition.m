//
//  UIViewController+ATPopTransition.m
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/3/23.
//

#import "UIViewController+ATPopTransition.h"
#import "ATPopPresentationController.h"
#import <objc/runtime.h>


@implementation UIViewController (ATPopTransition)

- (UIScreenEdgePanGestureRecognizer *)edgePanGesture{
    return  objc_getAssociatedObject(self, _cmd);
}

- (void)setEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePanGesture{
    objc_setAssociatedObject(self, @selector(edgePanGesture), edgePanGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ATPop_AddInteractiveGes{
    if(self.navigationController){
        [self.navigationController ATPop_AddInteractiveGes];
    }else{
        if(self.edgePanGesture){
            [self ATPop_RemoveInteractiveGes];
        }
        UIScreenEdgePanGestureRecognizer *edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(ATPop_Dismiss:)];
        edgePanGesture.edges = UIRectEdgeLeft;
        [self.view addGestureRecognizer:edgePanGesture];
        self.edgePanGesture = edgePanGesture;
    }
}

- (void)ATPop_RemoveInteractiveGes{
    if(self.navigationController){
        [self.navigationController ATPop_RemoveInteractiveGes];
    }else{
        if(self.edgePanGesture){
            [self.view removeGestureRecognizer:self.edgePanGesture];
        }
    }
}

- (void)ATPop_Dismiss:(UIPanGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateBegan && [self.transitioningDelegate isKindOfClass:[ATPopPresentationController class]]) {
        if([self isKindOfClass:UINavigationController.class]){
            UINavigationController * navCtl = (UINavigationController *)self;
            if(navCtl.viewControllers.count > 1){
                return;
            }
        }
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
