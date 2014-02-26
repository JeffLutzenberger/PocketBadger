//
//  Notification.m
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Notification.h"


@implementation Notification

- (void) Notify:(UIImageView*)imageView{
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.07];
    
    [UIView setAnimationRepeatAutoreverses:YES];
    
    [UIView setAnimationRepeatCount:2];
    
    imageView.transform = CGAffineTransformMakeRotation(M_PI/-80);
    
    imageView.transform = CGAffineTransformMakeRotation(-M_PI/80);
    
    imageView.transform = CGAffineTransformMakeRotation(0);
    
    [UIView commitAnimations];
    
}

@end
