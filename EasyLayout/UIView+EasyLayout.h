//
//  UIView+EasyLayout.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ELConstraintsMaker.h"
#import <UIKit/UIKit.h>
#import "ELLayoutAttributeProtocol.h"

@interface UIView (EasyLayout)<ELLayoutAttributeProtocol>

- (void)updateOrMakeConstraints:(void (^)(ELConstraintsMaker *make))block;
- (void)remakeConstraints:(void (^)(ELConstraintsMaker *make))block;
//
- (void)updateOrMakeConstraints:(void (^)(ELConstraintsMaker *))block forOrientation:(ELInterfaceOritation)orientation;
- (void)remakeConstraints:(void (^)(ELConstraintsMaker *))block forOrientation:(ELInterfaceOritation)orientation;

@end


@interface UIView (Unavalible)

- (void)makeConstraints:(void (^)(ELConstraintsMaker *make))block ELUNAVALIBLE("Please use '- (void)updateOrMakeConstraints:(void (^)(ELConstraintsMaker *make))block' replaced ! ");
- (void)updateConstraints:(void (^)(ELConstraintsMaker *make))block ELUNAVALIBLE("Please use '- (void)updateOrMakeConstraints:(void (^)(ELConstraintsMaker *make))block' replaced ! ");
@end
