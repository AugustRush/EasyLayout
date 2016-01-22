//
//  ViewController.m
//  EasyLayoutDemo
//
//  Created by AugustRush on 11/18/15.
//  Copyright © 2015 AugustRush. All rights reserved.
//

#import "UIView+EasyLayout.h"
#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIView *testView = [[UIView alloc] init];
  testView.backgroundColor = [UIColor redColor];
  [self.view addSubview:testView];

  self.testView = testView;

  [testView ELContraintsMake:^(ELConstraintsMaker *make) {
    make.EL_height.equalTo(self.view).multiplier(0.5).offset(-200);
    make.EL_left.equalTo(self.view).multiplier(2.0).offset(100);
    make.EL_right.equalTo(@-50);
    make.EL_centerY.equalTo(@-100);
  }];
}

- (IBAction)remakeAction:(id)sender {
  [_testView ELContraintsRemake:^(ELConstraintsMaker *make) {
    make.EL_height.equalTo(@100);
    make.EL_centerX.equalTo(@0);
    make.EL_centerY.equalTo(@0);
    make.EL_width.equalTo(@200);
  }];

  [self.view setNeedsLayout];
  [UIView animateWithDuration:1.0
                   animations:^{
                     [self.view layoutIfNeeded];
                   }];
}

- (IBAction)updateAction:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
