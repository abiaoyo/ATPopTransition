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

- (ATPopScreenEdgePanGestureRecognizer *)edgePanGesture{
    return  objc_getAssociatedObject(self, _cmd);
}

- (void)setEdgePanGesture:(ATPopScreenEdgePanGestureRecognizer *)edgePanGesture{
    objc_setAssociatedObject(self, @selector(edgePanGesture), edgePanGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)atPop_openConfirmClose{
    NSNumber * value = objc_getAssociatedObject(self, _cmd);
    return value ? value.boolValue:NO;
}

- (void)setAtPop_openConfirmClose:(BOOL)openConfirmClose{
    objc_setAssociatedObject(self, @selector(atPop_openConfirmClose), @(openConfirmClose), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)atPop_isBeginGes{
    NSNumber * value = objc_getAssociatedObject(self, _cmd);
    return value ? value.boolValue:NO;
}

- (void)setAtPop_isBeginGes:(BOOL)isBeginGes{
    objc_setAssociatedObject(self, @selector(atPop_isBeginGes), @(isBeginGes), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))atPop_onBeginGesBlock{
    return  objc_getAssociatedObject(self, _cmd);
}

- (void)setAtPop_onBeginGesBlock:(void (^)(void))onBeginGesBlock{
    objc_setAssociatedObject(self, @selector(atPop_onBeginGesBlock), onBeginGesBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)atPop_canClose{
    return self.edgePanGesture.canClose;
}

- (void)setAtPop_canClose:(BOOL)canClose{
    self.edgePanGesture.canClose = canClose;
}

- (void)ATPop_AddInteractiveGes{
    if(self.navigationController){
        [self.navigationController ATPop_AddInteractiveGes];
    }else{
        if(self.edgePanGesture){
            [self ATPop_RemoveInteractiveGes];
        }
        ATPopScreenEdgePanGestureRecognizer *edgePanGesture = [[ATPopScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(ATPop_Dismiss:)];
        edgePanGesture.edges = UIRectEdgeLeft;
        edgePanGesture.openConfirmClose = self.atPop_openConfirmClose;
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
        if(sender.state == UIGestureRecognizerStateBegan){
            self.atPop_canClose = NO;
            self.atPop_isBeginGes = YES;
            if(self.atPop_openConfirmClose){
                if(self.atPop_onBeginGesBlock){
                    self.atPop_onBeginGesBlock();
                }
            }
        }
        ATPopPresentationController *delegate = (ATPopPresentationController *)self.transitioningDelegate;
        delegate.gestureRecognizer = (ATPopScreenEdgePanGestureRecognizer *)sender;
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        self.atPop_isBeginGes = NO;
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
