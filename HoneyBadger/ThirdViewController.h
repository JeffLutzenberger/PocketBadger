//
//  ThirdViewController.h
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BadgerModel.h"

@interface ThirdViewController : UIViewController {
    
    
    BadgerModel *badger;
    
    NSMutableArray* badges;
    
    UIImage* badgeImage;
    
    IBOutlet UITableView *badgesTable;
    
}


@end
