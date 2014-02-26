//
//  BadgerStats.m
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BadgerModel.h"

@implementation BadgerModel

@synthesize title = _title;

//hunger rate %/hour
double HUNGER_RATE = 0.028;

- (id)initWithTitle:(NSString*)title{
    
    if ((self = [super init])) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentPath = [[paths objectAtIndex:0] stringByAppendingString:@"/MyBadger.plist"];
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource: @"MyBadger" ofType:@"plist"];
    
        dict = [[NSMutableDictionary alloc] initWithContentsOfFile:documentPath];
        
        NSError *error;
        
        bool isNew = ([dict count]  <= 0);
        
        if( isNew ){
            
            //copy plist ot document directory...
            NSLog(@"empty plist");
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            BOOL success = [fileManager copyItemAtPath:bundlePath toPath:documentPath error:&error];
            
            if (!success) {
                
                NSAssert1(0, @"Failed to copy Plist. Error %@", [error localizedDescription]);
            
            }
            
        }
        
        dict = [[NSMutableDictionary alloc] initWithContentsOfFile:documentPath];
        
        if( [dict count]  <= 0 ){
            
            NSAssert1(0, @"Failed to copy Plist. Error %@", [error localizedDescription]);
        
        }
        
        if( isNew )
        {
            [dict setValue:[NSDate date] forKey:@"birthday"];
            
            [dict setValue:[NSDate date] forKey:@"last_resurrection"];
            
            [dict writeToFile:path atomically:YES];
        }
        
        path = [[NSString alloc] initWithString:documentPath];
        
    }
    
    return self;
}

- (void)dealloc {
    
    [dict release];
    
    [path release];
    
    [super dealloc];
}

- (BOOL)Simulate{
    
    //get last visited date
    NSDate* last_visit = [self GetDateValue:@"last_visit"];
    
    NSLog([self GetDateAsString:@"last_visit"]);
    
    NSTimeInterval last = -1*[last_visit timeIntervalSinceNow];
    
    double delta_hunger = HUNGER_RATE * (double)last / 60 / 60;
    
    NSLog([NSString stringWithFormat:@"Hunger increased by: %f", delta_hunger]);
    
    double hunger = [self IncreaseHunger:(float)delta_hunger];
    
    [dict setValue:[NSDate date] forKey:@"last_visit"];
    
    [dict writeToFile:path atomically:YES];
    
    //if hunger >= 1.0 then badger dies
    if( hunger >= 1.0 )
    {
        return FALSE;
    }
    
    return TRUE;
}

- (int)Ressurect
{
    [dict setValue:[NSNumber numberWithFloat:0.0] forKey:@"hunger"];
    
    [dict setValue:[NSDate date] forKey:@"last_resurrection"];
    
    [dict writeToFile:path atomically:YES];
    
    [self IncrementInteger:@"resurrections"];
    
    return [[dict objectForKey:@"resurrections"] intValue];
}

- (void)Pet{
    [self IncrementIntegerBy:@"pets" amount:1];
}

- (void)DoublePet{
    [self IncrementIntegerBy:@"double_pets" amount:1];
}


- (void)Poke{
    [self IncrementIntegerBy:@"pokes" amount:1];
}


- (void)DoublePoke{
    [self IncrementIntegerBy:@"double_pokes" amount:1];
}


- (void)IncrementIntegerBy:(NSString*)key amount:(int)amount{
    
    int item = 1;
    if( [dict objectForKey:key] != NULL )
        item = [(NSNumber*)[dict objectForKey:key] intValue] + amount;
         
    [dict setValue:[NSNumber numberWithInt:item] forKey:key];
         
    [dict writeToFile:path atomically:YES];
}

- (void)IncrementInteger:(NSString*)key{
    
    int item = 1;
    
    if( [dict objectForKey:key] != NULL )
        item = [(NSNumber*)[dict objectForKey:key] intValue] + 1;
    
    [dict setValue:[NSNumber numberWithInt:item] forKey:key];
    
    [dict writeToFile:path atomically:YES];

}

- (void)DecrementInteger:(NSString*)key{
    
    int item = 0;
    
    if( [dict objectForKey:key] != NULL )
        item = [(NSNumber*)[dict objectForKey:key] intValue] - 1;
    
    [dict setValue:[NSNumber numberWithInt:item] forKey:key];
    
    [dict writeToFile:path atomically:YES];
    
}

- (float)IncreaseHunger:(float)amount{

    float value = [(NSNumber*)[dict objectForKey:@"hunger"] floatValue] + amount;
    
    if( value >= 1.0 ){
        NSLog(@"*************************");
        NSLog(@"Your Honey Badger's Dead!");
        NSLog(@"*************************");
    }
        
    //float value = MIN([(NSNumber*)[dict objectForKey:@"hunger"] floatValue] + amount, 1.0);
    
    [dict setValue:[NSNumber numberWithFloat:value] forKey:@"hunger"];
    
    [dict writeToFile:path atomically:YES];
    
    [self Poke];
    
    return value;
    
}

- (float)DecreaseHunger:(float)amount{ 
    
    float value = [(NSNumber*)[dict objectForKey:@"hunger"] floatValue] - amount;
    
    if (value <= 0.0) {
        value = 0.0;
    }
    //float value = MAX([(NSNumber*)[dict objectForKey:@"hunger"] floatValue] - amount, 0.0);
    
    [dict setValue:[NSNumber numberWithFloat:value] forKey:@"hunger"];
    
    [dict writeToFile:path atomically:YES];
    
    return value;
    
}

- (NSString*)GetName
{
    return [dict objectForKey:@"name"]; 
}

- (void)UpdateName:(NSString*)key value:(NSString*)name{
    
    [dict setValue:name forKey:@"name"];
    
    [dict writeToFile:path atomically:YES];
}

- (float)GetFloatValue:(NSString *)key
{
    return [(NSNumber*)[dict objectForKey:key] floatValue];
}

- (NSString*)GetStringValue:(NSString*)key
{
    return [[dict objectForKey:key] stringValue];
}

- (int)GetTotalPets
{
    //add pets and double pets
    int pets = [[dict objectForKey:@"pets"] intValue];
    
    int double_pets = [[dict objectForKey:@"double_pets"] intValue];
    
    return pets + double_pets * 2;
}

- (int)GetTotalPokes
{
    //add pets and double pets
    int pokes = [[dict objectForKey:@"pokes"] intValue];
    
    int double_pokes = [[dict objectForKey:@"double_pokes"] intValue];
    
    return pokes + double_pokes * 2;
}

- (int)GetGrumpiness
{
    //note: pokes are weight more than pets
    double pokes = (double)[self GetTotalPokes]*1.5;
    
    if( pokes <= 0 ) return 0;
    
    double pets = (double)[self GetTotalPets];
    
    //int grumpy = (int)(100*pokes/(pets+pokes));
    
    //[dict setValue:[NSNumber numberWithInt:grumpy] forKey:@"last_grumpy"];
    
    //[dict writeToFile:path atomically:YES];
    
    return (int)(100*pokes/(pets+pokes));
    
}

- (NSDate*)GetDateValue:(NSString*)key
{
    return (NSDate*)[dict objectForKey:key];
}

- (NSString*)GetDateAsString:(NSString*)key
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    return [dateFormatter stringFromDate:[dict objectForKey:key]];
}

- (int)count
{
    if(dict == nil ) return 0;
    
    return [dict count];
}

- (BOOL)IsMuted
{
    BOOL muteIsOn = NO;
    
    if( [dict objectForKey:@"mute"] )
        muteIsOn = [[dict objectForKey:@"mute"] boolValue]; 
    
    return muteIsOn;
}

- (BOOL)ToggleSound
{
    BOOL muteIsOn = NO;
    
    if( [dict objectForKey:@"mute"] )
        muteIsOn = [[dict objectForKey:@"mute"] boolValue];
    
    muteIsOn = (muteIsOn ? NO : YES);
    
    [dict setValue:[NSNumber numberWithBool:muteIsOn] forKey:@"mute"];
    
    [dict writeToFile:path atomically:YES];
    
    return muteIsOn;
}

- (NSString*)AddBadge:(NSString*)key{
    
    NSMutableDictionary* badges = [dict objectForKey:@"badges"];
    
    if( badges == Nil ){ 
        
        badges = [[NSMutableDictionary alloc] init];
        
        [dict setObject:badges forKey:@"badges"];
        
        [dict writeToFile:path atomically:YES];

    }
    
    if( [badges objectForKey:key] == Nil){
        //add 1 day old badge
        
        [badges setValue:[NSNumber numberWithInt:1] forKey:key];
    
        [dict setValue:badges forKey:@"badges"];
        
        [dict writeToFile:path atomically:YES];
        
        return [NSString stringWithFormat:@"You earned the %@ Badge!", key];
    }
    return Nil;
}
                
- (NSString*)CheckAchievements
{
    //age (since last resurrection)
    //==============================
    NSDate* resurrectionDate = [self GetDateValue:@"last_resurrection"];
    
    double myAgeDays = (double)(-1*[resurrectionDate timeIntervalSinceNow]) /60/60/24;
    
    int days = (int)(floor(myAgeDays));
    
    if( days >= 1 ){
        NSString* str = [self AddBadge:@"One Day Old"];
        if (str != Nil) return str;
    }
    
    if( days >= 10 ){
        NSString* str = [self AddBadge:@"Ten Day Old"];
        if (str != Nil) return str;
    }
    
    if( days >= 30 ){
        NSString* str = [self AddBadge:@"One Month Old"];
        if (str != Nil) return str;
    }
    
    if( days >= 365 ){
        NSString* str = [self AddBadge:@"One Year Old"];
        if (str != Nil) return str;
    }
    
    //resurrections
    //================
    int resurrections = [[dict objectForKey:@"resurrections"] intValue];
    
    if( resurrections >= 1 ){
        NSString* str = [self AddBadge:@"First Resurrection"];
        if (str != Nil) return str;
    }
    
    if( resurrections >= 5 ){
        NSString* str = [self AddBadge:@"Five Resurrections"];
        if (str != Nil) return str;
    }
    
    if( resurrections >= 10 ){
        NSString* str = [self AddBadge:@"Ten Resurrections"];
        if (str != Nil) return str;
    }
    
    if( resurrections >= 50 ){
        NSString* str = [self AddBadge:@"100 Resurrections"];
        if (str != Nil) return str;
    }
    
    //grumpiness
    //================
    int grump = [self GetGrumpiness];
    if( grump >= 50 ){
        NSString* str = [self AddBadge:@"Grumpy Badger"];
        if (str != Nil) return str;
    }
        
    if( grump < 50 ){
        NSString* str = [self AddBadge:@"Happy Badger"];
        if (str != Nil) return str;
    }
    
    //feeding
    //================
    int cobras = [[dict objectForKey:@"cobras"] intValue];
    int bees = [[dict objectForKey:@"bees"] intValue];
    
    if( cobras > 0 || bees > 0 ){
        NSString* str = [self AddBadge:@"First Feeding"];
        if (str != Nil) return str;
    }
    
    if( cobras > 100 ){
        NSString* str = [self AddBadge:@"100 Cobras"];
        if (str != Nil) return str;
    }
    
    if( cobras > 500 ){
        NSString* str = [self AddBadge:@"500 Cobras"];
        if (str != Nil) return str;
    }
    
    if( cobras > 1000 ){
        NSString* str = [self AddBadge:@"1000 Cobras"];
        if (str != Nil) return str;
    }
    
    if( bees > 100 ){
        NSString* str = [self AddBadge:@"100 Bees"];
        if (str != Nil) return str;
    }
    
    if( bees > 500 ){
        NSString* str = [self AddBadge:@"500 Bees"];
        if (str != Nil) return str;
    }
    
    if( bees > 1000 ){
        NSString* str = [self AddBadge:@"1000 Bees"];
        if (str != Nil) return str;
    }
    
    int hands = [[dict objectForKey:@"hands"] intValue];
    int fingers = [[dict objectForKey:@"fingers"] intValue];
    
    if( hands >= 1 ){
        NSString* str = [self AddBadge:@"First Hand"];
        if (str != Nil) return str;
    }
    
    if( fingers >= 1 ){
        NSString* str = [self AddBadge:@"First Finger"];
        if (str != Nil) return str;
    }
    
    return Nil;
    
}

- (NSMutableDictionary*)Badges{
    
    NSMutableDictionary* badges = [dict objectForKey:@"badges"];
    
    if( badges == Nil ){ 
        
        badges = [[NSMutableDictionary alloc] init];
        
        [dict setObject:badges forKey:@"badges"];
        
        [dict writeToFile:path atomically:YES];
        
    }
    
    return badges;
    
}
@end
