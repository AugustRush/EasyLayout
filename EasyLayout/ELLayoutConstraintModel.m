//
//  ELLayoutConstraintModel.m
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ELConstraintsMaker.h"
#import "ELLayoutConstraintModel.h"

@implementation ELLayoutConstraintModel {
  __weak NSLayoutConstraint *_constraint;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _constant = 0;
        _ratio = 1;
        _toView = nil;
        _toAttribute = NSLayoutAttributeNotAnAttribute;
        _priorityLevel = 1000;
    }
    return self;
}

- (void)dealloc {
  NSLog(@"temple dealloc");
}

#pragma mark - private methods

- (BOOL)needRelativeToSuper {
  // width or height not auto relative to superView
  return (_attribute != NSLayoutAttributeWidth &&
          _attribute != NSLayoutAttributeHeight);
}

- (void)configurationWithSupportType:(id)supportType
                            relation:(NSLayoutRelation)relation {
  _relation = relation;
  if ([supportType isKindOfClass:[UIView class]]) {
    _toView = supportType;
    _toAttribute = _attribute;
  } else if ([supportType isKindOfClass:[NSNumber class]]) {
    if ([self needRelativeToSuper]) { // if attribute is width or height , this
                                      // should not be relative to superView
                                      // unless sepecific
      _toView = _view.superview;
      _toAttribute = _attribute;
    }
    _constant = [supportType floatValue];
  } else if ([supportType isKindOfClass:[ELLayoutConstraintModel class]]) {
    ELLayoutConstraintModel *model = (ELLayoutConstraintModel *)supportType;
    _toView = model.view;
    _toAttribute = model.attribute;
  } else {
    NSAssert(0, @"unsupport this type!");
  }
}

- (NSLayoutConstraint *)__constraint {
  if (_constraint == nil) {
    _constraint = [NSLayoutConstraint constraintWithItem:_view
                                               attribute:_attribute
                                               relatedBy:_relation
                                                  toItem:_toView
                                               attribute:_toAttribute
                                              multiplier:_ratio
                                                constant:_constant];
      _constraint.priority = _priorityLevel;
  }
  return _constraint;
}

- (BOOL)isEqual:(id)object {
  return NO;
}

#pragma mark - public methods

- (ELLayoutLinkerBlock)equalTo {
  return ^ELLayoutConstraintModel *(id supportType) {
    [self configurationWithSupportType:supportType
                              relation:NSLayoutRelationEqual];
    return self;
  };
}

- (ELLayoutLinkerBlock)greaterThanOrEqualTo {
  return ^ELLayoutConstraintModel *(id supportType) {
    [self configurationWithSupportType:supportType
                              relation:NSLayoutRelationGreaterThanOrEqual];

    return self;
  };
}

- (ELLayoutLinkerBlock)lessThanOrEqualTo {
  return ^ELLayoutConstraintModel *(id supportType) {
    [self configurationWithSupportType:supportType
                              relation:NSLayoutRelationLessThanOrEqual];
    return self;
  };
}

- (ELLayoutMultiplierBlock)multiplier {
  return ^(CGFloat multiplier) {
    _ratio *= multiplier;
    return self;
  };
}

- (ELLayoutOffsetBlock)offset {
  return ^(CGFloat offset) {
    _constant += offset;
    return self;
  };
}

- (ELLayoutPriorityBlock)priority {
    return ^(CGFloat level){
        _priorityLevel = level;
        return self;
    };
}

- (ELLayoutConstraintReturnBlock)constraint {
  return ^{
    return [self __constraint];
  };
}

@end
