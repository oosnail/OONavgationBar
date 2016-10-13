//
//  UINavigationBar+OOExtension.m
//  TransparentNavgationBar
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 ztc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NavigationBar self.navigationController.navigationBar

@interface UINavigationBar (ooExtension)
/**
 *  背景颜色(方式1，同一界面不能2种方式混用)
 *
 *  @param color 颜色
 */
- (void)oo_setNavigationBarBackgroundColor:(UIColor *)color;

/**
 *  透明度(方式1，同一界面不能2种方式混用)
 *
 *  @param alpha 透明度
 */
- (void)oo_setNavigationBarBackgroundAlpha:(CGFloat)alpha;


/**
 *  背景颜色(方式2，同一界面不能2种方式混用)
 *
 *  @param color color
 */
- (void)oo_setStatusBarBackgroundViewColor:(UIColor *)color;

/**
 *  透明度(方式2，同一界面不能2种方式混用)
 *
 *  @param alpha 透明度
 */
- (void)oo_setStatusBarBackgroundViewAlpha:(CGFloat)alpha;





/**
 *  整个都偏移
 *
 *  @param offsetY 偏移量
 */
- (void)oo_translationNavigationBarVerticalWithOffsetY:(CGFloat)offsetY;

/**
 *  只偏移背景视图，不移动按钮
 *
 *  @param offsetY 偏移量
 */
- (void)oo_translationBarBackgroundVerticalWithOffsetY:(CGFloat)offsetY;


/**
 *  重置还原
 */
- (void)oo_restoreNavigationBar;
@end
