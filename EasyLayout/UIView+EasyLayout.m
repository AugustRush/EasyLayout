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

#pragma mark - properties

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

- (ELLayoutConstraintModel *)constraintWithAttribute:
    (NSLayoutAttribute)attribute {
  ELLayoutConstraintModel *constraint = [ELLayoutConstraintModel new];
  constraint.view = self;
  constraint.attribute = attribute;
  return constraint;
}

#pragma mark - private methods

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
