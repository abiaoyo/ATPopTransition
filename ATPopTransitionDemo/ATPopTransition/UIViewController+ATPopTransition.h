//
//  UIViewController+ATPopTransition.h
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/3/23.
//

#import <UIKit/UIKit.h>
#import "ATPopScreenEdgePanGestureRecognizer.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ATPopTransition)

@property (nonatomic,assign) BOOL atPop_openConfirmClose;
@property (nonatomic,assign) BOOL atPop_isBeginGes;
@property (nonatomic,copy) void (^atPop_onBeginGesBlock)(void);
@property (nonatomic,assign) BOOL atPop_canClose;

//添加滑动返回手势
- (void)ATPop_AddInteractiveGes;
//移除滑动返回手势
- (void)ATPop_RemoveInteractiveGes;
//退出Present
- (void)ATPop_Dismiss;

@end

NS_ASSUME_NONNULL_END
