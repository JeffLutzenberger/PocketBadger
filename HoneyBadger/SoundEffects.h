//
//  SoundEffects.h
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@interface SoundEffects : NSObject {
    
    AVAudioPlayer* player;
    
    NSData* bite;
    
    NSData* happy;
    
    NSData* snore;
    
    BOOL mute;
}


- (id)init:(BOOL)muteIsOn;

- (void)SetMute:(BOOL)muteIsOn;

- (void)Bite;

- (void)Happy;

- (void)Feed;

- (void)Snore;

@end
