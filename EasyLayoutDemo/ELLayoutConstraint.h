//
//  ELLayoutConstraint.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELLayoutConstraint;

typedef ELLayoutConstraint * (^ELLayoutOffsetBlock)(CGFloat offset);
typedef ELLayoutOffsetBlock ELLayoutMultiplierBlock;
typedef ELLayoutConstraint * (^ELLayoutLinkerBlock)(id viewOrNumber);

@interface ELLayoutConstraint : NSObject

@property (nonatomic, weak) UIView *view;
@property (nonatomic, weak) UIView *toView;
@property (nonatomic, assign) NSLayoutRelation relation;
@property (nonatomic, assign) NSLayoutAttribute attribute;
@property (nonatomic, assign) NSLayoutAttribute toAttribute;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) CGFloat constant;

- (ELLayoutLinkerBlock)equalTo;
- (ELLayoutLinkerBlock)greaterThanOrEqualTo;
- (ELLayoutLinkerBlock)lessThanOrEqualTo;

- (ELLayoutMultiplierBlock)multiplier;
- (ELLayoutOffsetBlock)offset;

@end
