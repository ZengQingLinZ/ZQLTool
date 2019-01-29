//
//  JSSearchBar.m
//  test
//
//  Created by cjs on 16/8/9.
//  Copyright © 2016年 CJS. All rights reserved.
//

#import "JSSearchBar.h"

@implementation JSSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customSetting];
    }
    return self;
}

- (void)customSetting {
    self.showsCancelButton = NO;
    //去掉searchBar的两条黑线
    for (UIView *obj in self.subviews) {
        for (UIView *objs in [obj subviews]) {
            if ([objs isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
                [objs removeFromSuperview];
            }
        }
        if ([obj isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
            [obj removeFromSuperview];
        }
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:219 / 255.0 green:219 / 255.0 blue:224 / 255.0 alpha:0.5];
    [self addSubview:lineView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView*view in self.subviews) {
        for (UIView*subView in view.subviews) {
            if ([subView isKindOfClass:[UITextField class]]) {
                //你想要设置的高度
                subView.frame = CGRectMake(15, 10, 225.5 , 27.5 );
            }
        }
    }
}

@end
