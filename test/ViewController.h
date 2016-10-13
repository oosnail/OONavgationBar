//
//  ViewController.h
//  test
//
//  Created by ztc on 16/9/21.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (int, UINavigationStatus) {
    UINavigationStatusNomal,
    UINavigationStatusAlpha,
    UINavigationStatusHiden,
};

@interface ViewController : UIViewController

- (id)initWithUINavigationStatus:(UINavigationStatus)status;

@end

