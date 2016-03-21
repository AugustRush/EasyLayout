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

#pragma mark - private methods

- (ELLayoutConstraintModel *)modelWithAttribute:(NSLayoutAttribute)attribute {
    ELLayoutConstraintModel *model = nil;
    switch (attribute) {
        case NSLayoutAttributeLeft: {
            model = _view.left;
            break;
        }
        case NSLayoutAttributeRight: {
            model = _view.right;
            break;
        }
        case NSLayoutAttributeTop: {
            model = _view.top;
            break;
        }
        case NSLayoutAttributeBottom: {
            model = _view.bottom;
            break;
        }
        case NSLayoutAttributeLeading: {
            model = _view.leading;
            break;
        }
        case NSLayoutAttributeTrailing: {
            model = _view.trailing;
            break;
        }
        case NSLayoutAttributeWidth: {
            model = _view.width;
            break;
        }
        case NSLayoutAttributeHeight: {
            model = _view.height;
            break;
        }
        case NSLayoutAttributeCenterX: {
            model = _view.centerX;
            break;
        }
        case NSLayoutAttributeCenterY: {
            model = _view.centerY;
            break;
        }
//        case NSLayoutAttributeLastBaseline:
        case NSLayoutAttributeBaseline: {
            model = _view.baseline;
            break;
        }
        case NSLayoutAttributeFirstBaseline: {
            model = _view.firstBaseline;
            break;
        }
        case NSLayoutAttributeLeftMargin: {
            model = _view.leftMargin;
            break;
        }
        case NSLayoutAttributeRightMargin: {
            model = _view.rightMargin;
            break;
        }
        case NSLayoutAttributeTopMargin: {
            model = _view.topMargin;
            break;
        }
        case NSLayoutAttributeBottomMargin: {
            model = _view.bottomMargin;
            break;
        }
        case NSLayoutAttributeLeadingMargin: {
            model = _view.leadingMargin;
            break;
        }
        case NSLayoutAttributeTrailingMargin: {
            model = _view.trailingMargin;
            break;
        }
        case NSLayoutAttributeCenterXWithinMargins: {
            model = _view.centerXWithMargins;
            break;
        }
        case NSLayoutAttributeCenterYWithinMargins: {
            model = _view.centerYWithMargins;
            break;
        }
        case NSLayoutAttributeNotAnAttribute: {
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
