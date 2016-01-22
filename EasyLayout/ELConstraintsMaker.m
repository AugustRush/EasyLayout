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
  NSHashTable<ELLayoutConstraintModel *> *_models;
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
  for (ELLayoutConstraintModel *model in _models) {
    NSLayoutConstraint *constraint =
        [NSLayoutConstraint constraintWithItem:model.view
                                     attribute:model.attribute
                                     relatedBy:model.relation
                                        toItem:model.toView
                                     attribute:model.toAttribute
                                    multiplier:model.ratio
                                      constant:model.constant];
    [constraint setActive:YES];
    [_constraints addObject:constraint];
  }
}

- (void)removeAll {
  [_models removeAllObjects];
  [NSLayoutConstraint deactivateConstraints:_constraints.allObjects];
}

#pragma mark - properties methods

- (ELLayoutConstraintModel *)EL_left {
  ELLayoutConstraintModel *constraint = _view.EL_left;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraintModel *)EL_right {
  ELLayoutConstraintModel *constraint = _view.EL_right;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraintModel *)EL_top {
  ELLayoutConstraintModel *constraint = _view.EL_top;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraintModel *)EL_bottom {
  ELLayoutConstraintModel *constraint = _view.EL_bottom;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraintModel *)EL_centerX {
  ELLayoutConstraintModel *constraint = _view.EL_centerX;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraintModel *)EL_centerY {
  ELLayoutConstraintModel *constraint = _view.EL_centerY;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraintModel *)EL_width {
  ELLayoutConstraintModel *constraint = _view.EL_width;
  [_models addObject:constraint];
  return constraint;
}

- (ELLayoutConstraintModel *)EL_height {
  ELLayoutConstraintModel *constraint = _view.EL_height;
  [_models addObject:constraint];
  return constraint;
}

@end
