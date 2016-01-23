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

@property(nonatomic, weak) IBOutlet UIView *testView;
@property(weak, nonatomic) IBOutlet UIView *aView;
@property(weak, nonatomic) IBOutlet UIView *bview;
@property(weak, nonatomic) IBOutlet UIView *cView;

@property (weak, nonatomic) IBOutlet UIButton *remakeButton;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (weak, nonatomic) IBOutlet UIButton *rollbackButton;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initializeLayout];
    [self buttonsLayout];
}

- (void)buttonsLayout {
    [self.remakeButton makeConstraints:^(ELConstraintsMaker *make) {
        make.EL_centerX.equalTo(@0);
        make.EL_centerY.equalTo(@0);
    }];
    [self.updateButton makeConstraints:^(ELConstraintsMaker *make) {
        make.EL_centerX.equalTo(@0);
        make.EL_top.equalTo(self.remakeButton.EL_bottom).offset(10);
    }];
    [self.rollbackButton makeConstraints:^(ELConstraintsMaker *make) {
        make.EL_centerX.equalTo(@0);
        make.EL_top.equalTo(self.updateButton.EL_bottom).offset(10);
    }];
}

- (void)initializeLayout {
  [_testView remakeConstraints:^(ELConstraintsMaker *make) {
    make.EL_width.equalTo(self.view).multiplier(0.5).offset(-10);
    make.EL_height.equalTo(@100);
    make.EL_left.equalTo(@5);
    make.EL_top.equalTo(@5);
  }];

  [_aView remakeConstraints:^(ELConstraintsMaker *make) {
    make.EL_left.equalTo(_testView.EL_right).offset(5);
    make.EL_top.equalTo(_testView);
    make.EL_width.equalTo(_testView);
    make.EL_height.equalTo(_testView);
  }];

  [_bview remakeConstraints:^(ELConstraintsMaker *make) {
    make.EL_left.equalTo(_testView);
    make.EL_top.equalTo(_testView.EL_bottom).offset(5);
    make.EL_width.equalTo(_testView);
    make.EL_height.equalTo(_testView);
  }];
  [_cView remakeConstraints:^(ELConstraintsMaker *make) {
    make.EL_left.equalTo(_bview.EL_right).offset(5);
    make.EL_top.equalTo(_bview.EL_top);
    make.EL_width.equalTo(_testView);
    make.EL_height.equalTo(_testView);
  }];
}

- (IBAction)remakeAction:(id)sender {
  [_testView remakeConstraints:^(ELConstraintsMaker *make) {
    make.EL_height.equalTo(@50);
    make.EL_centerX.equalTo(@0);
    make.EL_centerY.equalTo(@0);
    make.EL_width.equalTo(@200);
  }];
  [self layoutPerformAnimation];
}

- (IBAction)updateAction:(id)sender {
  [_testView updateConstraints:^(ELConstraintsMaker *make) {
    make.EL_height.equalTo(self.view);
    make.EL_width.equalTo(self.view);
  }];

  [self layoutPerformAnimation];
}

- (void)layoutPerformAnimation {
  [self.view setNeedsLayout];
  [UIView animateWithDuration:1.0
                   animations:^{
                     [self.view layoutIfNeeded];
                   }];
}
- (IBAction)rollbackToFirst:(id)sender {
  [self initializeLayout];
  [self layoutPerformAnimation];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
