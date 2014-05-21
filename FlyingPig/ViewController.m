//
//  ViewController.m
//  FlyingPig
//
//  Created by Stenio Ferreira on 5/20/14.
//  Copyright (c) 2014 AvocadoRunner. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

bool isFlying;
UIImageView *reverseWing;

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = _wingUiImage.frame;
    reverseWing = [[UIImageView alloc]initWithFrame:frame];
    UIImage *reverseWingImage = [UIImage imageWithCGImage: _wingUiImage.image.CGImage scale: 1.0f orientation: UIImageOrientationDownMirrored];
    
    reverseWing.image = reverseWingImage;
    reverseWing.alpha = 0;
    [_wingViewReverse addSubview:reverseWing];
}


- (IBAction)flyButtonAction:(id)sender {
    if(!isFlying) {
        isFlying = YES;
        [_flyButton setTitle:@"Stop this nonsense!" forState:UIControlStateNormal];
        [_flyButton sizeToFit];
    } else {
        isFlying = NO;
        [_flyButton setTitle:@"Fly away!" forState:UIControlStateNormal];
    }
    
    [self flappingShouldStart:isFlying];
    
}

- (void)flappingShouldStart:(BOOL)start
{
    if (start){
                [UIView animateWithDuration:0.2 delay:0 options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat) animations:^{
                    _wingUiImage.alpha = 0;
                    reverseWing.alpha = 1;
                }  completion: ^(BOOL finished){
                 
                }];
    } else {
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear animations:^{
            _wingUiImage.alpha = 1;
            reverseWing.alpha = 0;
        } completion:NULL];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
