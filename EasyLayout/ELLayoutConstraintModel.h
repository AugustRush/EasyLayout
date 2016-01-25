//
//  ELLayoutConstraintModel.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELLayoutConstraintModel;

typedef ELLayoutConstraintModel * (^ELLayoutOffsetBlock)(CGFloat offset);
typedef ELLayoutOffsetBlock ELLayoutMultiplierBlock;
typedef ELLayoutOffsetBlock ELLayoutPriorityBlock;
typedef ELLayoutConstraintModel * (^ELLayoutLinkerBlock)(id viewOrNumber);
typedef NSLayoutConstraint * (^ELLayoutConstraintReturnBlock)(void);

@interface ELLayoutConstraintModel : NSObject

@property (nonatomic, weak) UIView *view;
@property (nonatomic, weak) UIView *toView;
@property (nonatomic, assign) NSLayoutRelation relation;
@property (nonatomic, assign) NSLayoutAttribute attribute;
@property (nonatomic, assign) NSLayoutAttribute toAttribute;
@property (nonatomic, assign) CGFloat ratio;//multiplier
@property (nonatomic, assign) CGFloat constant;
@property (nonatomic, assign) UILayoutPriority priorityLevel;

- (ELLayoutLinkerBlock)equalTo;
- (ELLayoutLinkerBlock)greaterThanOrEqualTo;
- (ELLayoutLinkerBlock)lessThanOrEqualTo;

- (ELLayoutMultiplierBlock)multiplier;
- (ELLayoutOffsetBlock)offset;
- (ELLayoutPriorityBlock)priority;

//get NSLayoutConstraint instance
- (ELLayoutConstraintReturnBlock)constraint;

@end
