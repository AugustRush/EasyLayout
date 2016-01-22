//
//  UIView+EasyLayout.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ELConstraintsMaker.h"
#import "ELLayoutConstraint.h"
#import <UIKit/UIKit.h>

@interface UIView (EasyLayout)

@property(nonatomic, readonly) ELLayoutConstraint *EL_left;
@property(nonatomic, readonly) ELLayoutConstraint *EL_right;
@property(nonatomic, readonly) ELLayoutConstraint *EL_top;
@property(nonatomic, readonly) ELLayoutConstraint *EL_bottom;
@property(nonatomic, readonly) ELLayoutConstraint *EL_centerX;
@property(nonatomic, readonly) ELLayoutConstraint *EL_centerY;
@property(nonatomic, readonly) ELLayoutConstraint *EL_width;
@property(nonatomic, readonly) ELLayoutConstraint *EL_height;

- (void)EL_layoutMake:(void(^)(ELConstraintsMaker *make))block;
- (void)EL_layoutRemake:(void (^)(ELConstraintsMaker *make))block;
- (void)EL_layoutUpdate:(void (^)(ELConstraintsMaker *make))block;
@end
