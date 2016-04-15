//
//  UIView+EasyLayout.m
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "UIView+EasyLayout.h"
#import <objc/runtime.h>
#import "ELLayoutConstraintModel.h"
#import "ELLayoutCombinationConstraintModel.h"

@implementation UIView (EasyLayout)

#pragma mark - attributes 

- (ELLayoutConstraintModel *)ELLeft {
  return [self constraintWithAttribute:NSLayoutAttributeLeft];
}

- (ELLayoutConstraintModel *)ELRight {
  return [self constraintWithAttribute:NSLayoutAttributeRight];
}

- (ELLayoutConstraintModel *)ELTop {
  return [self constraintWithAttribute:NSLayoutAttributeTop];
}

- (ELLayoutConstraintModel *)ELBottom {
  return [self constraintWithAttribute:NSLayoutAttributeBottom];
}

- (ELLayoutConstraintModel *)ELCenterX {
  return [self constraintWithAttribute:NSLayoutAttributeCenterX];
}

- (ELLayoutConstraintModel *)ELCenterY {
  return [self constraintWithAttribute:NSLayoutAttributeCenterY];
}

- (ELLayoutConstraintModel *)ELWidth {
  return [self constraintWithAttribute:NSLayoutAttributeWidth];
}

- (ELLayoutConstraintModel *)ELHeight {
  return [self constraintWithAttribute:NSLayoutAttributeHeight];
}

- (ELLayoutConstraintModel *)ELLeading {
    return [self constraintWithAttribute:NSLayoutAttributeLeading];
}

- (ELLayoutConstraintModel *)ELTrailing {
    return [self constraintWithAttribute:NSLayoutAttributeTrailing];
}

- (ELLayoutConstraintModel *)ELBaseline {
    return [self constraintWithAttribute:NSLayoutAttributeBaseline];
}

- (ELLayoutConstraintModel *)ELFirstBaseline {
    return [self constraintWithAttribute:NSLayoutAttributeFirstBaseline];
}

- (ELLayoutConstraintModel *)ELLastBaseline {
    return [self constraintWithAttribute:NSLayoutAttributeLastBaseline];
}

- (ELLayoutConstraintModel *)ELLeftMargin {
    return [self constraintWithAttribute:NSLayoutAttributeLeftMargin];
}

- (ELLayoutConstraintModel *)ELRightMargin {
    return [self constraintWithAttribute:NSLayoutAttributeRightMargin];
}

- (ELLayoutConstraintModel *)ELTopMargin {
    return [self constraintWithAttribute:NSLayoutAttributeTopMargin];
}

- (ELLayoutConstraintModel *)ELBottomMargin {
    return [self constraintWithAttribute:NSLayoutAttributeBottomMargin];
}

- (ELLayoutConstraintModel *)ELLeadingMargin {
    return [self constraintWithAttribute:NSLayoutAttributeLeadingMargin];
}

- (ELLayoutConstraintModel *)ELTrailingMargin {
    return [self constraintWithAttribute:NSLayoutAttributeTrailingMargin];
}

- (ELLayoutConstraintModel *)ELCenterXWithMargins {
    return [self constraintWithAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (ELLayoutConstraintModel *)ELCenterYWithMargins {
    return [self constraintWithAttribute:NSLayoutAttributeCenterYWithinMargins];
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
            [combinationModel.models addObject:[self constraintWithAttribute:attribute]];
        }
        return combinationModel;
    };
}

#pragma mark - private methods

- (ELLayoutConstraintModel *)constraintWithAttribute:(NSLayoutAttribute)attribute {
    ELLayoutConstraintModel *constraint = [ELLayoutConstraintModel new];
    constraint.view = self;
    constraint.attribute = attribute;
    return constraint;
}

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

- (void)makeConstraints:(void (^)(ELConstraintsMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    ELConstraintsMaker *maker = [self ELMaker];
    maker.isUpdating = NO;
    block(maker);
    [maker install];
}

- (void)remakeConstraints:(void (^)(ELConstraintsMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    ELConstraintsMaker *maker = [self ELMaker];
    maker.isUpdating = NO;
    [maker removeAll];
    block(maker);
    [maker install];
}

- (void)updateConstraints:(void (^)(ELConstraintsMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    ELConstraintsMaker *maker = [self ELMaker];
    maker.isUpdating = YES;
    block(maker);
    [maker update];
}

@end
