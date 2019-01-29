//
//  JSSearchBarControl.m
//  test
//
//  Created by cjs on 16/8/9.
//  Copyright © 2016年 CJS. All rights reserved.
//

#import "JSSearchBarControl.h"
#import "JSSearchBar.h"

@interface JSSearchBarControl ()
@property (nonatomic, strong) JSSearchBar *searchBar;
@end

@implementation JSSearchBarControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    [self customSetting];
    return self;
}

- (void)customSetting {
    JSSearchBar *searchBar = [[JSSearchBar alloc] initWithFrame:self.bounds];
     UIColor *searchBarColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:244 / 255.0 alpha:1.0];
    searchBar.barTintColor = searchBarColor;
    self.backgroundColor = searchBarColor;
    
    UIButton    *searchButton = [[UIButton alloc] initWithFrame:self.bounds];
    [searchButton addTarget:self action:@selector(searchButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:searchBar];
    [self addSubview:searchButton];
    
    self.searchBar = searchBar;
}

- (void)searchButtonTaped {
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.searchBar.placeholder = placeholder;
}
@end
