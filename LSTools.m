//
//  LSTools.m
//  SchoolMakeUp
//
//  Created by 木木木公 on 2017/4/1.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LSTools.h"

@implementation LSTools

+ (UIView *)getlineView:(UIColor *)color {
    UIView * view        = [[UIView alloc]init];
    view.backgroundColor = color;
    return view;
}

+ (UILabel *)getlbl:(UIFont*)size :(UIColor *)color {
    UILabel * lbl = [[UILabel alloc]init];
    lbl.font      = size;
    lbl.textColor = color;
    return lbl;
}

@end
