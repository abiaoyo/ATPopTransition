//
//  HomeDetailViewController.m
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/3/23.
//

#import "HomeDetailViewController.h"
#import "UIViewController+ATPopTransition.h"

@interface HomeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation HomeDetailViewController

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"--- dealloc HomeDetailViewController ---");
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
    
    if(self.navigationController.viewControllers.count <= 1){
        [self ATPop_AddInteractiveGes];
        
        UIBarButtonItem * closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemClose target:self action:@selector(clickCloseButton)];
        self.navigationItem.leftBarButtonItem = closeItem;
    }
}

- (void)clickCloseButton{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self ATPop_Dismiss];
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
    HomeDetailViewController * vctl = [[HomeDetailViewController alloc] init];
    [self.navigationController pushViewController:vctl animated:YES];
}

@end
