//
//  SecondViewController.h
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BadgerModel.h"

@interface SecondViewController : UIViewController {
    
    BadgerModel *badger;
    
    UIImage* angelIcon;
    
    UIImage* devilIcon;
    
}

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UILabel *age;
@property (nonatomic, retain) IBOutlet UILabel *born;
@property (nonatomic, retain) IBOutlet UILabel *resurrections;
@property (nonatomic, retain) IBOutlet UILabel *cobras;
@property (nonatomic, retain) IBOutlet UILabel *bees;
@property (nonatomic, retain) IBOutlet UILabel *fingers;
@property (nonatomic, retain) IBOutlet UILabel *hands;
@property (nonatomic, retain) IBOutlet UILabel *pets;
@property (nonatomic, retain) IBOutlet UILabel *pokes;
@property (nonatomic, retain) IBOutlet UIButton *grumpiness;


@end
