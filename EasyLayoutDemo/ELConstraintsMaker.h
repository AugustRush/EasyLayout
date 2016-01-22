//
//  ELCondtraintsMaker.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ELLayoutConstraint.h"
#import <UIKit/UIKit.h>

@interface ELConstraintsMaker : NSObject

@property(nonatomic, readonly) ELLayoutConstraint *EL_left;
@property(nonatomic, readonly) ELLayoutConstraint *EL_right;
@property(nonatomic, readonly) ELLayoutConstraint *EL_top;
@property(nonatomic, readonly) ELLayoutConstraint *EL_bottom;
@property(nonatomic, readonly) ELLayoutConstraint *EL_centerX;
@property(nonatomic, readonly) ELLayoutConstraint *EL_centerY;
@property(nonatomic, readonly) ELLayoutConstraint *EL_width;
@property(nonatomic, readonly) ELLayoutConstraint *EL_height;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithView:(UIView *)view;

- (void)install;
- (void)removeAll;
- (void)updateOrInstall;
@end
