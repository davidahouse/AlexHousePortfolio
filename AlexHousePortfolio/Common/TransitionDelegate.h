//
//  LoginTransitionDelegate.h
//  TransitionExample
//
//  Created by Ryan Nystrom on 9/20/13.
//  Copyright (c) 2013 Ryan Nystrom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransitionDelegate : NSObject
<UIViewControllerTransitioningDelegate>

#pragma mark - Properties
@property (nonatomic,assign) CGRect referenceFrame;

@end
