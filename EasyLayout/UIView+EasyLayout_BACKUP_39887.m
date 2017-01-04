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
#import "ELConstraintsMaker+ELPrivate.h"

@interface _ELConstraintsMakerManager : NSObject

@property (nonatomic, assign) BOOL hasDividedConstraints;
<<<<<<< HEAD
@property (nonatomic, weak) UIView *view;

- (ELConstraintsMaker *)portraitMaker;
- (ELConstraintsMaker *)landscapeMaker;
=======
@property (nonatomic, weak) ELConstraintsMaker *portraitMaker;
@property (nonatomic, weak) ELConstraintsMaker *landscapeMaker;

@end

@implementation _ELConstraintsMakerManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _hasDividedConstraints = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interfaceOrientationWillChanged:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - notification methods

- (void)interfaceOrientationWillChanged:(NSNotification *)notification {
    UIInterfaceOrientation orientation = [[notification.userInfo objectForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];
    
    if (!_hasDividedConstraints) {
        return;
    }
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        [self.landscapeMaker deactivateAllConstraints];
        [self.portraitMaker activateAllConstraints];
    } else {
        [self.portraitMaker deactivateAllConstraints];
        [self.landscapeMaker activateAllConstraints];
    }
}
>>>>>>> 03254c925398bfc566e4b91d64513e4c8198dfb1

@end


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

- (_ELConstraintsMakerManager *)_makerManager {
    _ELConstraintsMakerManager *manager = objc_getAssociatedObject(self, _cmd);
    if (manager == nil) {
        manager = [[_ELConstraintsMakerManager alloc] init];
        manager.view = self;
        objc_setAssociatedObject(self, _cmd, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return manager;
}

const void *ELPortraitMakerKey = &ELPortraitMakerKey;
const void *ELLandscapeMakerKey = &ELLandscapeMakerKey;

- (ELConstraintsMaker *)ELMakerForOrientation:(ELInterfaceOritation)orientation {
    
    ELConstraintsMaker *maker = nil;
    switch (orientation) {
        case ELInterfaceOritationAll:
            NSAssert(0, @"should not be called!");
            break;
        case ELInterfaceOritationLandscape:
            maker = objc_getAssociatedObject(self, ELLandscapeMakerKey);
            if (maker == nil) {
                maker = [[ELConstraintsMaker alloc] initWithView:self orientation:orientation];
                objc_setAssociatedObject(self, ELLandscapeMakerKey, maker,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            break;
        case ELInterfaceOritationPortrait:
            maker = objc_getAssociatedObject(self, ELPortraitMakerKey);
            if (maker == nil) {
                maker = [[ELConstraintsMaker alloc] initWithView:self orientation:orientation];
                objc_setAssociatedObject(self, ELPortraitMakerKey, maker,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            break;
    }
    
    return maker;
}

#pragma mark - public methods

- (void)remakeConstraints:(void (^)(ELConstraintsMaker *))block {
    [self remakeConstraints:block forOrientation:ELInterfaceOritationAll];
}

- (void)updateOrMakeConstraints:(void (^)(ELConstraintsMaker *))block {
    [self updateOrMakeConstraints:block forOrientation:ELInterfaceOritationAll];
}

- (void)updateOrMakeConstraints:(void (^)(ELConstraintsMaker *))block forOrientation:(ELInterfaceOritation)orientation {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _ELConstraintsMakerManager *manager = [self _makerManager];
    if (orientation == ELInterfaceOritationAll) {
        ELConstraintsMaker *portraitMaker = manager.portraitMaker;
        ELConstraintsMaker *landscapeMaker = manager.landscapeMaker;
        //
        block(portraitMaker);
        block(landscapeMaker);
        //
        [portraitMaker update];
        [landscapeMaker update];
    } else {
<<<<<<< HEAD
        manager.hasDividedConstraints = YES;
=======
        [self _makerManager].hasDividedConstraints = YES;
>>>>>>> 03254c925398bfc566e4b91d64513e4c8198dfb1
        //
        ELConstraintsMaker *maker = [self ELMakerForOrientation:orientation];
        block(maker);
        [maker update];
    }
}

- (void)remakeConstraints:(void (^)(ELConstraintsMaker *))block forOrientation:(ELInterfaceOritation)orientation {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _ELConstraintsMakerManager *manager = [self _makerManager];
    if (orientation == ELInterfaceOritationAll) {
        ELConstraintsMaker *portraitMaker = manager.portraitMaker;
        ELConstraintsMaker *landscapeMaker = manager.landscapeMaker;
        //
        [portraitMaker removeAll];
        [landscapeMaker removeAll];
        //
        block(portraitMaker);
        block(landscapeMaker);
        //
        [portraitMaker update];
        [landscapeMaker update];
    } else {
<<<<<<< HEAD
        manager.hasDividedConstraints = YES;
=======
        [self _makerManager].hasDividedConstraints = YES;
>>>>>>> 03254c925398bfc566e4b91d64513e4c8198dfb1
        //
        ELConstraintsMaker *maker = [self ELMakerForOrientation:orientation];
        [maker removeAll];
        block(maker);
        [maker update];
    }
}

@end

@implementation _ELConstraintsMakerManager

#pragma mark - life cycle methods

- (instancetype)init {
    self = [super init];
    if (self) {
        _hasDividedConstraints = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interfaceOrientationWillChanged:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private methods

- (ELConstraintsMaker *)portraitMaker {
    return [_view ELMakerForOrientation:ELInterfaceOritationPortrait];
}

- (ELConstraintsMaker *)landscapeMaker {
    return [_view ELMakerForOrientation:ELInterfaceOritationLandscape];
}

#pragma mark - notification methods

- (void)interfaceOrientationWillChanged:(NSNotification *)notification {
    UIInterfaceOrientation orientation = [[notification.userInfo objectForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];
    
    if (!_hasDividedConstraints) {
        return;
    }
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        [self.landscapeMaker deactivateAllConstraints];
        [self.portraitMaker activateAllConstraints];
    } else {
        [self.portraitMaker deactivateAllConstraints];
        [self.landscapeMaker activateAllConstraints];
    }
}

@end