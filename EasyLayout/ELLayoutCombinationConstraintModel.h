//
//  ELLayoutCombinationConstraintModel.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 3/28/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELLayoutConstraintModel.h"

@class ELLayoutCombinationConstraintModel;
typedef ELLayoutCombinationConstraintModel * (^ELLayoutombinationLinkerBlock)(id viewOrNumber);
typedef ELLayoutCombinationConstraintModel * (^ELLayoutCombinationOffsetBlock)(CGFloat offset);
typedef ELLayoutCombinationOffsetBlock ELLayoutCombinationMutiplierBlock;
typedef ELLayoutCombinationOffsetBlock ELLayoutCombinationPriorityBlock;
typedef NSLayoutConstraint *(^ELCombinationConstraintGetBlock)(NSUInteger index);
/**
 *  @brief class interface
 */
@interface ELLayoutCombinationConstraintModel : NSObject

+ (instancetype)combinationModelWithModels:(NSArray<ELLayoutConstraintModel *> *)models;

- (ELLayoutombinationLinkerBlock)equalTo;
- (ELLayoutombinationLinkerBlock)greaterThanOrEqualTo;
- (ELLayoutombinationLinkerBlock)lessThanOrEqualTo;

- (ELLayoutCombinationMutiplierBlock)multiplier;
- (ELLayoutCombinationOffsetBlock)offset;
- (ELLayoutCombinationPriorityBlock)priority;
//get constraint
- (ELCombinationConstraintGetBlock)constraint;

@end
