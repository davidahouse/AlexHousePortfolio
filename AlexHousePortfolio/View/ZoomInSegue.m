//
//  ZoomInSegue.m
//  AlexHousePortfolio
//
//  Created by David House on 3/24/14.
//  Copyright (c) 2014 randomaccident. All rights reserved.
//

#import "ZoomInSegue.h"

@implementation ZoomInSegue

- (void)perform {
    
    UIViewController *source = self.sourceViewController;
   // UIViewController *dest = self.destinationViewController;
    
    //[source.view.superview insertSubview:dest.view atIndex:0];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        source.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
        source.view.center = self.targetPoint;
        
    } completion:^(BOOL finished) {
        
      //  [dest.view removeFromSuperview];
        [source dismissViewControllerAnimated:NO completion:NULL];
    }];
}


@end
