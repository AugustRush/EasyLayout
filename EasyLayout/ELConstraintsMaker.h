//
//  ELCondtraintsMaker.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/9/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ELLayoutConstraintModel.h"
#import <UIKit/UIKit.h>
#import "ELLayoutAttributeProtocol.h"

@interface ELConstraintsMaker : NSObject<ELLayoutAttributeProtocol>

@property(nonatomic, assign) BOOL isUpdating;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithView:(UIView *)view;

- (void)install;
- (void)removeAll;
- (void)update;

@end
