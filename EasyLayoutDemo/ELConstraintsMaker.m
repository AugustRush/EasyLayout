//
//  ELCondtraintsMaker.m
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ELConstraintsMaker.h"
#import "EasyLayoutDefine.h"
#import "UIView+EasyLayout.h"

@implementation ELConstraintsMaker {
  __weak UIView *_view;
  NSHashTable<ELLayoutConstraint *> *_models;
  NSHashTable<NSLayoutConstraint *> *_constraints;
}

#pragma mark - life cycle methods

- (instancetype)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    _view = view;
    _models = [NSHashTable weakObjectsHashTable];
    _constraints = [NSHashTable weakObjectsHashTable];
  }
  return self;
}

- (void)dealloc {
  NSLog(@"test maker dealloc");
}

#pragma mark - private methods

- (void)install {
  for (ELLayoutConstraint *constraint in _models) {
    NSLayoutConstraint *con =
        [NSLayoutConstraint constraintWithItem:constraint.view
                                     attribute:constraint.attribute
                                     relatedBy:constraint.relation
                                        toItem:constraint.toView
                                     attribute:constraint.toAttribute
                                    multiplier:constraint.ratio
                                      constant:constraint.constant];
    [con setActive:YES];
    [_constraints addObject:con];
  }
}

- (void)removeAll {
  [_models removeAllObjects];
  [NSLayoutConstraint deactivateConstraints:_constraints.allObjects];
}

- (void)updateOrInstall {

}

#pragma mark - properties methods

- (ELLayoutConstraint *)EL_left {
  ELLayoutConstraint *constraint = _view.EL_left;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraint *)EL_right {
  ELLayoutConstraint *constraint = _view.EL_right;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraint *)EL_top {
  ELLayoutConstraint *constraint = _view.EL_top;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraint *)EL_bottom {
  ELLayoutConstraint *constraint = _view.EL_bottom;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraint *)EL_centerX {
  ELLayoutConstraint *constraint = _view.EL_centerX;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraint *)EL_centerY {
  ELLayoutConstraint *constraint = _view.EL_centerY;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraint *)EL_width {
  ELLayoutConstraint *constraint = _view.EL_width;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraint *)EL_height {
  ELLayoutConstraint *constraint = _view.EL_height;
  [_models addObject:constraint];
  return constraint;
}

@end
