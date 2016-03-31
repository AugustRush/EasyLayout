//
//  ELCondtraintsMaker.m
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ELConstraintsMaker.h"
#import "UIView+EasyLayout.h"
#import <objc/runtime.h>

@interface UIView (ELPrivate)

- (ELLayoutConstraintModel *)constraintWithAttribute:(NSLayoutAttribute)attribute;

@end

#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation UIView (ELPrivate)
@end

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

#pragma mark - attributes

- (ELLayoutConstraintModel *)left {
  return [self modelWithAttribute:NSLayoutAttributeLeft];
}

- (ELLayoutConstraintModel *)right {
  return [self modelWithAttribute:NSLayoutAttributeRight];
}

- (ELLayoutConstraintModel *)top {
  return [self modelWithAttribute:NSLayoutAttributeTop];
}

- (ELLayoutConstraintModel *)bottom {
  return [self modelWithAttribute:NSLayoutAttributeBottom];
}

- (ELLayoutConstraintModel *)centerX {
  return [self modelWithAttribute:NSLayoutAttributeCenterX];
}

- (ELLayoutConstraintModel *)centerY {
  return [self modelWithAttribute:NSLayoutAttributeCenterY];
}

- (ELLayoutConstraintModel *)width {
  return [self modelWithAttribute:NSLayoutAttributeWidth];
}

- (ELLayoutConstraintModel *)height {
  return [self modelWithAttribute:NSLayoutAttributeHeight];
}

- (ELLayoutConstraintModel *)leading {
    return [self modelWithAttribute:NSLayoutAttributeLeading];
}

- (ELLayoutConstraintModel *)trailing {
    return [self modelWithAttribute:NSLayoutAttributeTrailing];
}

- (ELLayoutConstraintModel *)leftMargin {
    return [self modelWithAttribute:NSLayoutAttributeLeftMargin];
}

- (ELLayoutConstraintModel *)rightMargin {
    return [self modelWithAttribute:NSLayoutAttributeRightMargin];
}

- (ELLayoutConstraintModel *)topMargin {
    return [self modelWithAttribute:NSLayoutAttributeTopMargin];
}

- (ELLayoutConstraintModel *)bottomMargin {
    return [self modelWithAttribute:NSLayoutAttributeBottomMargin];
}

- (ELLayoutConstraintModel *)leadingMargin {
    return [self modelWithAttribute:NSLayoutAttributeLeadingMargin];
}

- (ELLayoutConstraintModel *)trailingMargin {
    return [self modelWithAttribute:NSLayoutAttributeTrailingMargin];
}

- (ELLayoutConstraintModel *)baseline {
    return [self modelWithAttribute:NSLayoutAttributeBaseline];
}

- (ELLayoutConstraintModel *)firstBaseline {
    return [self modelWithAttribute:NSLayoutAttributeFirstBaseline];
}

- (ELLayoutConstraintModel *)lastBaseline {
    return [self modelWithAttribute:NSLayoutAttributeLastBaseline];
}

- (ELLayoutConstraintModel *)centerXWithMargins {
    return [self modelWithAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (ELLayoutConstraintModel *)centerYWithMargins {
    return [self modelWithAttribute:NSLayoutAttributeCenterYWithinMargins];
}

- (ELLayoutCombinationConstraintModel *)allEdges {
    return self.combination(@[ELTop,ELLeft,ELBottom,ELRight]);
}

- (ELLayoutCombinationConstraintModel *)size {
    return self.combination(@[ELWidth,ELHeight]);
}

- (ELLayoutCombinationConstraintModel *)centerXY {
    return self.combination(@[ELCenterX,ELCenterY]);
}

- (ELConstraintCombination)combination {
    return ^(NSArray *attributes) {
        ELLayoutCombinationConstraintModel *combinationModel = [[ELLayoutCombinationConstraintModel alloc] init];
        for (NSNumber *number in attributes) {
            NSLayoutAttribute attribute = [number integerValue];
            [combinationModel.models addObject:[self modelWithAttribute:attribute]];
        }
        return combinationModel;
    };
}

#pragma mark - private methods

- (ELLayoutConstraintModel *)modelWithAttribute:(NSLayoutAttribute)attribute {
    ELLayoutConstraintModel *model = [_view constraintWithAttribute:attribute];
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
    //if relationship is equal, this should be only one on common
  if (model.relation != NSLayoutRelationEqual) {
    [string appendFormat:@"%ld/", (long)model.relation];
    [string appendFormat:@"%p/", model.toView];
    [string appendFormat:@"%ld/", (long)model.toAttribute];
  }
  return string.copy;
}

@end
