//
//  HomeDetailViewController.m
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/3/23.
//

#import "HomeDetailViewController.h"
#import "WebViewController.h"
#import "ATPopNavigationController.h"
#import "UIViewController+ATPopTransition.h"

@interface HomeDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation HomeDetailViewController

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"--- dealloc HomeDetailViewController ---");
#endif
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
    
    
    //测试退出之前的提示
    [self testCloseAlert];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!self.navigationController){
        [self testNotNavigationControllerAddGes];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    if(!self.navigationController){
        [self testNotNavigationControllerRemoveGes];
    }
}

- (void)testNotNavigationControllerAddGes{
    [self ATPop_AddInteractiveGes];
}
- (void)testNotNavigationControllerRemoveGes{
    [self ATPop_RemoveInteractiveGes];
}


int flag = 0;
- (void)testCloseAlert{
    __weak typeof(self) weakself = self;
    if(self.navigationController){
        self.navigationController.atPop_openConfirmClose = YES;
        self.navigationController.atPop_onBeginGesBlock = ^{
            if(flag % 2 == 0){
                [weakself performSelector:@selector(showAlert) withObject:nil afterDelay:0.1];
            }else{
                [weakself performSelector:@selector(didChange) withObject:nil afterDelay:0.1];
            }
            flag += 1;
        };
    }else{
        self.atPop_openConfirmClose = YES;
        self.atPop_onBeginGesBlock = ^{
            if(flag % 2 == 0){
                [weakself performSelector:@selector(showAlert) withObject:nil afterDelay:0.1];
            }else{
                [weakself performSelector:@selector(didChange) withObject:nil afterDelay:0.1];
            }
            flag += 1;
        };
    }
    
}

- (void)didChange{
    if(self.navigationController){
        self.navigationController.atPop_canClose = YES;
    }else{
        self.atPop_canClose = YES;
    }
}

- (void)showAlert{
    [[[UIAlertView alloc] initWithTitle:nil message:@"还示保存，确定退出吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex != 0){
        if(self.navigationController){
            [self.navigationController ATPop_Dismiss];
        }else{
            [self ATPop_Dismiss];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = @"UITableViewCell";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController * vctl = [[WebViewController alloc] init];
    [self.navigationController pushViewController:vctl animated:YES];
}

@end
