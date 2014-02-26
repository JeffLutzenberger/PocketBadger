//
//  Badges.h
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


//this class keeps track of achievements.
//probably should be part of the Badger model class as it will write achievments to the plist file
@interface Badge : NSObject {
    //action occurs -> check badge conditions
    //badge name
    //badge score
    NSString* name;
    int score;
}

- (id)init:(NSString*)badgeName;

@end
