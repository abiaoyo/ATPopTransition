//
//  BUAlertView.h
//  BaseUIComponent
//
//  Created by 陈欢 on 2019/12/31.
//

#import <UIKit/UIKit.h>

#define BU_BUTTON_HEIGHT 45
#define BU_ALERT_VIEW_WIDTH 375-40
#define BU_ALERT_VIEW_CORNOR_RADIUS 10

typedef void(^ButtonClickedBlock) (NSInteger buttonTag);

typedef NS_ENUM(NSInteger, BUAlertViewButtonType) {
    BUAlertViewButtonTypeHorizontal = 0,
    BUAlertViewButtonTypeVertical = 1,
};

NS_ASSUME_NONNULL_BEGIN

@interface BUAlertView : UIView

@property (nonatomic, weak) UIView *fatherView; // 容器

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) CGFloat buttonTopSpacing;     //defalut is 24
@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic, copy) ButtonClickedBlock buttonClickedBlock;
@property (nonatomic, assign) BUAlertViewButtonType buttonType;     //default is BUAlertViewButtonTypeHorizontal

- (void)show;

- (void)close;

- (void)updateAlertView;

- (UIView *)createContainerViewWithTitle:(NSString *)title msg:(NSString *)msg;


/**
 创建显示视图
 
 @param title title
 @param titleLine title行数，0为不限制
 @param msg msg
 @param msgLimitheight msg高度限制，超过msg文本可滑动,0为不限制
 @return view
 */
- (UIView *)createContainerViewWithTitle:(NSString *)title titleLine:(NSInteger)titleLine msg:(NSString *)msg msgLimitheight:(CGFloat)msgLimitheight;

- (void)setMsgTextAlignment:(NSTextAlignment)alignment;

- (void)setMsgTextFont:(UIFont *)font andColor:(UIColor *)color;

- (void)setMsgTextFontKey:(NSString *)fontKey andColorKey:(NSString *)colorKey;

@end

NS_ASSUME_NONNULL_END
