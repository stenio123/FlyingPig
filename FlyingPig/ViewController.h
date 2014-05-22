//
//  ViewController.h
//  FlyingPig
//
//  Created by Stenio Ferreira on 5/20/14.
//  Copyright (c) 2014 AvocadoRunner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeSetupProtocol.h"

@interface ViewController : UIViewController <TimeSetupProtocol>

@property (weak, nonatomic) IBOutlet UIImageView *wingUiImage;
@property (weak, nonatomic) IBOutlet UIButton *flyButton;
@property (weak, nonatomic) IBOutlet UIView *wingViewReverse;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *horizontalWingToViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *horizontalReverseWingToViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *horizontalPigToViewConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalWingToTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalReverseWingToTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalPigToTopConstraint;

@end
