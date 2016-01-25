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

#pragma mark - attributes

- (ELLayoutConstraintModel *)EL_left {
  return [self modelWithAttribute:NSLayoutAttributeLeft];
}

- (ELLayoutConstraintModel *)EL_right {
  return [self modelWithAttribute:NSLayoutAttributeRight];
}

- (ELLayoutConstraintModel *)EL_top {
  return [self modelWithAttribute:NSLayoutAttributeTop];
}

- (ELLayoutConstraintModel *)EL_bottom {
  return [self modelWithAttribute:NSLayoutAttributeBottom];
}

- (ELLayoutConstraintModel *)EL_centerX {
  return [self modelWithAttribute:NSLayoutAttributeCenterX];
}

- (ELLayoutConstraintModel *)EL_centerY {
  return [self modelWithAttribute:NSLayoutAttributeCenterY];
}

- (ELLayoutConstraintModel *)EL_width {
  return [self modelWithAttribute:NSLayoutAttributeWidth];
}

- (ELLayoutConstraintModel *)EL_height {
  return [self modelWithAttribute:NSLayoutAttributeHeight];
}

- (ELLayoutConstraintModel *)EL_leading {
    return [self modelWithAttribute:NSLayoutAttributeLeading];
}

- (ELLayoutConstraintModel *)EL_trailing {
    return [self modelWithAttribute:NSLayoutAttributeTrailing];
}

- (ELLayoutConstraintModel *)EL_leftMargin {
    return [self modelWithAttribute:NSLayoutAttributeLeftMargin];
}

- (ELLayoutConstraintModel *)EL_rightMargin {
    return [self modelWithAttribute:NSLayoutAttributeRightMargin];
}

- (ELLayoutConstraintModel *)EL_topMargin {
    return [self modelWithAttribute:NSLayoutAttributeTopMargin];
}

- (ELLayoutConstraintModel *)EL_bottomMargin {
    return [self modelWithAttribute:NSLayoutAttributeBottomMargin];
}

- (ELLayoutConstraintModel *)EL_leadingMargin {
    return [self modelWithAttribute:NSLayoutAttributeLeadingMargin];
}

- (ELLayoutConstraintModel *)EL_trailingMargin {
    return [self modelWithAttribute:NSLayoutAttributeTrailingMargin];
}

- (ELLayoutConstraintModel *)EL_baseline {
    return [self modelWithAttribute:NSLayoutAttributeBaseline];
}

- (ELLayoutConstraintModel *)EL_firstBaseline {
    return [self modelWithAttribute:NSLayoutAttributeFirstBaseline];
}

- (ELLayoutConstraintModel *)EL_lastBaseline {
    return [self modelWithAttribute:NSLayoutAttributeLastBaseline];
}

- (ELLayoutConstraintModel *)EL_centerXWithMargins {
    return [self modelWithAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (ELLayoutConstraintModel *)EL_centerYWithMargins {
    return [self modelWithAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#pragma mark - private methods

- (ELLayoutConstraintModel *)modelWithAttribute:(NSLayoutAttribute)attribute {
    ELLayoutConstraintModel *model = nil;
    switch (attribute) {
        case NSLayoutAttributeLeft: {
            model = _view.EL_left;
            break;
        }
        case NSLayoutAttributeRight: {
            model = _view.EL_right;
            break;
        }
        case NSLayoutAttributeTop: {
            model = _view.EL_top;
            break;
        }
        case NSLayoutAttributeBottom: {
            model = _view.EL_bottom;
            break;
        }
        case NSLayoutAttributeLeading: {
            model = _view.EL_leading;
            break;
        }
        case NSLayoutAttributeTrailing: {
            model = _view.EL_trailing;
            break;
        }
        case NSLayoutAttributeWidth: {
            model = _view.EL_width;
            break;
        }
        case NSLayoutAttributeHeight: {
            model = _view.EL_height;
            break;
        }
        case NSLayoutAttributeCenterX: {
            model = _view.EL_centerX;
            break;
        }
        case NSLayoutAttributeCenterY: {
            model = _view.EL_centerY;
            break;
        }
//        case NSLayoutAttributeLastBaseline:
        case NSLayoutAttributeBaseline: {
            model = _view.EL_baseline;
            break;
        }
        case NSLayoutAttributeFirstBaseline: {
            model = _view.EL_firstBaseline;
            break;
        }
        case NSLayoutAttributeLeftMargin: {
            model = _view.EL_leftMargin;
            break;
        }
        case NSLayoutAttributeRightMargin: {
            model = _view.EL_rightMargin;
            break;
        }
        case NSLayoutAttributeTopMargin: {
            model = _view.EL_topMargin;
            break;
        }
        case NSLayoutAttributeBottomMargin: {
            model = _view.EL_bottomMargin;
            break;
        }
        case NSLayoutAttributeLeadingMargin: {
            model = _view.EL_leadingMargin;
            break;
        }
        case NSLayoutAttributeTrailingMargin: {
            model = _view.EL_trailingMargin;
            break;
        }
        case NSLayoutAttributeCenterXWithinMargins: {
            model = _view.EL_centerXWithMargins;
            break;
        }
        case NSLayoutAttributeCenterYWithinMargins: {
            model = _view.EL_centerYWithMargins;
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
