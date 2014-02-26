//
//  SoundEffects.m
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SoundEffects.h"
#import <AudioToolbox/AudioToolbox.h>


@implementation SoundEffects

- (id)init:(BOOL)muteIsOn{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bite" ofType:@"mp3"];  
    
    bite = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]];
    
    path = [[NSBundle mainBundle] pathForResource:@"happy" ofType:@"mp3"];  
    
    happy = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]];
    
    path = [[NSBundle mainBundle] pathForResource:@"snore" ofType:@"mp3"];  
    
    snore = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]];
    
    mute = muteIsOn;
    
    return self;
}

- (void)dealloc{
    
    [super dealloc];
    
    if( player != nil && [player isPlaying] ){
        
        [player stop];
        
        [player release];
    }
    
    [bite release];
    
    [happy release];
    
    [snore release];
    
}
- (void)Play:(NSData*)soundData
{
    if( mute ) return;
    
    if( player != nil && [player isPlaying] ){
        
        [player stop];
        
        [player release];
    }
    
    player = [[AVAudioPlayer alloc] initWithData:soundData error:nil];
    
    player.numberOfLoops = 0;
    
    [player prepareToPlay];
    
    //[player setDelegate: self];
    
    [player play];
}

- (void)SetMute:(BOOL)muteIsOn
{
    mute = muteIsOn;
    if( player != nil )
    {
        if( muteIsOn == YES ) [player setVolume:0];
        else if(player != nil) [player setVolume:1];
    }
}

- (void)Bite
{
    [self Play:bite];
}

- (void)Happy
{
    [self Play:happy];
}

- (void)Feed
{
    [self Play:happy];
}

- (void)Snore
{
    [self Play:snore];
}


@end
