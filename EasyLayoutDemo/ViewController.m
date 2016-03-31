//
//  ViewController.m
//  EasyLayoutDemo
//
//  Created by AugustRush on 11/18/15.
//  Copyright © 2015 AugustRush. All rights reserved.
//

#import "EasyLayout.h"
#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, weak) IBOutlet UIView *testView;
@property(weak, nonatomic) IBOutlet UIView *aView;
@property(weak, nonatomic) IBOutlet UIView *bview;
@property(weak, nonatomic) IBOutlet UIView *cView;

@property (weak, nonatomic) IBOutlet UIButton *remakeButton;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (weak, nonatomic) IBOutlet UIButton *rollbackButton;
@property (weak, nonatomic) IBOutlet UIButton *deactiveButton;

@property (nonatomic, weak) NSLayoutConstraint *testRecordConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initializeLayout];
    [self buttonsLayout];
    
}

- (void)buttonsLayout {
    [self.remakeButton makeConstraints:^(ELConstraintsMaker *make) {
        make.centerXY.equalTo(@0);
    }];
    [self.updateButton makeConstraints:^(ELConstraintsMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.remakeButton.bottom).offset(10);
        make.size.equalTo(self.remakeButton).multipliers(@1.5);
    }];
    [self.rollbackButton makeConstraints:^(ELConstraintsMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.updateButton.bottom).offset(10);
//        make.size.equalTo(self.remakeButton).multiplier(2);
        make.combination(@[ELWidth,ELHeight]).equalTo(self.remakeButton).multipliers(@2);
    }];
}

- (void)initializeLayout {
  [_testView remakeConstraints:^(ELConstraintsMaker *make) {
    make.width.equalTo(self.view).multiplier(0.5).offset(-10);
    make.height.equalTo(@100);
    make.left.equalTo(@5);
    make.top.equalTo(@5);
  }];

  [_aView remakeConstraints:^(ELConstraintsMaker *make) {
    make.left.equalTo(_testView.right).offset(5);
    make.top.equalTo(_testView);
    make.size.equalTo(_testView);
  }];

  [_bview remakeConstraints:^(ELConstraintsMaker *make) {
    make.left.equalTo(_testView);
    make.top.equalTo(_testView.bottom).offset(5);
      make.size.equalTo(_testView);
  }];
  [_cView remakeConstraints:^(ELConstraintsMaker *make) {
    make.left.equalTo(_bview.right).offset(5);
    make.top.equalTo(_bview.top);
      make.combination(@[ELLeft,ELTop]).equalTo(_bview.combination(@[ELRight,ELTop])).offsets(@[@5,@0]);
      make.size.equalTo(_testView);
  }];
}

- (IBAction)remakeAction:(id)sender {
  [_testView remakeConstraints:^(ELConstraintsMaker *make) {
    self.testRecordConstraint = make.centerX.equalTo(@0).constraint();
    make.centerY.equalTo(@0);
      make.size.equalTo(@[@200,@100]);
  }];
  [self layoutPerformAnimation];
}

- (IBAction)updateAction:(id)sender {
  [_testView updateConstraints:^(ELConstraintsMaker *make) {
      make.size.equalTo(self.view).offsets(@-10);
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

- (IBAction)deactiveAction:(id)sender {
    [self.testRecordConstraint setActive:NO];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
