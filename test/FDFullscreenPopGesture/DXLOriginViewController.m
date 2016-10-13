
//
//  DXLBaseViewController.m
//  DXLLibrary
//
//  Created by LCQ on 15/2/10.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import "DXLOriginViewController.h"
#import <objc/runtime.h>

#define MAS_SHORTHAND_GLOBALS

#define minShouldShowHudTime 0.3 //如果开始和结束时间小于0.3 则hud不显示
#define DefaultWidth [UIScreen mainScreen].bounds.size.width - 88

NSString *const PushObject = @"PushObject";
NSString *const Title = @"Title";
NSString *const FromType = @"FromType";
NSString *const BusinessType = @"BusinessType";

@interface DXLOriginViewController ()

@property (nonatomic, assign, readwrite) BOOL firstAppear;
@property (nonatomic, assign, readwrite) BOOL hiddenBack;
@property (nonatomic, assign) CGFloat leftWidth;
@property (nonatomic, assign) CGFloat rightWidth;
@property (nonatomic, assign) BOOL registerObserver;

@property (nonatomic, strong) UIImage *clearImage;

@end

@implementation DXLOriginViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.numberOfLinesForTitle = 1;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}




- (NSDictionary *)getAnalysisDictionary
{
    return nil;
}

- (id)getTitleText {
    return nil;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.editNoWhenDisappear = YES;
    self.firstAppear = YES;

    
    self.titleLabel.userInteractionEnabled = YES;
    self.navigationTitle = [self performSelector:@selector(getTitleText)];
    self.titleLabelText = _navigationTitle;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.shadowImage = nil;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent= NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar oo_setStatusBarBackgroundViewColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];

}

- (UIImage *)clearImage
{
    return [self imageViewWithColor:[UIColor clearColor]];
}

- (UIImage *)imageViewWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, -20, CGRectGetWidth(self.navigationController.navigationBar.bounds), CGRectGetWidth(self.navigationController.navigationBar.bounds) + 20);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    return UIGraphicsGetImageFromCurrentImageContext();
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    

    if (self.transparentNavigationBar) {
        [self translucentBar:YES];
        [self extendedLayoutBar:YES];
    }
    else {
        [self extendedLayoutBar:NO];
        [self translucentBar:NO];

    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.firstAppear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
    if (self.editNoWhenDisappear) {
        [self.view endEditing:YES];
    }
    
    [self extendedLayoutBar:NO];
    [self translucentBar:NO];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];

}




#pragma mark - Public


- (void)willPopAction:(NSNotification *)notifi
{

}

- (void)willPopViewController
{
    
}

#pragma mark - Set And Get Methods


- (void)setNumberOfLinesForTitle:(NSInteger)numberOfLinesForTitle
{
    _numberOfLinesForTitle = numberOfLinesForTitle;
    self.titleLabel.numberOfLines = _numberOfLinesForTitle;
}



#pragma mark - Override

- (void)showBackItem
{
    self.hiddenBack = NO;
}

- (void)hiddenBackItem
{
    self.hiddenBack = YES;
}




- (void)dealloc
{
    NSLog(@"-[%@ dealloc]",NSStringFromClass([self class]));
}

@end

static char TitleLabelTextKey;
static char SubTitleLabelTextKey;
static char TitleLabelKey;
static char SubTitleLabelKey;
static char CenterViewKey;
static char LeftMarginKey;
static char RightMarginKey;
static char HiddenBackKey;
static char CenterViewAlignmentNaturalKey;
static char MarginTitleToSubTitleKey;
static char CustomViewAdjustCenter;

static char NavigationBarSeparatorLineHiddenKey;
static char NavigationBarTintColorKey;
static char NavigationBarImageKey;
static char NavigationBarImageClearKey;
static char NavigationBarTransparentOffsetYKey;
static char NavigationBarTransparentMaxOffsetYKey;
static char NavigationBarExtendLayoutViewAlphaKey;
static char NavigationBarIsTransparentKey;
static char NavigationBarTransparentGradientKey;


@implementation UIViewController (DXLNavigationBar)

#pragma mark - Setter And Getter

- (void)setTitleLabelText:(id)titleLabelText
{
    objc_setAssociatedObject(self, &TitleLabelTextKey, titleLabelText, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self adjustTitle];
}

- (id)titleLabelText
{
    return objc_getAssociatedObject(self, &TitleLabelTextKey);
}

- (void)setSubTitleLabelText:(id)subTitleLabelText
{
    objc_setAssociatedObject(self, &SubTitleLabelTextKey, subTitleLabelText, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.subTitleLabel.text = subTitleLabelText;
    [self adjustTitle];
}

- (id)subTitleLabelText
{
    return objc_getAssociatedObject(self, &SubTitleLabelTextKey);
}

- (UILabel *)titleLabel
{
    UILabel *label = objc_getAssociatedObject(self, &TitleLabelKey);
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:18.f];
        label.backgroundColor = [UIColor clearColor];
        [self.centerView insertSubview:label atIndex:0];
        objc_setAssociatedObject(self, &TitleLabelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
}

- (UILabel *)subTitleLabel
{
    UILabel *label = objc_getAssociatedObject(self, &SubTitleLabelKey);
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        [self.centerView insertSubview:label atIndex:1];
        objc_setAssociatedObject(self, &SubTitleLabelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
}

- (UIView *)centerView
{
    UIView *view = objc_getAssociatedObject(self, &CenterViewKey);
    if (!view) {
        if (self.navigationItem.titleView) {
            return nil;
        }
        if (self.navigationItem.titleView == nil) {
            self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        }
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navigationItem.titleView.bounds), CGRectGetHeight(self.navigationItem.titleView.bounds))];
        [self.navigationItem.titleView addSubview:view];
        objc_setAssociatedObject(self, &CenterViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setCenterViewAlignmentNatural:(BOOL)centerViewAlignmentNatural
{
    objc_setAssociatedObject(self, &CenterViewAlignmentNaturalKey, @(centerViewAlignmentNatural), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)centerViewAlignmentNatural
{
    NSNumber *objc = objc_getAssociatedObject(self, &CenterViewAlignmentNaturalKey);
    return [objc boolValue];
}

- (void)setLeftMargin:(CGFloat)leftMargin
{
    objc_setAssociatedObject(self, &LeftMarginKey, @(leftMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)leftMargin
{
    NSNumber *objc = objc_getAssociatedObject(self, &LeftMarginKey);
    return [objc floatValue];
}

- (void)setRightMargin:(CGFloat)rightMargin
{
    objc_setAssociatedObject(self, &RightMarginKey, @(rightMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)rightMargin
{
    NSNumber *objc = objc_getAssociatedObject(self, &RightMarginKey);
    return [objc floatValue];
}

- (void)setMarginTitleToSubTitle:(CGFloat)marginTitleToSubTitle
{
    objc_setAssociatedObject(self, &MarginTitleToSubTitleKey, @(marginTitleToSubTitle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)marginTitleToSubTitle
{
    NSNumber *objc = objc_getAssociatedObject(self, &MarginTitleToSubTitleKey);
    return [objc floatValue];
}


- (void)setHiddenBack:(BOOL)hiddenBack
{
    objc_setAssociatedObject(self, &RightMarginKey, @(hiddenBack), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hiddenBack
{
    NSNumber *objc = objc_getAssociatedObject(self, &HiddenBackKey);
    return [objc boolValue];
}

- (void)setNavigationBarSeparatorLineHidden:(BOOL)navigationBarSeparatorLineHidden
{
    objc_setAssociatedObject(self, &NavigationBarSeparatorLineHiddenKey, @(navigationBarSeparatorLineHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)navigationBarSeparatorLineHidden
{
    NSNumber *objc = objc_getAssociatedObject(self, &NavigationBarSeparatorLineHiddenKey);
    return [objc boolValue];
}

- (UIView *)navigationBarSeparatorLine
{
    UIView *separatorLine = [self.navigationController.navigationBar viewWithTag:1002];
    if (!separatorLine) {
        separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.bounds) - 0.5, CGRectGetWidth(self.navigationController.navigationBar.bounds), 0.5)];
        separatorLine.tag = 1002;
        [self.navigationController.navigationBar addSubview:separatorLine];
    }
    return separatorLine;
}

- (UIImageView *)navigationBarExtendLayoutView
{
    UIImageView *barExtendLayoutView = [self.navigationController.navigationBar viewWithTag:1001];
    if (!barExtendLayoutView) {
        barExtendLayoutView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.navigationController.navigationBar.bounds), CGRectGetHeight(self.navigationController.navigationBar.bounds) + 20)];
        barExtendLayoutView.tag = 1001;
        [self.navigationController.navigationBar insertSubview:barExtendLayoutView atIndex:0];
    }
    return barExtendLayoutView;
}

- (void)setShowNavigationBarSeparatorLine:(BOOL)showNavigationBarSeparatorLine
{
    self.navigationBarSeparatorLine.hidden = showNavigationBarSeparatorLine;
}

- (void)setNavigationBarSeparatorLineWidth:(CGFloat)navigationBarSeparatorLineWidth
{
    CGRect rect = self.navigationBarSeparatorLine.frame;
    rect.size.width = navigationBarSeparatorLineWidth;
    self.navigationBarSeparatorLine.frame = rect;
}

- (void)setNavigationBarSeparatorLineHeight:(CGFloat)navigationBarSeparatorLineHeight
{
    CGRect rect = self.navigationBarSeparatorLine.frame;
    rect.size.height = navigationBarSeparatorLineHeight;
    self.navigationBarSeparatorLine.frame = rect;
}

- (BOOL)navigationBarTransparentGradient
{
    NSNumber *objc = objc_getAssociatedObject(self, &NavigationBarTransparentGradientKey);
    return [objc boolValue];
}

- (void)setNavigationBarTransparentGradient:(BOOL)navigationBarTransparentGradient
{
    objc_setAssociatedObject(self, &NavigationBarTransparentGradientKey, @(navigationBarTransparentGradient), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)navigationBarIsTransparent
{
    NSNumber *objc = objc_getAssociatedObject(self, &NavigationBarIsTransparentKey);
    return [objc boolValue];
}

- (void)setNavigationBarIsTransparent:(BOOL)navigationBarIsTransparent
{
    objc_setAssociatedObject(self, &NavigationBarIsTransparentKey, @(navigationBarIsTransparent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)navigationBarExtendLayoutViewAlpha
{
    NSNumber *objc = objc_getAssociatedObject(self, &NavigationBarExtendLayoutViewAlphaKey);
    return [objc floatValue];
}

- (void)setNavigationBarExtendLayoutViewAlpha:(CGFloat)alpha
{
    objc_setAssociatedObject(self, &NavigationBarExtendLayoutViewAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)navigationBarTintColor
{
    return objc_getAssociatedObject(self, &NavigationBarTintColorKey);
}

- (void)setNavigationBarTintColor:(UIColor *)navigationBarTintColor
{
    objc_setAssociatedObject(self, &NavigationBarTintColorKey, navigationBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.navigationController.navigationBar.barTintColor = navigationBarTintColor;
}

- (UIImage *)navigationBarImageClear
{
    UIImage *image = objc_getAssociatedObject(self, &NavigationBarImageClearKey);
    if (!image) {
        CGRect rect = CGRectMake(0, -20, CGRectGetWidth(self.navigationController.navigationBar.bounds), CGRectGetWidth(self.navigationController.navigationBar.bounds) + 20);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, rect);
        image = UIGraphicsGetImageFromCurrentImageContext();
        objc_setAssociatedObject(self, &NavigationBarImageClearKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return image;
}


- (UIImage *)navigationBarImage
{
    return objc_getAssociatedObject(self, &NavigationBarImageKey);
}

- (void)setNavigationBarImage:(UIImage *)navigationBarImage
{
    objc_setAssociatedObject(self, &NavigationBarImageKey, navigationBarImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)navigationBarTransparentOffsetY
{
    NSNumber *objc = objc_getAssociatedObject(self, &NavigationBarTransparentOffsetYKey);
    return [objc floatValue];
}

- (void)setNavigationBarTransparentOffsetY:(CGFloat)navigationBarTransparentOffsetY
{
    objc_setAssociatedObject(self, &NavigationBarTransparentOffsetYKey, @(navigationBarTransparentOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CGFloat alpha = 0;
    CGFloat p = (self.navigationBarTransparentMaxOffsetY * self.navigationBarTransparentMaxOffsetY)/(2 * self.navigationBarTransparentMaxOffsetY);
    if (navigationBarTransparentOffsetY <= 0) {
        alpha = 0;
    }
    else if (navigationBarTransparentOffsetY <= self.navigationBarTransparentMaxOffsetY) {
        alpha = sqrtf(2 * p * navigationBarTransparentOffsetY)/self.navigationBarTransparentMaxOffsetY;
    }
    else {
        alpha = 1;
    }
    if (!self.navigationBarTransparentGradient) {
        alpha = alpha < 1?0:1;
    }
    [self setNavigationBarExtendLayoutViewAlpha:alpha];
    [self translucentBar:YES alpha:alpha];
}

- (CGFloat)navigationBarTransparentMaxOffsetY
{
    NSNumber *objc = objc_getAssociatedObject(self, &NavigationBarTransparentMaxOffsetYKey);
    return [objc floatValue];
}

- (void)setNavigationBarTransparentMaxOffsetY:(CGFloat)navigationBarTransparentMaxOffsetY
{
    objc_setAssociatedObject(self, &NavigationBarTransparentMaxOffsetYKey, @(navigationBarTransparentMaxOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Private Methods

- (void)adjustTitle
{
    CGFloat width = CGRectGetWidth(self.centerView.bounds);
    CGFloat height = CGRectGetHeight(self.centerView.bounds);
    CGFloat margin = self.marginTitleToSubTitle;
    
    CGFloat tH = 100;
    CGFloat subH = 23;
    CGFloat lH = tH + subH + margin;
    CGRect rect = self.titleLabel.frame;
    rect = CGRectMake(0, (height - lH)/2.f, width, tH);
    self.titleLabel.frame = rect;
    
    rect = self.subTitleLabel.frame;
    rect = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + margin, width, subH);
    self.subTitleLabel.frame = rect;
}


#pragma mark - Public Methods

- (void)extendedLayoutBar:(BOOL)yesOrNo
{
    if (yesOrNo) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.navigationController.navigationBar.translucent = YES;
    }
    else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.navigationController.navigationBar.translucent = NO;
    }
}

- (void)translucentBar:(BOOL)yesOrNo
{
    [self translucentBar:yesOrNo alpha:[self navigationBarExtendLayoutViewAlpha]];
}

- (void)translucentBar:(BOOL)yesOrNo alpha:(CGFloat)alpha
{
    if (yesOrNo) {
        self.navigationController.navigationBar.layer.masksToBounds = alpha == 0?YES:NO;
        [self.navigationController.navigationBar setBackgroundImage:[self navigationBarImageClear] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].keyWindow.backgroundColor = self.navigationBarTintColor;
        self.navigationBarSeparatorLine.hidden = self.navigationBarSeparatorLineHidden;
        self.navigationBarSeparatorLine.alpha = alpha;
    }
    else {
        self.navigationController.navigationBar.layer.masksToBounds = NO;
        [self.navigationController.navigationBar setBackgroundImage:[self navigationBarImage] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor blackColor];
        self.navigationBarSeparatorLine.hidden = self.navigationBarSeparatorLineHidden;
        self.navigationBarSeparatorLine.alpha = 1;
    }
    self.navigationBarIsTransparent = alpha == 1?NO:YES;
    self.navigationBarExtendLayoutView.alpha = alpha;
    self.navigationBarExtendLayoutView.hidden = !yesOrNo;
    
}




- (void)setBackBarButtonItemWithImage:(UIImage *)image withTitle:(NSString *)title withLeftItemsSupplementBackButton:(BOOL)yesOrNo
{
    [self.navigationItem setLeftItemsSupplementBackButton:yesOrNo];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] init];
    back.title = title?title : @"";
    [back setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = back;
}

- (void)setBackBarButtonItemCustomWithImage:(UIImage *)image
{
}

- (void)setRightBarButtonItems:(NSArray *)rightBarButtonItems withRightMargin:(CGFloat)margin
{
    if (!rightBarButtonItems) {
        self.navigationItem.rightBarButtonItems = nil;
        self.rightMargin = margin;
    }
    else {
        self.rightMargin = margin + (rightBarButtonItems.count - 1) * 10;
        NSMutableArray *arrs = [NSMutableArray arrayWithArray:rightBarButtonItems];
        [arrs insertObject:[self getFixBarItemWithFix:margin] atIndex:0];
        self.navigationItem.rightBarButtonItems = arrs;
    }
}

- (void)setLeftBarButtonItems:(NSArray *)leftBarButtonItems withLeftMargin:(CGFloat)margin
{
    if (!leftBarButtonItems) {
        self.navigationItem.rightBarButtonItems = nil;
        self.leftMargin = margin;
    }
    else {
        self.leftMargin = margin + (leftBarButtonItems.count - 1) * 10;
        NSMutableArray *arrs = [NSMutableArray arrayWithArray:leftBarButtonItems];
        [arrs insertObject:[self getFixBarItemWithFix:margin] atIndex:0];
        self.navigationItem.leftBarButtonItems = arrs;
    }
}

- (UIBarButtonItem *)getFixBarItemWithFix:(CGFloat)fix
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item.width = fix - 15;
    return item;
}


- (void)setNavigationTitleView:(void(^)(UILabel *label))setting
{
    if (setting) {
        setting(self.titleLabel);
    }
}

- (void)setNavigationCenterCustomView:(UIView *)view
{
    [self setNavigationCenterCustomView:view adjustCenterView:NO];
}

- (void)setNavigationCenterCustomView:(UIView *)view adjustCenterView:(BOOL)yesOrNo
{
    if (view) {
        for (UIView *view in self.centerView.subviews) {
            if (view != self.titleLabel) {
                [view removeFromSuperview];
            }
        }
        self.titleLabel.hidden = YES;
        view.tag = 10001;
        [self.centerView addSubview:view];
        objc_setAssociatedObject(self, &CustomViewAdjustCenter, @(yesOrNo), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (yesOrNo) {
            CGFloat width1 = CGRectGetWidth(self.centerView.bounds);
            CGFloat height1 = CGRectGetHeight(self.centerView.bounds);
            CGRect rect = view.frame;
            rect = CGRectMake(0, 0, width1, height1);
            view.frame = rect;
        }
        else {

            CGFloat width1 = CGRectGetWidth(self.centerView.bounds);
            CGFloat height1 = CGRectGetHeight(self.centerView.bounds);
            CGFloat width2 = CGRectGetWidth(view.bounds);
            CGFloat height2 = CGRectGetHeight(view.bounds);
            CGRect rect = view.frame;
            rect = CGRectMake((width1 - width2)/2.f, (height1 - height2)/2.f, width2, height2);
            view.frame = rect;
        }
    }
    else {
        for (UIView *view in self.centerView.subviews) {
            if (view != self.titleLabel) {
                [view removeFromSuperview];
            }
        }
        self.titleLabel.hidden = NO;
    }
}

#pragma mark - Need Override

//override
- (void)setNavigationBarItem
{
    
}

- (void)prohibitClickWhenRequest:(BOOL)yesOrNO
{
    
}





#pragma mark - hidden or show backItem


- (void)showBackItem
{
    
}

- (void)hiddenBackItem
{
    
}

- (void)didBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end


