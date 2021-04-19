//
//  ATPopScreenEdgePanGestureRecognizer.h
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/4/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATPopScreenEdgePanGestureRecognizer : UIScreenEdgePanGestureRecognizer

@property (nonatomic,assign) BOOL openConfirmClose;
@property (nonatomic,assign) BOOL canClose;

@end

NS_ASSUME_NONNULL_END
