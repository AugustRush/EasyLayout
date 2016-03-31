//
//  ELLayoutAttributeProtocol.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/23/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyLayoutDefine_unused.h"

@class ELLayoutConstraintModel;
@class ELLayoutCombinationConstraintModel;
@protocol ELLayoutAttributeProtocol <NSObject>

@required
@property (nonatomic, readonly) ELLayoutConstraintModel *left;
@property (nonatomic, readonly) ELLayoutConstraintModel *right;
@property (nonatomic, readonly) ELLayoutConstraintModel *top;
@property (nonatomic, readonly) ELLayoutConstraintModel *bottom;
@property (nonatomic, readonly) ELLayoutConstraintModel *centerX;
@property (nonatomic, readonly) ELLayoutConstraintModel *centerY;
@property (nonatomic, readonly) ELLayoutConstraintModel *width;
@property (nonatomic, readonly) ELLayoutConstraintModel *height;
@property (nonatomic, readonly) ELLayoutConstraintModel *leading;
@property (nonatomic, readonly) ELLayoutConstraintModel *trailing;
@property (nonatomic, readonly) ELLayoutConstraintModel *baseline;
@property (nonatomic, readonly) ELLayoutConstraintModel *lastBaseline;
//available on ios 8_0
@property (nonatomic, readonly) ELLayoutConstraintModel *firstBaseline NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *leftMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *rightMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *topMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *bottomMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *leadingMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *trailingMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *centerXWithMargins NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *centerYWithMargins NS_AVAILABLE_IOS(8_0);
//convenience
@property (nonatomic, readonly) ELLayoutCombinationConstraintModel *allEdges;
@property (nonatomic, readonly) ELLayoutCombinationConstraintModel *size;
@property (nonatomic, readonly) ELLayoutCombinationConstraintModel *centerXY;

typedef ELLayoutCombinationConstraintModel *(^ELConstraintCombination)(NSArray<NSNumber *> *attributes);
@property (nonatomic, copy, readonly) ELConstraintCombination combination;

@end