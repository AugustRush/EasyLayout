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

typedef NS_ENUM(NSUInteger, ELAttribute) {
  ELAttributeLeft,
  ELAttributeRight,
  ELAttributeTop,
  ELAttributeBottom,
  ELAttributeWidth,
  ELAttributeHeight,
  ELAttributeCenterX,
  ELAttributeCenterY
};

@implementation ELConstraintsMaker {
  __weak UIView *_view;
  NSMutableDictionary<NSString *, ELLayoutConstraintModel *> *_models;
  NSHashTable<ELLayoutConstraintModel *> *_updateModels;
  NSHashTable<NSLayoutConstraint *> *_constraints;
}

#pragma mark - life cycle methods

- (instancetype)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    _view = view;
    _models = @{}.mutableCopy;
    _updateModels = [NSHashTable weakObjectsHashTable];
    _constraints = [NSHashTable weakObjectsHashTable];
  }
  return self;
}

- (void)dealloc {
  NSLog(@"test maker dealloc");
}

#pragma mark - public methods

- (void)install {
  for (ELLayoutConstraintModel *model in _models.allValues) {
    NSLayoutConstraint *constraint = model.constraint();
    [constraint setActive:YES];
    [_constraints addObject:constraint];
  }
}

- (void)removeAll {
  [_models removeAllObjects];
  [NSLayoutConstraint deactivateConstraints:_constraints.allObjects];
}

- (void)update {
  for (ELLayoutConstraintModel *model in _updateModels) {
    NSString *identifier = [self identifierWithModel:model];
    ELLayoutConstraintModel *existingModel = _models[identifier];
    if (existingModel != nil) {
        //reference view and ratio should be same
      if (model.toView == existingModel.toView &&
          model.ratio == existingModel.ratio) {
        existingModel.constraint().constant = model.constant;
      } else {
        // remove exsiting and install new
        [existingModel.constraint() setActive:NO];
        [self installConstraintWithModel:model identifier:identifier];
      }
    } else {
      [self installConstraintWithModel:model identifier:identifier];
    }
  }
}

- (void)installConstraintWithModel:(ELLayoutConstraintModel *)model
                        identifier:(NSString *)identifier {
  NSLayoutConstraint *constraint = model.constraint();
  [constraint setActive:YES];
  _models[identifier] = model;
  [_constraints addObject:constraint];
}

#pragma mark - properties methods

- (ELLayoutConstraintModel *)EL_left {
  return [self modelWithAttribute:ELAttributeLeft];
}

- (ELLayoutConstraintModel *)EL_right {
  return [self modelWithAttribute:ELAttributeRight];
}

- (ELLayoutConstraintModel *)EL_top {
  return [self modelWithAttribute:ELAttributeTop];
}

- (ELLayoutConstraintModel *)EL_bottom {
  return [self modelWithAttribute:ELAttributeBottom];
}

- (ELLayoutConstraintModel *)EL_centerX {
  return [self modelWithAttribute:ELAttributeCenterX];
}

- (ELLayoutConstraintModel *)EL_centerY {
  return [self modelWithAttribute:ELAttributeCenterY];
}

- (ELLayoutConstraintModel *)EL_width {
  return [self modelWithAttribute:ELAttributeWidth];
}

- (ELLayoutConstraintModel *)EL_height {
  return [self modelWithAttribute:ELAttributeHeight];
}

#pragma mark - private methods

- (ELLayoutConstraintModel *)modelWithAttribute:(ELAttribute)attribute {
  ELLayoutConstraintModel *model = nil;
  switch (attribute) {
  case ELAttributeLeft: {
    model = _view.EL_left;
    break;
  }
  case ELAttributeRight: {
    model = _view.EL_right;
    break;
  }
  case ELAttributeTop: {
    model = _view.EL_top;
    break;
  }
  case ELAttributeBottom: {
    model = _view.EL_bottom;
    break;
  }
  case ELAttributeWidth: {
    model = _view.EL_width;
    break;
  }
  case ELAttributeHeight: {
    model = _view.EL_height;
    break;
  }
  case ELAttributeCenterX: {
    model = _view.EL_centerX;
    break;
  }
  case ELAttributeCenterY: {
    model = _view.EL_centerY;
    break;
  }
  }
  if (model) {
    if (self.isUpdating) {
      [_updateModels addObject:model];
    } else {
      [_models setObject:model forKey:[self identifierWithModel:model]];
    }
  }
  return model;
}

- (NSString *)identifierWithModel:(ELLayoutConstraintModel *)model {
  NSMutableString *string = [NSMutableString string];
  [string appendFormat:@"%p/", model.view];
  [string appendFormat:@"%ld/", (long)model.attribute];
    //if relation is equal, this should be only one on common
  if (model.relation != NSLayoutRelationEqual) {
    [string appendFormat:@"%ld/", (long)model.relation];
    [string appendFormat:@"%p/", model.toView];
    [string appendFormat:@"%ld/", (long)model.toAttribute];
  }
  return string.copy;
}

@end
