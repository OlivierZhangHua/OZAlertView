//
//  OZHelper.h
//  OZHelper
//
//  Created by Olivier on 15/11/20.
//  Copyright © 2015年 Olivier. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface OZHelper : NSObject

/**
 字符串文字的长度
 */
+(CGFloat)widthOfString:(NSString *)string font:(UIFont*)font height:(CGFloat)height;

/**
 字符串文字的高度
 */
+(CGFloat)heightOfString:(NSString *)string font:(UIFont*)font width:(CGFloat)width;
@end
