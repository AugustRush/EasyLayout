//
//  ELLayoutConstraint.m
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ELConstraintsMaker.h"
#import "ELLayoutConstraint.h"

@implementation ELLayoutConstraint

- (instancetype)init {
  self = [super init];
  if (self) {
    _constant = 0;
    _ratio = 1;
    _toView = nil;
    _toAttribute = NSLayoutAttributeNotAnAttribute;
  }
  return self;
}

#pragma mark - private methods

- (BOOL)needRelativeToSuper {
  // width or height not auto relative to superView
  return (_attribute != NSLayoutAttributeWidth &&
          _attribute != NSLayoutAttributeHeight);
}

- (void)configurationWithViewOrNumber:(id)viewOrNumber
                             relation:(NSLayoutRelation)relation {
  _relation = relation;
  _toAttribute = _attribute;
  if ([viewOrNumber isKindOfClass:[UIView class]]) {
    _toView = viewOrNumber;
  } else if ([viewOrNumber isKindOfClass:[NSNumber class]]) {
    if ([self needRelativeToSuper]) { // if attribute is width or height , this
                                      // should not be relative to superView
                                      // unless sepecific
      _toView = _view.superview;
      _toAttribute = _attribute;
    }
    _constant = [viewOrNumber floatValue];
  } else {
    NSLog(@"paramater is error");
  }
}

#pragma mark - public methods

- (ELLayoutLinkerBlock)equalTo {
  return ^ELLayoutConstraint *(id viewOrNumber) {
    [self configurationWithViewOrNumber:viewOrNumber
                               relation:NSLayoutRelationEqual];
    return self;
  };
}

- (ELLayoutLinkerBlock)greaterThanOrEqualTo {
  return ^ELLayoutConstraint *(id viewOrNumber) {
    [self configurationWithViewOrNumber:viewOrNumber
                               relation:NSLayoutRelationGreaterThanOrEqual];

    return self;
  };
}

- (ELLayoutLinkerBlock)lessThanOrEqualTo {
  return ^ELLayoutConstraint *(id viewOrNumber) {
    [self configurationWithViewOrNumber:viewOrNumber
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

- (BOOL)isEqual:(id)object {
    return NO;
}

- (void)dealloc {
  NSLog(@"temple dealloc");
}

@end
