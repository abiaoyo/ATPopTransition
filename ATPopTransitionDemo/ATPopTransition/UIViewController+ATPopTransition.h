//
//  UIViewController+ATPopTransition.h
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/3/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ATPopTransition)

@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer * edgePanGesture;


//添加滑动返回手势
- (void)ATPop_AddInteractiveGes;
- (void)ATPop_RemoveInteractiveGes;
//退出Present
- (void)ATPop_Dismiss;



@end

NS_ASSUME_NONNULL_END
