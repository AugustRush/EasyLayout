//
//  ELCondtraintsMaker.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ELLayoutConstraintModel.h"
#import <UIKit/UIKit.h>

@interface ELConstraintsMaker : NSObject

@property(nonatomic, readonly) ELLayoutConstraintModel *EL_left;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_right;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_top;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_bottom;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_centerX;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_centerY;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_width;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_height;

@property(nonatomic, assign) BOOL isUpdating;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithView:(UIView *)view;

- (void)install;
- (void)removeAll;
- (void)update;

@end
