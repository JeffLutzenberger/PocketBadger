//
//  Reactions.h
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <QuartzCore/QuartzCore.h>

@interface Reactions : NSObject {
    //UIImageView* imageView;
}

-(void)Eat:(UIImageView*)imageView;

-(void)Snore:(UIImageView*)imageView;

-(void)Happy:(UIImageView*)imageView;

-(void)Angry:(UIImageView*)imageView;

@end
