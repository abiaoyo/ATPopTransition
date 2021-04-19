//
//  WebViewController.m
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/4/16.
//

#import "WebViewController.h"
#import <WebKit/WKWebView.h>

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

@end
