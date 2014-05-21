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

CGPoint distanceWingFromPig, distanceReverseWingFromPig, originalPosition;//move these to the model class

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = _wingUiImage.frame;
    reverseWing = [[UIImageView alloc]initWithFrame:frame];
    UIImage *reverseWingImage = [UIImage imageWithCGImage: _wingUiImage.image.CGImage scale: 1.0f orientation: UIImageOrientationDownMirrored];
    
    reverseWing.image = reverseWingImage;
    reverseWing.alpha = 0;
    [_wingViewReverse addSubview:reverseWing];
    
    [self calculateImageDistances];
}

//move this to the model class
- (void)calculateImageDistances
{
    distanceWingFromPig.x = _horizontalWingToViewConstraint.constant - _horizontalPigToViewConstraint.constant;
    distanceReverseWingFromPig.x = _horizontalReverseWingToViewConstraint.constant - _horizontalPigToViewConstraint.constant;
    
    distanceWingFromPig.y = _verticalWingToTopConstraint.constant - _verticalPigToTopConstraint.constant;
    distanceReverseWingFromPig.y = _verticalReverseWingToTopConstraint.constant - _verticalPigToTopConstraint.constant;
    
    originalPosition.x = _horizontalPigToViewConstraint.constant;
    originalPosition.y = _verticalPigToTopConstraint.constant;
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
    
    [self moveAround:isFlying];
    
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

- (void)moveAround:(BOOL)start
{
    if (start){
        // update constraints
        [UIView animateWithDuration:0.8 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
            //for explanation of arc4random http://iphonedevelopment.blogspot.com/2008/10/random-thoughts-rand-vs-arc4random.html
            CGFloat movedX = arc4random() % 200 + 1;
            CGFloat movedY = arc4random() % 460 + 1;
            
            _horizontalPigToViewConstraint.constant = movedX;
            _horizontalWingToViewConstraint.constant = movedX + distanceWingFromPig.x;
            _horizontalReverseWingToViewConstraint.constant = movedX + distanceReverseWingFromPig.x;
            _verticalPigToTopConstraint.constant = movedY;
            _verticalWingToTopConstraint.constant = movedY + distanceWingFromPig.y;
            _verticalReverseWingToTopConstraint.constant = movedY + distanceReverseWingFromPig.y;
            
            [self.view layoutIfNeeded];
        }  completion: ^(BOOL finished){
            if (finished) {
                [self moveAround:start];
            }
        }];
    } else {
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear animations:^{
            CGFloat movedX = originalPosition.x;
            CGFloat movedY = originalPosition.y;
            
            _horizontalPigToViewConstraint.constant = movedX;
            _horizontalWingToViewConstraint.constant = movedX + distanceWingFromPig.x;
            _horizontalReverseWingToViewConstraint.constant = movedX + distanceReverseWingFromPig.x;
            _verticalPigToTopConstraint.constant = movedY;
            _verticalWingToTopConstraint.constant = movedY + distanceWingFromPig.y;
            _verticalReverseWingToTopConstraint.constant = movedY + distanceReverseWingFromPig.y;
            
            [self.view layoutIfNeeded];
        }  completion: ^(BOOL finished){
            
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
