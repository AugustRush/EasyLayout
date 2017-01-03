//
//  ELLayoutAttributeProtocol.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/23/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyLayoutDefine.h"

typedef NS_ENUM(NSUInteger, ELInterfaceOritation) {
    ELInterfaceOritationPortrait = 1 << 0,
    ELInterfaceOritationLandscape = 1 << 1,
    ELInterfaceOritationAll = ELInterfaceOritationPortrait | ELInterfaceOritationLandscape,
};

@class ELLayoutConstraintModel;
@class ELLayoutCombinationConstraintModel;
@protocol ELLayoutAttributeProtocol <NSObject>

@required
@property (nonatomic, readonly) ELLayoutConstraintModel *ELLeft;
@property (nonatomic, readonly) ELLayoutConstraintModel *ELRight;
@property (nonatomic, readonly) ELLayoutConstraintModel *ELTop;
@property (nonatomic, readonly) ELLayoutConstraintModel *ELBottom;
@property (nonatomic, readonly) ELLayoutConstraintModel *ELCenterX;
@property (nonatomic, readonly) ELLayoutConstraintModel *ELCenterY;
@property (nonatomic, readonly) ELLayoutConstraintModel *ELWidth;
@property (nonatomic, readonly) ELLayoutConstraintModel *ELHeight;
@property (nonatomic, readonly) ELLayoutConstraintModel *ELLeading;
@property (nonatomic, readonly) ELLayoutConstraintModel *ELTrailing;
@property (nonatomic, readonly) ELLayoutConstraintModel *ELBaseline;
@property (nonatomic, readonly) ELLayoutConstraintModel *ELLastBaseline;
//available on ios 8_0
@property (nonatomic, readonly) ELLayoutConstraintModel *ELFirstBaseline NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *ELLeftMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *ELRightMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *ELTopMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *ELBottomMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *ELLeadingMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *ELTrailingMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *ELCenterXWithMargins NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *ELCenterYWithMargins NS_AVAILABLE_IOS(8_0);
/**
 *  @brief some convenience combination attribute
 * you can get the real constraint with correct index from constraints array
 */
//** top , left , bottom , right
@property (nonatomic, readonly) ELLayoutCombinationConstraintModel *ELAllEdges;
// width, height
@property (nonatomic, readonly) ELLayoutCombinationConstraintModel *ELSize;
@property (nonatomic, readonly) ELLayoutCombinationConstraintModel *ELCenter;

typedef ELLayoutCombinationConstraintModel *(^ELConstraintCombination)(NSArray<NSNumber *> *attributes);
@property (nonatomic, copy, readonly) ELConstraintCombination combination;

@end
