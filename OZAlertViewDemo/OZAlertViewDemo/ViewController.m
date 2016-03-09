//
//  ViewController.m
//  OZAlertViewDemo
//
//  Created by Olivier on 16/3/9.
//  Copyright © 2016年 Olivier. All rights reserved.
//

#import "ViewController.h"
#import "OZAlertView.h"

static NSString *const Title = @"Hellow World~";
static NSString *const content = @"Hellow World~Hellow World~";
static NSString *const btnTitle1 = @"btn1";
static NSString *const btnTitle2 = @"btn2";
static NSString *const btnTitle3 = @"btn3";

@interface ViewController () <OZAlertViewDelegate>
@property (nonatomic, strong) UIView *alert;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createOZHorizontalAlertView];
    //[self createOZVerticalAlertView];
    [self alertViewShow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - OZAlertViewDelegate
- (void)didSelectHorizontalAlertButton:(NSString *)title {
    [self alertViewHide];
}

- (void)didSelectVerticalAlertButton:(NSString *)title {
    [self alertViewHide];
}

#pragma mark -
- (void)createOZHorizontalAlertView {
    self.alert = [[OZAlertView shareInstance] quickHorizontalAlertViewTitle:Title
                                                                    Content:content
                                                               ButtonTitles:@[btnTitle1,btnTitle2]];
    [self.view addSubview:self.alert];
}

- (void)createOZVerticalAlertView {
    self.alert = [[OZAlertView shareInstance] quickVerticalAlertViewWithArray:@[content,btnTitle1,btnTitle2,btnTitle3]];
    
    [self.view addSubview:self.alert];
}

- (void)alertViewShow {
    self.alert.hidden = NO;
    [UIView animateWithDuration:0.35 animations:^{
        self.alert.alpha = 1;
    }];
}

- (void)alertViewHide {
    [UIView animateWithDuration:0.35 animations:^{
        self.alert.alpha = 0;
    } completion:^(BOOL finished) {
        self.alert.hidden = YES;
        [self.alert removeFromSuperview];
    }];
}

@end
