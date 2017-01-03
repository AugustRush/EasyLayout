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

@property(weak, nonatomic) IBOutlet UIButton *remakeButton;
@property(weak, nonatomic) IBOutlet UIButton *updateButton;
@property(weak, nonatomic) IBOutlet UIButton *rollbackButton;
@property(weak, nonatomic) IBOutlet UIButton *deactiveButton;

@property(nonatomic, weak) NSLayoutConstraint *testRecordConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

//  [self initializeLayout];
  [self buttonsLayout];
}

- (void)buttonsLayout {
    
    [self.remakeButton updateOrMakeConstraints:^(ELConstraintsMaker *make) {
        make.ELCenter.equalTo(@0);
        make.ELSize.equalTo(@[@100,@100]);
    } forOrientation:ELInterfaceOritationLandscape];
    
    [self.remakeButton updateOrMakeConstraints:^(ELConstraintsMaker *make) {
        make.ELCenter.equalTo(@0);
        make.ELSize.equalTo(@[@20,@20]);
    } forOrientation:ELInterfaceOritationPortrait];

    
//    [self.updateButton updateOrMakeConstraints:^(ELConstraintsMaker *make) {
//        make.ELCenterX.equalTo(@0);
//        make.ELTop.equalTo(self.remakeButton.ELBottom).offset(10);
//        make.ELSize.equalTo(self.remakeButton).multipliers(@1.5);
//    }];
//    [self.rollbackButton updateOrMakeConstraints:^(ELConstraintsMaker *make) {
//        make.ELCenterX.equalTo(@0);
//        make.ELTop.equalTo(self.updateButton.ELBottom).offset(10);
//        make.combination(@[ ELCWidth, ELCHeight ])
//        .equalTo(self.remakeButton)
//        .multipliers(@2);
//    }];
//    
//    [self.deactiveButton updateOrMakeConstraints:^(ELConstraintsMaker *make) {
//        make.ELCenterX.equalTo(@0);
//        make.ELTop.equalTo(self.rollbackButton.ELBottom).offset(10);
//        make.ELSize.equalTo(self.rollbackButton).multipliers(@[@1,@2]);
//    }];
}

- (void)initializeLayout {
  [_testView remakeConstraints:^(ELConstraintsMaker *make) {
    make.ELWidth.equalTo(self.view).multiplier(0.5).offset(-10);
    make.ELHeight.equalTo(@100);
    make.ELLeft.equalTo(@5);
    make.ELTop.equalTo(@5);
  }];

  [_aView remakeConstraints:^(ELConstraintsMaker *make) {
    make.ELLeft.equalTo(_testView.ELRight).offset(5);
    make.combination(@[ ELCTop, ELCWidth, ELCHeight ]).equalTo(_testView);
  }];

  [_bview remakeConstraints:^(ELConstraintsMaker *make) {
    make.ELLeft.equalTo(_testView);
    make.ELTop.equalTo(_testView.ELBottom).offset(5);
    make.ELSize.equalTo(_testView);
  }];
  [_cView remakeConstraints:^(ELConstraintsMaker *make) {
    make.combination(@[ ELCLeft, ELCTop ])
        .equalTo(@[ _bview.ELRight, _aView.ELBottom ])
        .offsets(@[ @5, @5 ]);
    make.ELSize.equalTo(_testView);
  }];
}

- (IBAction)remakeAction:(id)sender {
  [_testView remakeConstraints:^(ELConstraintsMaker *make) {
    self.testRecordConstraint = make.ELCenterX.equalTo(@0).constraint();
    make.ELCenterY.equalTo(@0);
    make.ELSize.equalTo(@[ @100, @100 ]);
  }];
  [self layoutPerformAnimation];
}

- (IBAction)updateAction:(id)sender {
  [_testView updateOrMakeConstraints:^(ELConstraintsMaker *make) {
    make.ELSize.equalTo(self.view).offsets(@-10);
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
