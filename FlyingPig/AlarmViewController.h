//
//  AlarmViewController.h
//  FlyingPig
//
//  Created by Stenio Ferreira on 5/21/14.
//  Copyright (c) 2014 AvocadoRunner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFCircularSlider.h"
#import "TimeSetupProtocol.h"

@interface AlarmViewController : UIViewController {
    BOOL isAlarmOn;
}
@property (weak, nonatomic) IBOutlet UILabel *ringLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerHoursLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerOrAlarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *repeatLabel;
@property (weak, nonatomic) IBOutlet UIView *repeatControlsView;
@property (weak, nonatomic) IBOutlet UILabel *amLabel;
@property (weak, nonatomic) IBOutlet UILabel *pmLabel;
@property (weak, nonatomic) IBOutlet UIView *amPmControlsView;

@end
