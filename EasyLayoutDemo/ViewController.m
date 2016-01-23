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
@property (weak, nonatomic) IBOutlet UIView *aView;
@property (weak, nonatomic) IBOutlet UIView *bview;
@property (weak, nonatomic) IBOutlet UIView *cView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [_testView makeConstraints:^(ELConstraintsMaker *make) {
    make.EL_height.equalTo(self.view).multiplier(0.5).offset(-200);
    make.EL_left.equalTo(self.view).multiplier(2.0).offset(100);
    make.EL_right.equalTo(@-50);
    make.EL_centerY.equalTo(@-100);
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

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
