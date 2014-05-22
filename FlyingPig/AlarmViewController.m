//
//  AlarmViewController.m
//  FlyingPig
//
//  Created by Stenio Ferreira on 5/21/14.
//  Copyright (c) 2014 AvocadoRunner. All rights reserved.
//

#import "AlarmViewController.h"
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

@interface AlarmViewController ()

@end

@implementation AlarmViewController {
    EFCircularSlider* minuteSlider;
    EFCircularSlider* hourSlider;
    int currentHours;
    int currentMinutes;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    currentHours = 12;
    _amPmControlsView.alpha = 0;
    self.view.backgroundColor = [UIColor colorWithRed:22/255.0f green:139/255.0f blue:94/255.0f alpha:1.0f];//[UIColor colorWithRed:31/255.0f green:61/255.0f blue:91/255.0f
    _amPmControlsView.backgroundColor = self.view.backgroundColor;
    _repeatControlsView.backgroundColor = self.view.backgroundColor;
    CGRect minuteSliderFrame;
    if (IS_IPHONE5) {
        minuteSliderFrame = CGRectMake(5, 170, 310, 310);
    } else {
        minuteSliderFrame = CGRectMake(55, 175, 210, 210);
    }
    minuteSlider = [[EFCircularSlider alloc] initWithFrame:minuteSliderFrame];
    minuteSlider.unfilledColor = [UIColor colorWithRed:23/255.0f green:47/255.0f blue:70/255.0f alpha:1.0f];
    minuteSlider.filledColor = [UIColor colorWithRed:155/255.0f green:211/255.0f blue:156/255.0f alpha:1.0f];
    [minuteSlider setInnerMarkingLabels:@[@"5", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55", @"60"]];
    minuteSlider.labelFont = [UIFont systemFontOfSize:14.0f];
    minuteSlider.lineWidth = 8;
    minuteSlider.minimumValue = 0;
    minuteSlider.maximumValue = 60;
    minuteSlider.labelColor = [UIColor colorWithRed:168/255.0f green:238/255.0f blue:171/255.0f alpha:1.0f];
    minuteSlider.handleType = EFDoubleCircleWithOpenCenter;
    minuteSlider.handleColor = minuteSlider.filledColor;
    [self.view addSubview:minuteSlider];
    [minuteSlider addTarget:self action:@selector(minuteDidChange:) forControlEvents:UIControlEventValueChanged];
    minuteSlider.alpha = 0;
    
    CGRect hourSliderFrame;
    if (IS_IPHONE5) {
        hourSliderFrame = CGRectMake(55, 220, 210, 210);;
    } else {
        hourSliderFrame = CGRectMake(105, 225, 110, 110);
    }
    hourSlider = [[EFCircularSlider alloc] initWithFrame:hourSliderFrame];
    hourSlider.unfilledColor = [UIColor colorWithRed:23/255.0f green:47/255.0f blue:70/255.0f alpha:1.0f];
    hourSlider.filledColor = [UIColor colorWithRed:98/255.0f green:243/255.0f blue:252/255.0f alpha:1.0f];
    [hourSlider setInnerMarkingLabels:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"]];
    hourSlider.labelFont = [UIFont systemFontOfSize:14.0f];
    hourSlider.lineWidth = 12;
    hourSlider.snapToLabels = NO;
    hourSlider.minimumValue = 0;
    hourSlider.maximumValue = 12;
    hourSlider.labelColor = [UIColor colorWithRed:127/255.0f green:229/255.0f blue:255/255.0f alpha:1.0f];
    hourSlider.handleType = EFBigCircle;
    hourSlider.handleColor = hourSlider.filledColor;
   // hourSlider.snapToLabels = YES;
    [self.view addSubview:hourSlider];
    [hourSlider addTarget:self action:@selector(hourDidChange:) forControlEvents:UIControlEventValueChanged];
}

-(void)hourDidChange:(EFCircularSlider*)slider {
    currentHours = (int)slider.currentValue ? (int)slider.currentValue : 12;
    NSString* oldTime = _timeLabel.text;
    NSRange colonRange = [oldTime rangeOfString:@":"];
        _timeLabel.text = [NSString stringWithFormat:@"%d:%@", currentHours, [oldTime substringFromIndex:colonRange.location + 1]];
    switch (currentHours) {
        case 1: {
            _timerHoursLabel.text = @"hour";
            break;
        }
        default:{
            _timerHoursLabel.text = @"hours";
            break;
        }
    }
}

-(void)minuteDidChange:(EFCircularSlider*)slider {
    currentMinutes = (int)slider.currentValue < 60 ? (int)slider.currentValue : 0;
    NSString* oldTime = _timeLabel.text;
    NSRange colonRange = [oldTime rangeOfString:@":"];
    _timeLabel.text = [NSString stringWithFormat:@"%@:%02d", [oldTime substringToIndex:colonRange.location], currentMinutes];
}

- (void)resetMinutes
{
    _timeLabel.text = [NSString stringWithFormat:@"%d:00", currentHours];
}
- (IBAction)switchTimerToAlarmAction:(id)sender {
    UISwitch *tempSwitch = (UISwitch *)sender;
    if (tempSwitch.on){
        _timerOrAlarmLabel.text = @"Timer";
        _ringLabel.text = @"Ring in";
        _timerHoursLabel.alpha = 1;
        
        _timerHoursLabel.text = @"hours";
        [_timerOrAlarmLabel sizeToFit];
        [UIView animateWithDuration:0.5 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
            [minuteSlider resetHandle];
            [self resetMinutes];
            minuteSlider.alpha = 0;
            _repeatControlsView.alpha = 1;
            _amPmControlsView.alpha = 0;
        }  completion: ^(BOOL finished){
            
        }];
    }else {
        _timerOrAlarmLabel.text = @"Alarm";
        _ringLabel.text = @"Ring at";
        _timerHoursLabel.alpha = 0;
        [_timerOrAlarmLabel sizeToFit];
        [UIView animateWithDuration:0.5 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
            minuteSlider.alpha = 1;
            _repeatControlsView.alpha = 0;
            _amPmControlsView.alpha = 1;
        }  completion: ^(BOOL finished){
            
        }];
       
    }
}
- (IBAction)changeRepeatTimesAction:(UIStepper *)sender {
    int repeat = sender.value;
    
    switch (repeat) {
        case 0: {
            _repeatLabel.text = @"never";
            break;
        };
        case 1: {
            _repeatLabel.text = [NSString stringWithFormat:@"%i time", repeat];
            break;
        };
        default: {
            _repeatLabel.text = [NSString stringWithFormat:@"%i times", repeat];
            break;
        };
    }
    
    
}
- (IBAction)changeAmPmAction:(id)sender {
    _amLabel.enabled = !_amLabel.enabled;
    _pmLabel.enabled = !_pmLabel.enabled;
}
- (IBAction)cancelButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)setButtonAction:(id)sender {
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
