//
//  BaseNavigationController.m
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/4/16.
//

#import "BaseNavigationController.h"
#import "UIViewController+ATPopTransition.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.viewControllers.count > 1;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count <= 1){
        [self ATPop_AddInteractiveGes];
    }else{
        [self ATPop_RemoveInteractiveGes];
    }
}

@end
