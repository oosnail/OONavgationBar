//
//  DXLBaseViewController.h
//  DXLLibrary
//
//  Created by LCQ on 15/2/10.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DXLOriginViewController;

UIKIT_EXTERN NSString *const PushObject;
UIKIT_EXTERN NSString *const Title;
UIKIT_EXTERN NSString *const FromType;
UIKIT_EXTERN NSString *const BusinessType; //value应为NSNumber类型或NSString类型

@protocol DXLViewControllerDelegate <NSObject>

@optional
- (void)refresh:(DXLOriginViewController *)viewController;//点击刷新的回调

- (void)requestSuccess:(BOOL)yesOrNo withResponse:(id)response withError:(NSError *)error withViewController:(DXLOriginViewController *)viewController;

- (void)requestSuccess:(BOOL)yesOrNo withRequestModel:(id)requestModel withDealModel:(id)dealModel withError:(NSError *)error withViewController:(DXLOriginViewController *)viewController;

@end

@interface DXLOriginViewController : UIViewController

@property (nonatomic, assign, readonly) BOOL hiddenBack;

//导航栏设置
@property (nonatomic, assign) BOOL transparentNavigationBar;//透明

//params里常用的参数
@property (nonatomic, strong) id pushObjct;
@property (nonatomic, copy) id navigationTitle;
@property (nonatomic, copy) NSString *fromType;
@property (nonatomic, assign) NSInteger businessType;

@property (nonatomic, assign, readonly) BOOL firstAppear;
@property (nonatomic, assign) BOOL editNoWhenDisappear;
@property (nonatomic, assign) NSInteger numberOfLinesForTitle; //默认1行


/**
 *  导航栏标题和统计
 *
 */
- (id)getTitleText;

- (NSDictionary *)getAnalysisDictionary;


@end


@interface UIViewController (DXLNavigationBar)

@property (nonatomic) id titleLabelText;
@property (nonatomic) id subTitleLabelText;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *subTitleLabel;
@property (nonatomic, readonly) UIView *centerView;
@property (nonatomic) CGFloat leftMargin;
@property (nonatomic) CGFloat rightMargin;
@property (nonatomic) CGFloat marginTitleToSubTitle;
@property (nonatomic) BOOL navigationBarSeparatorLineHidden;
@property (nonatomic) BOOL centerViewAlignmentNatural;

@property (nonatomic) BOOL navigationBarTransparentGradient; //导航栏透明渐隐渐显
@property (nonatomic) CGFloat navigationBarExtendLayoutViewAlpha;
@property (nonatomic) BOOL navigationBarIsTransparent;
@property (nonatomic) UIColor *navigationBarTintColor;//设置导航栏tintColor
@property (nonatomic) UIImage *navigationBarImage; //设置导航栏背景图片
@property (nonatomic) CGFloat navigationBarTransparentOffsetY; //设置导航栏透明当前偏移量
@property (nonatomic) CGFloat navigationBarTransparentMaxOffsetY; //设置导航栏透明最大偏移量

//margin 默认 0


- (void)setRightBarButtonItems:(NSArray *)rightBarButtonItems withRightMargin:(CGFloat)margin;

- (void)setLeftBarButtonItems:(NSArray *)leftBarButtonItems withLeftMargin:(CGFloat)margin;

- (void)setBackBarButtonItemWithImage:(UIImage *)image withTitle:(NSString *)title withLeftItemsSupplementBackButton:(BOOL)yesOrNo;

- (void)setBackBarButtonItemCustomWithImage:(UIImage *)image;

- (void)setNavigationTitleView:(void(^)(UILabel *label))setting;

- (void)setNavigationCenterCustomView:(UIView *)view;

- (void)setNavigationCenterCustomView:(UIView *)view adjustCenterView:(BOOL)yesOrNo;

- (void)setShowNavigationBarSeparatorLine:(BOOL)showNavigationBarSeparatorLine;

- (void)setNavigationBarSeparatorLineWidth:(CGFloat)navigationBarSeparatorLineWidth;

- (void)setNavigationBarSeparatorLineHeight:(CGFloat)navigationBarSeparatorLineHeight;




- (UIImageView *)navigationBarExtendLayoutView;

- (UIView *)navigationBarSeparatorLine;

/**
 *  控制视图控制器视图原点位置
 *
 *  @param yesOrNo YES从导航栏顶部开始 NO从导航栏底部开始
 */
- (void)extendedLayoutBar:(BOOL)yesOrNo;

/**
 *  控制视图控制器导航栏是否透明
 *
 */
- (void)translucentBar:(BOOL)yesOrNo;

- (void)translucentBar:(BOOL)yesOrNo alpha:(CGFloat)alpha;

/**
 * 需要重写
 *
 */
- (void)setNavigationBarItem;

- (void)prohibitClickWhenRequest:(BOOL)yesOrNO;

/**
 * 需要重写，调用super
 */
- (void)showBackItem;

- (void)hiddenBackItem;

/**
 *  显示HUD
 *
 */
- (void)showLoading;

/**
 *  隐藏HUD
 *
 */
- (void)hideLoadingViewImmediately;

/**
 * 点击返回的方法，可以被重写
 * 此方法只针对“- (void)setBackBarButtonItemCustomWithImage:(UIImage *)image”创建的返回按钮有效
 *
 */
- (void)didBackAction;


@end





