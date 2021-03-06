//
//  LoginAnimationController.h
//  TransitionExample
//
//  Created by Ryan Nystrom on 7/12/13.
//  Copyright (c) 2013 Ryan Nystrom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransitionController : NSObject
<UIViewControllerAnimatedTransitioning>

#pragma mark - Properties
@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, assign) CGRect referenceFrame;

@end
