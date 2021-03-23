//
//  HomeViewController.m
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/3/23.
//

#import "HomeViewController.h"
#import "HomeDetailViewController.h"
#import "ATPopPresentationController.h"
#import "UIViewController+ATPopTransition.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)clickDetail:(id)sender {
//    HomeDetailViewController * vctl = [[HomeDetailViewController alloc] init];
//    ATPopPresentationController *presentationController = [[ATPopPresentationController alloc] initWithPresentedViewController:vctl presentingViewController:self];
//    vctl.transitioningDelegate = presentationController;
//    [self presentViewController:vctl animated:YES completion:nil];
    
    HomeDetailViewController * vctl = [[HomeDetailViewController alloc] init];
    UINavigationController * navCtl = [[UINavigationController alloc] initWithRootViewController:vctl];
    ATPopPresentationController *presentationController = [[ATPopPresentationController alloc] initWithPresentedViewController:navCtl presentingViewController:self];
    navCtl.transitioningDelegate = presentationController;
    [self presentViewController:navCtl animated:YES completion:nil];
}

@end
