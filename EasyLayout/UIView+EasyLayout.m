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

- (ELLayoutConstraintModel *)left {
  return [self constraintWithAttribute:NSLayoutAttributeLeft];
}

- (ELLayoutConstraintModel *)right {
  return [self constraintWithAttribute:NSLayoutAttributeRight];
}

- (ELLayoutConstraintModel *)top {
  return [self constraintWithAttribute:NSLayoutAttributeTop];
}

- (ELLayoutConstraintModel *)bottom {
  return [self constraintWithAttribute:NSLayoutAttributeBottom];
}

- (ELLayoutConstraintModel *)centerX {
  return [self constraintWithAttribute:NSLayoutAttributeCenterX];
}

- (ELLayoutConstraintModel *)centerY {
  return [self constraintWithAttribute:NSLayoutAttributeCenterY];
}

- (ELLayoutConstraintModel *)width {
  return [self constraintWithAttribute:NSLayoutAttributeWidth];
}

- (ELLayoutConstraintModel *)height {
  return [self constraintWithAttribute:NSLayoutAttributeHeight];
}

- (ELLayoutConstraintModel *)leading {
    return [self constraintWithAttribute:NSLayoutAttributeLeading];
}

- (ELLayoutConstraintModel *)trailing {
    return [self constraintWithAttribute:NSLayoutAttributeTrailing];
}

- (ELLayoutConstraintModel *)baseline {
    return [self constraintWithAttribute:NSLayoutAttributeBaseline];
}

- (ELLayoutConstraintModel *)firstBaseline {
    return [self constraintWithAttribute:NSLayoutAttributeFirstBaseline];
}

- (ELLayoutConstraintModel *)lastBaseline {
    return [self constraintWithAttribute:NSLayoutAttributeLastBaseline];
}

- (ELLayoutConstraintModel *)leftMargin {
    return [self constraintWithAttribute:NSLayoutAttributeLeftMargin];
}

- (ELLayoutConstraintModel *)rightMargin {
    return [self constraintWithAttribute:NSLayoutAttributeRightMargin];
}

- (ELLayoutConstraintModel *)topMargin {
    return [self constraintWithAttribute:NSLayoutAttributeTopMargin];
}

- (ELLayoutConstraintModel *)bottomMargin {
    return [self constraintWithAttribute:NSLayoutAttributeBottomMargin];
}

- (ELLayoutConstraintModel *)leadingMargin {
    return [self constraintWithAttribute:NSLayoutAttributeLeadingMargin];
}

- (ELLayoutConstraintModel *)trailingMargin {
    return [self constraintWithAttribute:NSLayoutAttributeTrailingMargin];
}

- (ELLayoutConstraintModel *)centerXWithMargins {
    return [self constraintWithAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (ELLayoutConstraintModel *)centerYWithMargins {
    return [self constraintWithAttribute:NSLayoutAttributeCenterYWithinMargins];
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
