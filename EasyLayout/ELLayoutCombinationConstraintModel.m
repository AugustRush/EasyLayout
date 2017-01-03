//
//  ELLayoutCombinationConstraintModel.m
//  EasyLayoutDemo
//
//  Created by AugustRush on 3/28/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ELLayoutCombinationConstraintModel.h"

@interface ELLayoutConstraintModel (ELPrivate)

- (void)configurationWithSupportType:(id)supportType
                            relation:(NSLayoutRelation)relation;

@end

#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation ELLayoutConstraintModel (ELPrivate)

@end

@implementation ELLayoutCombinationConstraintModel {
  NSMutableArray<ELLayoutConstraintModel *> *_models;
}
@synthesize models = _models;

+ (instancetype)combinationModelWithModels:
    (NSArray<ELLayoutConstraintModel *> *)models {
  ELLayoutCombinationConstraintModel *combinationModel =
      [[ELLayoutCombinationConstraintModel alloc] init];
  [combinationModel->_models addObjectsFromArray:models];
  return combinationModel;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _models = @[].mutableCopy;
  }
  return self;
}

- (ELLayoutombinationLinkerBlock)equalTo {
  return ^ELLayoutCombinationConstraintModel *(id supportType) {
    return
        [self handleSupportType:supportType withRelation:NSLayoutRelationEqual];
  };
}

- (ELLayoutombinationLinkerBlock)greaterThanOrEqualTo {
  return ^ELLayoutCombinationConstraintModel *(id supportType) {
    return [self handleSupportType:supportType
                      withRelation:NSLayoutRelationGreaterThanOrEqual];
  };
}

- (ELLayoutombinationLinkerBlock)lessThanOrEqualTo {
  return ^ELLayoutCombinationConstraintModel *(id supportType) {
    return [self handleSupportType:supportType
                      withRelation:NSLayoutRelationLessThanOrEqual];
  };
}

- (ELLayoutCombinationMutiplierBlock)multipliers {
  return ^(id mutiplier) {
    if ([mutiplier isKindOfClass:[NSNumber class]]) {
      for (ELLayoutConstraintModel *model in _models) {
        model.multiplier([mutiplier floatValue]);
      }
    } else if ([mutiplier isKindOfClass:[NSArray class]]) {
      NSArray *ms = mutiplier;
      [_models
          enumerateObjectsUsingBlock:^(ELLayoutConstraintModel *_Nonnull obj,
                                       NSUInteger idx, BOOL *_Nonnull stop) {
            CGFloat m = ms.count > idx ? [ms[idx] floatValue] : 0.0;
            obj.multiplier(m);
          }];
    }
    return self;
  };
}

- (ELLayoutCombinationOffsetBlock)offsets {
  return ^(id offset) {
    if ([offset isKindOfClass:[NSNumber class]]) {
      for (ELLayoutConstraintModel *model in _models) {
        model.offset([offset floatValue]);
      }
    } else if ([offset isKindOfClass:[NSArray class]]) {
      NSArray *ms = offset;
      [_models
          enumerateObjectsUsingBlock:^(ELLayoutConstraintModel *_Nonnull obj,
                                       NSUInteger idx, BOOL *_Nonnull stop) {
            CGFloat m = ms.count > idx ? [ms[idx] floatValue] : 0.0;
            obj.offset(m);
          }];
    }
    return self;
  };
}

- (ELLayoutCombinationPriorityBlock)prioritys {
  return ^(id priority) {
    if ([priority isKindOfClass:[NSNumber class]]) {
      for (ELLayoutConstraintModel *model in _models) {
        model.priority([priority floatValue]);
      }
    } else if ([priority isKindOfClass:[NSArray class]]) {
      NSArray *ms = priority;
      [_models
          enumerateObjectsUsingBlock:^(ELLayoutConstraintModel *_Nonnull obj,
                                       NSUInteger idx, BOOL *_Nonnull stop) {
            CGFloat m = ms.count > idx ? [ms[idx] floatValue] : 0.0;
            obj.priority(m);
          }];
    }
    return self;
  };
}

- (ELCombinationConstraintGetBlock)constraint {
  return ^(NSUInteger index) {
    return _models[index].constraint();
  };
}

#pragma mark - private methods

- (ELLayoutCombinationConstraintModel *)handleSupportType:(id)supportType
                                             withRelation:
                                                 (NSLayoutRelation)relation {
  BOOL isSelfClass = [supportType isKindOfClass:[self class]];
  BOOL isArray = [supportType isKindOfClass:[NSArray class]];
  if (isSelfClass || isArray) {
    NSArray *array = isArray ? supportType : [supportType models];
    [_models enumerateObjectsUsingBlock:^(ELLayoutConstraintModel *_Nonnull obj,
                                          NSUInteger idx, BOOL *_Nonnull stop) {
      [obj configurationWithSupportType:array[idx] relation:relation];
    }];
  } else {
    for (ELLayoutConstraintModel *model in _models) {
      [model configurationWithSupportType:supportType relation:relation];
    }
  }
  return self;
}

@end
