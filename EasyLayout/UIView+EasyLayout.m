//
//  UIView+EasyLayout.m
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "UIView+EasyLayout.h"
#import <objc/runtime.h>

@implementation UIView (EasyLayout)

#pragma mark - attributes 

- (ELLayoutConstraintModel *)EL_left {
  return [self constraintWithAttribute:NSLayoutAttributeLeft];
}

- (ELLayoutConstraintModel *)EL_right {
  return [self constraintWithAttribute:NSLayoutAttributeRight];
}

- (ELLayoutConstraintModel *)EL_top {
  return [self constraintWithAttribute:NSLayoutAttributeTop];
}

- (ELLayoutConstraintModel *)EL_bottom {
  return [self constraintWithAttribute:NSLayoutAttributeBottom];
}

- (ELLayoutConstraintModel *)EL_centerX {
  return [self constraintWithAttribute:NSLayoutAttributeCenterX];
}

- (ELLayoutConstraintModel *)EL_centerY {
  return [self constraintWithAttribute:NSLayoutAttributeCenterY];
}

- (ELLayoutConstraintModel *)EL_width {
  return [self constraintWithAttribute:NSLayoutAttributeWidth];
}

- (ELLayoutConstraintModel *)EL_height {
  return [self constraintWithAttribute:NSLayoutAttributeHeight];
}

- (ELLayoutConstraintModel *)EL_leading {
    return [self constraintWithAttribute:NSLayoutAttributeLeading];
}

- (ELLayoutConstraintModel *)EL_trailing {
    return [self constraintWithAttribute:NSLayoutAttributeTrailing];
}

- (ELLayoutConstraintModel *)EL_baseline {
    return [self constraintWithAttribute:NSLayoutAttributeBaseline];
}

- (ELLayoutConstraintModel *)EL_firstBaseline {
    return [self constraintWithAttribute:NSLayoutAttributeFirstBaseline];
}

- (ELLayoutConstraintModel *)EL_lastBaseline {
    return [self constraintWithAttribute:NSLayoutAttributeLastBaseline];
}

- (ELLayoutConstraintModel *)EL_leftMargin {
    return [self constraintWithAttribute:NSLayoutAttributeLeftMargin];
}

- (ELLayoutConstraintModel *)EL_rightMargin {
    return [self constraintWithAttribute:NSLayoutAttributeRightMargin];
}

-(ELLayoutConstraintModel *)EL_topMargin {
    return [self constraintWithAttribute:NSLayoutAttributeTopMargin];
}

- (ELLayoutConstraintModel *)EL_bottomMargin {
    return [self constraintWithAttribute:NSLayoutAttributeBottomMargin];
}

- (ELLayoutConstraintModel *)EL_leadingMargin {
    return [self constraintWithAttribute:NSLayoutAttributeLeadingMargin];
}

- (ELLayoutConstraintModel *)EL_trailingMargin {
    return [self constraintWithAttribute:NSLayoutAttributeTrailingMargin];
}

- (ELLayoutConstraintModel *)EL_centerXWithMargins {
    return [self constraintWithAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (ELLayoutConstraintModel *)EL_centerYWithMargins {
    return [self constraintWithAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#pragma mark - private methods

- (ELLayoutConstraintModel *)constraintWithAttribute:(NSLayoutAttribute)attribute {
    ELLayoutConstraintModel *constraint = [ELLayoutConstraintModel new];
    constraint.view = self;
    constraint.attribute = attribute;
    return constraint;
}

- (ELConstraintsMaker *)ELMaker {
    ELConstraintsMaker *maker = objc_getAssociatedObject(self, _cmd);
    if (maker == nil) {
        maker = [[ELConstraintsMaker alloc] initWithView:self];
        objc_setAssociatedObject(self, _cmd, maker,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return maker;
}

#pragma mark - public methods

- (void)makeConstraints:(void (^)(ELConstraintsMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    ELConstraintsMaker *maker = [self ELMaker];
    maker.isUpdating = NO;
    block(maker);
    [maker install];
}

- (void)remakeConstraints:(void (^)(ELConstraintsMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    ELConstraintsMaker *maker = [self ELMaker];
    maker.isUpdating = NO;
    [maker removeAll];
    block(maker);
    [maker install];
}

- (void)updateConstraints:(void (^)(ELConstraintsMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    ELConstraintsMaker *maker = [self ELMaker];
    maker.isUpdating = YES;
    block(maker);
    [maker update];
}

@end
