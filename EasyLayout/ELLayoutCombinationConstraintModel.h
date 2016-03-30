//
//  ELLayoutCombinationConstraintModel.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 3/28/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELLayoutConstraintModel.h"

@interface ELLayoutCombinationConstraintModel : NSObject

typedef ELLayoutCombinationConstraintModel * (^ELLayoutombinationLinkerBlock)(id viewOrNumber);
typedef ELLayoutCombinationConstraintModel * (^ELLayoutCombinationOffsetBlock)(CGFloat offset);
typedef ELLayoutCombinationOffsetBlock ELLayoutCombinationMutiplierBlock;
typedef ELLayoutCombinationOffsetBlock ELLayoutCombinationPriorityBlock;

@property (nonatomic, strong) NSMutableArray<ELLayoutConstraintModel *> *models;

+ (instancetype)combinationModelWithModels:(NSArray<ELLayoutConstraintModel *> *)models;

- (ELLayoutombinationLinkerBlock)equalTo;
- (ELLayoutombinationLinkerBlock)greaterThanOrEqualTo;
- (ELLayoutombinationLinkerBlock)lessThanOrEqualTo;

- (ELLayoutCombinationMutiplierBlock)multiplier;
- (ELLayoutCombinationOffsetBlock)offset;
- (ELLayoutCombinationPriorityBlock)priority;

@end
