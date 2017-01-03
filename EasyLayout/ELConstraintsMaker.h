//
//  ELCondtraintsMaker.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELLayoutAttributeProtocol.h"
#import "ELLayoutConstraintModel.h"
#import "ELLayoutCombinationConstraintModel.h"

@interface ELConstraintsMaker : NSObject<ELLayoutAttributeProtocol>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithView:(UIView *)view orientation:(ELInterfaceOritation)orientation;
//
- (void)removeAll;
- (void)update;

@end
