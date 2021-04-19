//
//  BUAlertView.m
//  BaseUIComponent
//
//  Created by 陈欢 on 2019/12/31.
//

#import "BUAlertView.h"

@interface BUAlertView()

@property (nonatomic, strong) UIView *dialogView;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) UILabel *msgLabel;

@end

@implementation BUAlertView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.buttonTopSpacing = 25;
        self.buttonType = BUAlertViewButtonTypeHorizontal;
        [self addNotification];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.buttonTopSpacing = 25;
        [self addNotification];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)show {
    self.dialogView = [self createDialogView];
    self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
    [self addSubview:self.dialogView];
    if (self.fatherView) {
        [self.fatherView addSubview:self];
    } else {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    }
    
    self.dialogView.layer.opacity = 0.6f;
    self.dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [self sk_view_setBackgroundColor:ui_popupMaskView_style_1_color opacity:ui_popupMaskView_style_1_opacity];
        self.dialogView.layer.opacity = 1.0f;
        self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    } completion:NULL];
}

- (void)close {
    CATransform3D currentTransform = self.dialogView.layer.transform;
    self.dialogView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
        self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
        self.dialogView.layer.opacity = 0.0f;
    } completion:^(BOOL finished) {
        for (UIView *v in [self subviews]) {
            [v removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}

- (UIView *)createContainerViewWithTitle:(NSString *)title msg:(NSString *)msg {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BU_ALERT_VIEW_WIDTH, 140)];
    
    CGFloat width = BU_ALERT_VIEW_WIDTH-32.5*2;
    CGFloat height = 0;
    UILabel *titleLabel = [[UILabel alloc] init];
    if (title.length > 0) {
        UIFont *font = [UIFont systemFontOfSize:15];//[[SkinManager sharedManager] getFontStyleWithKey:font_style_44_1_font];
        height = 50;//[Util sizeWithText:title font:font maxWidth:width].height;
        titleLabel.frame = CGRectMake(32.5, 38, width, height);
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        [contentView addSubview:titleLabel];
    }
    _msgLabel.text = msg;
    _msgLabel.numberOfLines = 0;
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:_msgLabel];
    
    contentView.frame = CGRectMake(0, 0, BU_ALERT_VIEW_WIDTH, CGRectGetMaxY(_msgLabel.frame)+6);
    
    return contentView;
}

- (UIView *)createContainerViewWithTitle:(NSString *)title titleLine:(NSInteger)titleLine msg:(NSString *)msg msgLimitheight:(CGFloat)msgLimitheight {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BU_ALERT_VIEW_WIDTH, 140)];
    
    CGFloat width = BU_ALERT_VIEW_WIDTH-36.5*2;
    CGFloat height = 0;
    UILabel *titleLabel = [[UILabel alloc] init];
    if (title.length > 0) {
        UIFont *font = [UIFont systemFontOfSize:15];//[[SkinManager sharedManager] getFontStyleWithKey:font_style_44_1_font];
        height = 50;//[Util sizeWithText:title font:font maxWidth:width].height;
        titleLabel.frame = CGRectMake(36.5, 34, width, height);
        titleLabel.text = title;
//        [titleLabel sk_lab_setTextFont:font_style_44_1_font];
//        [titleLabel sk_lab_setTextColor:font_style_44_1_color];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = titleLine;
        
        if (titleLine != 0 && height > titleLabel.font.lineHeight*titleLine) {
            CGRect mFrame = titleLabel.frame;
            mFrame.size.height = titleLabel.font.lineHeight*titleLine;
            titleLabel.frame = mFrame;
        }
        
        [contentView addSubview:titleLabel];
    }
    
    BOOL isNeedScroll = NO;
    CGFloat contentHeight;
    _msgLabel = [[UILabel alloc] init];
//    if (title.length > 0) {
//        UIFont *font = [[SkinManager sharedManager] getFontStyleWithKey:font_style_44_2_font];
//        height = [Util sizeWithText:msg font:font maxWidth:width].height;
//        contentHeight = height;
//        if (msgLimitheight > 0 && height > msgLimitheight) {
//            height = msgLimitheight;
//            isNeedScroll = YES;
//        }
//        [_msgLabel sk_lab_setTextFont:font_style_44_2_font];
//        [_msgLabel sk_lab_setTextColor:font_style_44_2_color];
//        _msgLabel.frame = CGRectMake(36.5, CGRectGetMaxY(titleLabel.frame)+12, width, contentHeight);
//    } else {
//        UIFont *font = [[SkinManager sharedManager] getFontStyleWithKey:font_style_31_font];
//        height = [Util sizeWithText:msg font:font maxWidth:width].height;
//        contentHeight = height;
//        if (msgLimitheight > 0 && height > msgLimitheight) {
//            height = msgLimitheight;
//            isNeedScroll = YES;
//        }
//        [_msgLabel sk_lab_setTextFont:font_style_31_font];
//        [_msgLabel sk_lab_setTextColor:font_style_31_color];
//        _msgLabel.frame = CGRectMake(36.5, 44, width, contentHeight);
//    }
    _msgLabel.text = msg;
    _msgLabel.numberOfLines = 0;
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    
    UIScrollView *msgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_msgLabel.frame), CGRectGetMinY(_msgLabel.frame), CGRectGetWidth(_msgLabel.frame), height)];
    msgScrollView.contentSize = CGSizeMake(CGRectGetWidth(msgScrollView.frame), contentHeight);
    msgScrollView.scrollEnabled = isNeedScroll;
    msgScrollView.showsVerticalScrollIndicator = NO;
    
    CGRect mFrame = _msgLabel.frame;
    mFrame.origin.x = 0;
    mFrame.origin.y = 0;
    _msgLabel.frame = mFrame;
    [msgScrollView addSubview:_msgLabel];
    
    [contentView addSubview:msgScrollView];
    
    contentView.frame = CGRectMake(0, 0, BU_ALERT_VIEW_WIDTH, CGRectGetMaxY(msgScrollView.frame)+6);
    
    return contentView;
}

- (void)setMsgTextAlignment:(NSTextAlignment)alignment {
    _msgLabel.textAlignment = alignment;
}

- (void)setMsgTextFont:(UIFont *)font andColor:(UIColor *)color {
    _msgLabel.textColor = color;
    _msgLabel.font = font;
}

- (void)setMsgTextFontKey:(NSString *)fontKey andColorKey:(NSString *)colorKey {
//    [_msgLabel sk_lab_setTextFont:fontKey];
//    [_msgLabel sk_lab_setTextColor:colorKey];
//    UIFont *font = [[SkinManager sharedManager] getFontStyleWithKey:fontKey];
//    CGFloat height = [Util sizeWithText:_msgLabel.text font:font maxWidth:_msgLabel.width].height;
//    _msgLabel.height = height;
}

#pragma mark - Notification

- (void)keyboardWillShow:(NSNotification *)notification {
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat dialogHeight = CGRectGetHeight(self.containerView.frame);
    if (self.buttonTitles.count > 0) {
        dialogHeight = CGRectGetHeight(self.containerView.frame) + 85;
    }
    
    CGRect rect = self.dialogView.frame;
    rect.origin.y = (screenHeight-dialogHeight)/2-60;
    self.dialogView.frame = rect;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGRect rect = self.dialogView.frame;
    rect.origin.y += 60;
    self.dialogView.frame = rect;
}

#pragma mark - Button Event

- (void)actionButtonClicked:(UIButton *)sender {
    [self close];
    
    if (self.buttonClickedBlock) {
        self.buttonClickedBlock(sender.tag);
    }
}

#pragma mark - Lazy Load

- (UIView *)createDialogView {
    if (!self.containerView) {
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BU_ALERT_VIEW_WIDTH, 175)];
    }
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat dialogWidth = CGRectGetWidth(self.containerView.frame);
    CGFloat dialogHeight = CGRectGetHeight(self.containerView.frame);
    
    if (self.buttonTitles.count > 0) {
        dialogHeight = CGRectGetHeight(self.containerView.frame) + 20 + BU_BUTTON_HEIGHT + self.buttonTopSpacing;
    }
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake((screenWidth-dialogWidth)/2, (screenHeight-dialogHeight)/2, dialogWidth, dialogHeight)];
    
//    [alertView sk_view_setCornerRadius:ui_bg_style_2_cornerRadius];
//    [alertView sk_view_setBackgroundColor:ui_bg_style_2_color];
    alertView.backgroundColor = UIColor.orangeColor;
    alertView.layer.masksToBounds = YES;
    
    [alertView addSubview:self.containerView];
    [self setButtonsToView:alertView];
//    [alertView resizeForBorder];
    
    return alertView;
}

- (void)updateAlertView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat dialogWidth = BU_ALERT_VIEW_WIDTH;
    CGFloat dialogHeight = CGRectGetHeight(self.containerView.frame);
    
    if (self.buttonTitles.count > 0) {
        dialogHeight = CGRectGetHeight(self.containerView.frame) + 85;
    }
    CGFloat margin = dialogHeight - CGRectGetHeight(self.dialogView.frame);
    self.dialogView.frame = CGRectMake((screenWidth-dialogWidth)/2, (screenHeight-dialogHeight)/2, dialogWidth, dialogHeight);
    for (UIView *obj in self.dialogView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)obj;
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y+margin, button.frame.size.width, button.frame.size.height);
        }
    }
}

- (void)setButtonsToView:(UIView *)view {
    if (self.buttonTitles.count == 1) {
        CGFloat width = 185;
        UIButton *actionButton = [self createActionButtonWithTitle:[self.buttonTitles objectAtIndex:0] tag:0 frame:CGRectMake((375-width)/2, CGRectGetHeight(self.containerView.frame)+self.buttonTopSpacing, width, BU_BUTTON_HEIGHT)];
        actionButton.titleLabel.lineBreakMode = NSLineBreakByClipping;
//        [actionButton.titleLabel sk_lab_setTextFont:ui_button_style_3_1_font];
//        [actionButton.button sk_btn_setTitleColor:ui_button_style_3_1_fontColor forState:UIControlStateNormal];
//        [actionButton.button sk_btn_setBackgroundImageFromColor:ui_button_style_3_1_color forState:UIControlStateNormal];
//        [actionButton.button sk_btn_setBackgroundImageFromColor:ui_button_style_3_2_color forState:UIControlStateHighlighted];
//        [actionButton gh_setShadowColorWithStyle:ui_button_style_3_1_shadowColor];
//        [actionButton gh_setShadowOpacityWithStyle:ui_button_style_3_1_shadowOpacity];
        
        [view addSubview:actionButton];
    } else if (self.buttonTitles.count == 2) {
        CGRect mFrame = CGRectMake((375-130*2-20)/2, CGRectGetHeight(self.containerView.frame)+self.buttonTopSpacing, 130, BU_BUTTON_HEIGHT);
        if (self.buttonType == BUAlertViewButtonTypeVertical) {
            mFrame = CGRectMake((375-234)/2.0, CGRectGetHeight(self.containerView.frame)+self.buttonTopSpacing, 234, BU_BUTTON_HEIGHT);
        }
        
        UIButton *actionButton1 = [self createActionButtonWithTitle:[self.buttonTitles objectAtIndex:0] tag:0 frame:mFrame];
        actionButton1.titleLabel.lineBreakMode = NSLineBreakByClipping;
    
//        [actionButton1.button.titleLabel sk_lab_setTextFont:ui_button_style_5_1_font];
//        [actionButton1.button sk_btn_setTitleColor:ui_button_style_5_1_fontColor forState:UIControlStateNormal];
//        [actionButton1.button sk_btn_setBackgroundImageFromColor:ui_button_style_5_1_color forState:UIControlStateNormal];
//        [actionButton1.button sk_btn_setBackgroundImageFromColor:ui_button_style_5_2_color forState:UIControlStateHighlighted];
//        [actionButton1 gh_setShadowColorWithStyle:ui_button_style_5_1_shadowColor];
//        [actionButton1 gh_setShadowOpacityWithStyle:ui_button_style_5_1_shadowOpacity];
        
        mFrame = CGRectMake(CGRectGetMaxX(actionButton1.frame)+20, CGRectGetHeight(self.containerView.frame)+self.buttonTopSpacing, 130, BU_BUTTON_HEIGHT);
        if (self.buttonType == BUAlertViewButtonTypeVertical) {
//            mFrame = CGRectMake(actionButton1.x, actionButton1.bottom+20, actionButton1.width, actionButton1.height);
        }
        UIButton *actionButton2 = [self createActionButtonWithTitle:[self.buttonTitles objectAtIndex:1] tag:1 frame:mFrame];
        actionButton2.titleLabel.lineBreakMode = NSLineBreakByClipping;
        
//        [actionButton2.button.titleLabel sk_lab_setTextFont:ui_button_style_3_1_font];
//        [actionButton2.button sk_btn_setTitleColor:ui_button_style_3_1_fontColor forState:UIControlStateNormal];
//        [actionButton2.button sk_btn_setBackgroundImageFromColor:ui_button_style_3_1_color forState:UIControlStateNormal];
//        [actionButton2.button sk_btn_setBackgroundImageFromColor:ui_button_style_3_2_color forState:UIControlStateHighlighted];
//        [actionButton2 gh_setShadowColorWithStyle:ui_button_style_3_1_shadowColor];
//        [actionButton2 gh_setShadowOpacityWithStyle:ui_button_style_3_1_shadowOpacity];
        
        [view addSubview:actionButton1];
        [view addSubview:actionButton2];
        
//        view.height = actionButton2.bottom + 20;
        view.center = self.center;
        
        if (self.buttonType == BUAlertViewButtonTypeVertical) {
//            [actionButton1.button.titleLabel sk_lab_setTextFont:ui_button_style_3_1_font];
//            [actionButton1.button sk_btn_setTitleColor:ui_button_style_3_1_fontColor forState:UIControlStateNormal];
//            [actionButton1.button sk_btn_setBackgroundImageFromColor:ui_button_style_3_1_color forState:UIControlStateNormal];
//            [actionButton1.button sk_btn_setBackgroundImageFromColor:ui_button_style_3_2_color forState:UIControlStateHighlighted];
//            [actionButton1 gh_setShadowColorWithStyle:ui_button_style_3_1_shadowColor];
//            [actionButton1 gh_setShadowOpacityWithStyle:ui_button_style_3_1_shadowOpacity];
            
            [actionButton2 removeFromSuperview];
            UIButton *button2 = [[UIButton alloc] initWithFrame:mFrame];
//            button2.layer.cornerRadius = button2.height/2.0;
            button2.layer.masksToBounds = YES;
//            [button2 sk_view_setBorderWidth:ui_button_style_12_1_borderWidth];
//            [button2 sk_view_setBorderColor:ui_button_style_12_1_borderColor];
            [button2 setTitle:[self.buttonTitles objectAtIndex:1] forState:UIControlStateNormal];
//            [button2.titleLabel sk_lab_setTextFont:ui_button_style_12_1_font];
//            [button2 sk_btn_setTitleColor:ui_button_style_12_1_fontColor forState:UIControlStateNormal];
//            [button2 sk_btn_setBackgroundImageFromColor:ui_button_style_12_1_color forState:UIControlStateNormal];
//            [button2 sk_btn_setBackgroundImageFromColor:ui_button_style_12_2_color forState:UIControlStateHighlighted];
//            [button2 resizeForBorder];
            button2.tag = 1;
            [button2 addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button2];
            
//            view.height = button2.bottom + 20;
            view.center = self.center;
        }
    }
}

- (UIButton *)createActionButtonWithTitle:(NSString *)title tag:(NSInteger)tag frame:(CGRect)frame {
    UIButton *actionButton = [[UIButton alloc] initWithFrame:frame];
    actionButton.tag = tag;
    [actionButton addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    actionButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [actionButton setTitle:title forState:UIControlStateNormal];
//    [actionButton.titleLabel sk_lab_setTextFont:ui_button_style_3_1_font];
//    [actionButton.button sk_btn_setTitleColor:ui_button_style_3_1_fontColor forState:UIControlStateNormal];
    
    return actionButton;
}

@end
