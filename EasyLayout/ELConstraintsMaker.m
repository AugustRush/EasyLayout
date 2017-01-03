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
#import "ELConstraintsMaker+ELPrivate.h"

@interface UIView (ELPrivate)

- (ELLayoutConstraintModel *)constraintWithAttribute:(NSLayoutAttribute)attribute;

@end

#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation UIView (ELPrivate)
@end

@implementation ELConstraintsMaker {
    __weak UIView *_view;
    NSMutableSet<ELLayoutConstraintModel *> *_tempModels;
    NSMutableDictionary<NSString *, ELLayoutConstraintModel *> *_models;
    NSHashTable<NSLayoutConstraint *> *_constraints;
    ELInterfaceOritation _orientation;
}

#pragma mark - life cycle methods

- (instancetype)initWithView:(UIView *)view orientation:(ELInterfaceOritation)orientation {
    self = [super init];
    if (self) {
        _view = view;
        _tempModels = [NSMutableSet set];
        _models = @{}.mutableCopy;
        _constraints = [NSHashTable weakObjectsHashTable];
        _orientation = orientation;
    }
    return self;
}

#pragma mark - public methods

- (void)removeAll {
  [_tempModels removeAllObjects];
  [_models removeAllObjects];
  [NSLayoutConstraint deactivateConstraints:_constraints.allObjects];
}

- (void)update {
    for (ELLayoutConstraintModel *model in _tempModels) {
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
    // REMOVE ALL TEMPLE MODELS
    [_tempModels removeAllObjects];
}

- (void)installConstraintWithModel:(ELLayoutConstraintModel *)model
                        identifier:(NSString *)identifier {
    NSLayoutConstraint *constraint = model.constraint();
    BOOL active = [self constraintsShouldBeActived];
    [constraint setActive:active];
    _models[identifier] = model;
    [_constraints addObject:constraint];
}

#pragma mark - attributes

- (ELLayoutConstraintModel *)ELLeft {
  return [self modelWithAttribute:NSLayoutAttributeLeft];
}

- (ELLayoutConstraintModel *)ELRight {
  return [self modelWithAttribute:NSLayoutAttributeRight];
}

- (ELLayoutConstraintModel *)ELTop {
  return [self modelWithAttribute:NSLayoutAttributeTop];
}

- (ELLayoutConstraintModel *)ELBottom {
  return [self modelWithAttribute:NSLayoutAttributeBottom];
}

- (ELLayoutConstraintModel *)ELCenterX {
  return [self modelWithAttribute:NSLayoutAttributeCenterX];
}

- (ELLayoutConstraintModel *)ELCenterY {
  return [self modelWithAttribute:NSLayoutAttributeCenterY];
}

- (ELLayoutConstraintModel *)ELWidth {
  return [self modelWithAttribute:NSLayoutAttributeWidth];
}

- (ELLayoutConstraintModel *)ELHeight {
  return [self modelWithAttribute:NSLayoutAttributeHeight];
}

- (ELLayoutConstraintModel *)ELLeading {
    return [self modelWithAttribute:NSLayoutAttributeLeading];
}

- (ELLayoutConstraintModel *)ELTrailing {
    return [self modelWithAttribute:NSLayoutAttributeTrailing];
}

- (ELLayoutConstraintModel *)ELLeftMargin {
    return [self modelWithAttribute:NSLayoutAttributeLeftMargin];
}

- (ELLayoutConstraintModel *)ELRightMargin {
    return [self modelWithAttribute:NSLayoutAttributeRightMargin];
}

- (ELLayoutConstraintModel *)ELTopMargin {
    return [self modelWithAttribute:NSLayoutAttributeTopMargin];
}

- (ELLayoutConstraintModel *)ELBottomMargin {
    return [self modelWithAttribute:NSLayoutAttributeBottomMargin];
}

- (ELLayoutConstraintModel *)ELLeadingMargin {
    return [self modelWithAttribute:NSLayoutAttributeLeadingMargin];
}

- (ELLayoutConstraintModel *)ELTrailingMargin {
    return [self modelWithAttribute:NSLayoutAttributeTrailingMargin];
}

- (ELLayoutConstraintModel *)ELBaseline {
    return [self modelWithAttribute:NSLayoutAttributeBaseline];
}

- (ELLayoutConstraintModel *)ELFirstBaseline {
    return [self modelWithAttribute:NSLayoutAttributeFirstBaseline];
}

- (ELLayoutConstraintModel *)ELLastBaseline {
    return [self modelWithAttribute:NSLayoutAttributeLastBaseline];
}

- (ELLayoutConstraintModel *)ELCenterXWithMargins {
    return [self modelWithAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (ELLayoutConstraintModel *)ELCenterYWithMargins {
    return [self modelWithAttribute:NSLayoutAttributeCenterYWithinMargins];
}

- (ELLayoutCombinationConstraintModel *)ELAllEdges {
    return self.combination(@[ELCTop,ELCLeft,ELCBottom,ELCRight]);
}

- (ELLayoutCombinationConstraintModel *)ELSize {
    return self.combination(@[ELCWidth,ELCHeight]);
}

- (ELLayoutCombinationConstraintModel *)ELCenter {
    return self.combination(@[ELCCenterX,ELCCenterY]);
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

//should be called on constrint model has been fullfill
- (ELLayoutConstraintModel *)modelWithAttribute:(NSLayoutAttribute)attribute {
    ELLayoutConstraintModel *model = [_view constraintWithAttribute:attribute];
    if (model) {
        [_tempModels addObject:model];
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

- (ELInterfaceOritation)currentInterfaceOrientation {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

    if (UIInterfaceOrientationIsPortrait(orientation)) {
        return ELInterfaceOritationPortrait;
    }
    return ELInterfaceOritationLandscape;
}

- (BOOL)constraintsShouldBeActived {
    return ([self currentInterfaceOrientation] & _orientation);
}

- (void)activateAllConstraints {
    for (ELLayoutConstraintModel *model in _models.allValues) {
        NSLayoutConstraint *constraint = model.constraint();
        constraint.active = YES;
        [_constraints addObject:constraint];
    }
    
}

- (void)deactivateAllConstraints {
    // deactived constraints
    [NSLayoutConstraint deactivateConstraints:_constraints.allObjects];
}

@end
