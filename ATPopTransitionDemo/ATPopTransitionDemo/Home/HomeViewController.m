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
#import "ATPopNavigationController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)clickDetail:(id)sender {
        
    HomeDetailViewController * vctl = [[HomeDetailViewController alloc] init];
    ATPopNavigationController * navCtl = [[ATPopNavigationController alloc] initWithRootViewController:vctl];
    ATPopPresentationController *presentationController = [[ATPopPresentationController alloc] initWithPresentedViewController:navCtl presentingViewController:self contentHeight:UIScreen.mainScreen.bounds.size.height*0.66];
    navCtl.transitioningDelegate = presentationController;
    [self presentViewController:navCtl animated:YES completion:nil];
}

@end
