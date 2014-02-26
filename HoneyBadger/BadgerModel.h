//
//  BadgerStats.h
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BadgerModel : NSObject {
    
    NSString* path;
    
    NSMutableDictionary* dict;
    
}

@property (copy) NSString *title;

- (id)initWithTitle:(NSString*)title;

- (BOOL)Simulate;

- (int)Ressurect;

- (void)Pet;

- (void)DoublePet; 

- (void)Poke;

- (void)DoublePoke;

- (void)IncrementIntegerBy:(NSString*)key amount:(int)amount;

- (void)IncrementInteger:(NSString*)key;

- (void)DecrementInteger:(NSString*)key;

- (float)IncreaseHunger:(float)amount;

- (float)DecreaseHunger:(float)amount;

- (NSString*)GetName;

- (void)UpdateName:(NSString*)key value:(NSString*)name;

- (float)GetFloatValue:(NSString*)key;

- (NSString*)GetStringValue:(NSString*)key;

- (int)GetTotalPets;

- (int)GetTotalPokes;

- (int)GetGrumpiness;

- (NSDate*)GetDateValue:(NSString*)key;

- (NSString*)GetDateAsString:(NSString*)key;

- (int)count;

- (BOOL)IsMuted;

- (BOOL)ToggleSound;

- (NSString*)CheckAchievements;

- (NSMutableDictionary*)Badges;

@end
