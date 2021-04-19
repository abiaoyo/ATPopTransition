//
//  ATPopInteractiveTransition.h
//  ATPopTransitionDemo
//
//  Created by liyebiao on 2021/3/23.
//

#import <UIKit/UIKit.h>
#import "ATPopScreenEdgePanGestureRecognizer.h"
NS_ASSUME_NONNULL_BEGIN

@interface ATPopInteractiveTransition : UIPercentDrivenInteractiveTransition

- (instancetype)initWithGestureRecognizer:(ATPopScreenEdgePanGestureRecognizer*)gestureRecognizer
                          edgeForDragging:(UIRectEdge)edge;

@end

NS_ASSUME_NONNULL_END
