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
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_left;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_right;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_top;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_bottom;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_centerX;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_centerY;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_width;
@property(nonatomic, readonly) ELLayoutConstraintModel *EL_height;

@end
