//
//  ZoomOutSegue.m
//  AlexHousePortfolio
//
//  Created by David House on 3/24/14.
//  Copyright (c) 2014 randomaccident. All rights reserved.
//

#import "ZoomOutSegue.h"

@implementation ZoomOutSegue

- (void)perform {
    
    UIViewController *source = self.sourceViewController;
    UIViewController *dest = self.destinationViewController;
    
    [source.view addSubview:dest.view];
    dest.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
    
    CGPoint originalCenter = dest.view.center;
    dest.view.center = self.referencePoint;
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        dest.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        dest.view.center = originalCenter;
    } completion:^(BOOL finished) {
        
        [dest.view removeFromSuperview];
        [source presentViewController:dest animated:NO completion:NULL];
    }];
}

@end
