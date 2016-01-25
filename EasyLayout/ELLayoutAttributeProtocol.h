//
//  ELLayoutAttributeProtocol.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/23/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELLayoutConstraintModel;
@protocol ELLayoutAttributeProtocol <NSObject>

@required
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_left;
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_right;
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_top;
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_bottom;
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_centerX;
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_centerY;
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_width;
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_height;
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_leading;
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_trailing;
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_baseline;
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_lastBaseline;
//available on ios 8_0
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_firstBaseline NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_leftMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_rightMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_topMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_bottomMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_leadingMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_trailingMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_centerXWithMargins NS_AVAILABLE_IOS(8_0);
@property (nonatomic, readonly) ELLayoutConstraintModel *EL_centerYWithMargins NS_AVAILABLE_IOS(8_0);

@end