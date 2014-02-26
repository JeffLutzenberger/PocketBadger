//
//  Reactions.m
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Reactions.h"


@implementation Reactions

- (void) Eat:(UIImageView*)imageView{
    
    [UIView beginAnimations:nil context:nil];

    [UIView setAnimationDuration:0.07];
    
    [UIView setAnimationRepeatAutoreverses:YES];
    
    [UIView setAnimationRepeatCount:2];
    
    imageView.transform = CGAffineTransformMakeRotation(M_PI/-80);
    
    imageView.transform = CGAffineTransformMakeRotation(-M_PI/80);
    
    imageView.transform = CGAffineTransformMakeRotation(0);
    
    [UIView commitAnimations];
    
}

- (void) Happy:(UIImageView*)imageView{
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.08];
    
    [UIView setAnimationRepeatAutoreverses:YES];
    
    [UIView setAnimationRepeatCount:2];
    
    imageView.transform = CGAffineTransformMakeTranslation(0,5);
    
    imageView.transform = CGAffineTransformMakeTranslation(0,0);
    
    [UIView commitAnimations];
    
}

- (void) Snore:(UIImageView*)imageView{
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    anim.duration = 1;
    
    anim.repeatCount = 100000;
    
    anim.autoreverses = YES;
    
    anim.removedOnCompletion = YES;
    
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.025, 1.025, 1.0)];
    
    [imageView.layer addAnimation:anim forKey:@"Snore"];
    
}

- (void) Angry:(UIImageView*)imageView{
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    anim.duration = 0.08;
    
    anim.repeatCount = 0;
    
    anim.autoreverses = YES;
    
    anim.removedOnCompletion = YES;
    
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.7, 1.7, 1.0)];
    
    [imageView.layer addAnimation:anim forKey:@"Snore"];
}
@end
