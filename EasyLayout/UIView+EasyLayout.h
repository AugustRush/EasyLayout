//
//  UIView+EasyLayout.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ELConstraintsMaker.h"
#import "ELLayoutConstraintModel.h"
#import <UIKit/UIKit.h>

@interface UIView (EasyLayout)

@property(nonatomic, readonly) ELLayoutConstraintModel *EL_left;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_right;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_top;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_bottom;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_centerX;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_centerY;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_width;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_height;

- (void)ELContraintsMake:(void (^)(ELConstraintsMaker *make))block;
- (void)ELContraintsRemake:(void (^)(ELConstraintsMaker *make))block;
- (void)ELContraintsUpdate:(void (^)(ELConstraintsMaker *))block;

@end
