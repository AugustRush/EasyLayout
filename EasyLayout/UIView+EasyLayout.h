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
#import "ELLayoutAttributeProtocol.h"

@interface UIView (EasyLayout)<ELLayoutAttributeProtocol>

- (void)makeConstraints:(void (^)(ELConstraintsMaker *make))block;
- (void)remakeConstraints:(void (^)(ELConstraintsMaker *make))block;
- (void)updateConstraints:(void (^)(ELConstraintsMaker *make))block;

@end
