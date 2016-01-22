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

- (ELLayoutConstraint *)EL_left {
  return [self constraintWithAttribute:NSLayoutAttributeLeft];
}

- (ELLayoutConstraint *)EL_right {
  return [self constraintWithAttribute:NSLayoutAttributeRight];
}

- (ELLayoutConstraint *)EL_top {
  return [self constraintWithAttribute:NSLayoutAttributeTop];
}

- (ELLayoutConstraint *)EL_bottom {
  return [self constraintWithAttribute:NSLayoutAttributeBottom];
}

- (ELLayoutConstraint *)EL_centerX {
  return [self constraintWithAttribute:NSLayoutAttributeCenterX];
}

- (ELLayoutConstraint *)EL_centerY {
  return [self constraintWithAttribute:NSLayoutAttributeCenterY];
}

- (ELLayoutConstraint *)EL_width {
  return [self constraintWithAttribute:NSLayoutAttributeWidth];
}

- (ELLayoutConstraint *)EL_height {
  return [self constraintWithAttribute:NSLayoutAttributeHeight];
}

- (ELLayoutConstraint *)constraintWithAttribute:(NSLayoutAttribute)attribute {
  ELLayoutConstraint *constraint = [ELLayoutConstraint new];
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

- (void)EL_layoutMake:(void (^)(ELConstraintsMaker *))block {
  self.translatesAutoresizingMaskIntoConstraints = NO;
  ELConstraintsMaker *maker = [self ELMaker];
  block(maker);
  [maker install];
}

- (void)EL_layoutRemake:(void (^)(ELConstraintsMaker *))block {
  self.translatesAutoresizingMaskIntoConstraints = NO;
  ELConstraintsMaker *maker = [self ELMaker];
  [maker removeAll];
  block(maker);
  [maker install];
}

- (void)EL_layoutUpdate:(void (^)(ELConstraintsMaker *))block {
  self.translatesAutoresizingMaskIntoConstraints = NO;
  ELConstraintsMaker *maker = [self ELMaker];
  block(maker);
  [maker updateOrInstall];
}

@end
