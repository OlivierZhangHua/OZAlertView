//
//  OZAlertView.h
//  HappyKangaroo
//
//  Created by Olivier on 16/3/3.
//  Copyright © 2016年 Olivier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol OZAlertViewDelegate <NSObject>

@optional
// 点击按钮下标时传递参数
- (void)didSelectVerticalAlertButton:(NSString *)title;
- (void)didSelectHorizontalAlertButton:(NSString *)title;
@end

@interface OZAlertView : NSObject

@property (nonatomic,weak) id <OZAlertViewDelegate> delegate;

/**
 *单例
 */
+ (instancetype)shareInstance;

/**
 *快速竖直创建提示框
 */
- (UIView *)quickVerticalAlertViewWithArray:(NSArray *)array;

/**
 *快速横向创建提示框
 */
- (UIView *)quickHorizontalAlertViewTitle:(NSString *)title Content:(NSString *)content ButtonTitles:(NSArray *)buttonTitles;
@end
