//
//  OZAlertView.m
//  HappyKangaroo
//
//  Created by Olivier on 16/3/3.
//  Copyright © 2016年 Olivier. All rights reserved.
//

#import "OZAlertView.h"
#import "OZHelper.h"

@implementation OZAlertView

+ (instancetype)shareInstance {
    static OZAlertView *alert;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alert = [[OZAlertView alloc] init];
    });
    return alert;
}

- (UIView *)quickVerticalAlertViewWithArray:(NSArray *)array {
    
    UIView *groundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    groundView.alpha = 0;
    groundView.hidden = YES;
    groundView.backgroundColor = [UIColor clearColor];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.5;
    [groundView addSubview:backgroundView];
    
    CGFloat buttonH = 61;
    CGFloat buttonW = 250;
    
    // 通过数组长度创建view的高
    UIView *alert = [[UIView alloc] initWithFrame:CGRectMake(0, 0,buttonW, array.count*buttonH)];
    // 切圆角
    alert.layer.masksToBounds = YES;
    alert.layer.cornerRadius = 10;
    alert.center = groundView.center;
    [groundView addSubview:alert];
    
    for (int i = 0; i < array.count; i++) {
        // 因为有一条分割线 所以最下面是一层view
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i*buttonH, buttonW, buttonH)];
        view.backgroundColor = [UIColor whiteColor];
        
        //创建button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 0, buttonW, buttonH);
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        
        [button addTarget:self action:@selector(verticalAlertAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        CGFloat height = [OZHelper heightOfString:array[0] font:[UIFont systemFontOfSize:17] width:buttonW - 20];
        
        //设置修改Frame
        if (height > buttonH) {
            if (i == 0) {
                button.frame = CGRectMake(10, 10, buttonW - 20, height);
                
                CGRect viewFrame = view.frame;
                viewFrame.size.height = 20 + height;
                view.frame = viewFrame;
                
                CGRect alertFrame = alert.frame;
                alertFrame.size.height += view.frame.size.height - buttonH;
                alert.frame = alertFrame;
            }
            else
            {
                CGRect viewFrame = view.frame;
                viewFrame.origin.y = 20 + height;
                view.frame = viewFrame;
            }
        }
        
        //设置第一行不能点击
        if (i == 0) {
            button.userInteractionEnabled = NO;
            button.titleLabel.numberOfLines = 0;
        }
        
        //设置颜色分割线
        if (i == array.count - 1) {
            button.tintColor = [UIColor whiteColor];
            // 背景
            view.backgroundColor = [UIColor purpleColor];
        }
        else {
            button.tintColor = [UIColor purpleColor];
            // 分割线
            // 如果不是最后一行
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, buttonW, 1)];
            lineView.backgroundColor = [UIColor purpleColor];
            [view addSubview:lineView];
        }
        [alert addSubview:view];
    }
    
    return groundView;
}

- (UIView *)quickHorizontalAlertViewTitle:(NSString *)title Content:(NSString *)content ButtonTitles:(NSArray *)buttonTitles
{
    UIView *groundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    groundView.alpha = 0;
    groundView.hidden = YES;
    groundView.backgroundColor = [UIColor clearColor];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.5;
    [groundView addSubview:backgroundView];
    
    CGFloat buttonH = 61;
    CGFloat buttonW = 125;
    
    CGFloat height = [OZHelper heightOfString:content font:[UIFont systemFontOfSize:15] width:2*buttonW - 20] + 20;
    
    // 通过数组长度创建view的高
    CGFloat alertHeight = height > buttonH ? 2*buttonH + height - buttonH + 20 : 2*buttonH;
    UIView *alert = [[UIView alloc] initWithFrame:CGRectMake(0, 0,2*buttonW, alertHeight)];
    // 切圆角
    alert.layer.masksToBounds = YES;
    alert.layer.cornerRadius = 10;
    alert.center = groundView.center;
    [groundView addSubview:alert];
    
    for (int i = 0; i < 2; i++) {
        // 因为有一条分割线 所以最下面是一层view
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        if (i == 0) {
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 2*buttonW - 20, 20)];
            titleLabel.text = title;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = [UIColor purpleColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:17];
            titleLabel.backgroundColor = [UIColor whiteColor];
            [view addSubview:titleLabel];
            
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame), 2*buttonW - 20, height)];
            contentLabel.text = content;
            contentLabel.font = [UIFont systemFontOfSize:15];
            contentLabel.textColor = [UIColor purpleColor];
            contentLabel.numberOfLines = 0;
            contentLabel.backgroundColor = [UIColor whiteColor];
            [view addSubview:contentLabel];
            
            view.frame = CGRectMake(0, 0, 2*buttonW, CGRectGetMaxY(contentLabel.frame)+3);
        }
        else
        {
            for (int j = 0; j < buttonTitles.count; j++) {
                //创建button
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(j*buttonW, 0, buttonW, buttonH);
                [button setTitle:buttonTitles[j] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:17];
                [button addTarget:self action:@selector(horizontalAlertAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:button];
                
                // 这里可以根据传值改变状态
                if (j == 0) {
                    button.tintColor = [UIColor whiteColor];
                    button.backgroundColor = [UIColor purpleColor];
                }
                else {
                    button.tintColor = [UIColor purpleColor];

                    // 分割线
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(buttonW, 0, buttonW, 1)];
                    lineView.backgroundColor = [UIColor purpleColor];
                    [view addSubview:lineView];
                }
            }
            
            view.frame = CGRectMake(0, height>buttonH?height:buttonH, 2*buttonW, buttonH);
        }
        [alert addSubview:view];
    }
    return groundView;
}

- (void)verticalAlertAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectVerticalAlertButton:)]) {
        [self.delegate didSelectVerticalAlertButton:sender.currentTitle];
    }
}

- (void)horizontalAlertAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectHorizontalAlertButton:)]) {
        [self.delegate didSelectHorizontalAlertButton:sender.currentTitle];
    }
}

@end
