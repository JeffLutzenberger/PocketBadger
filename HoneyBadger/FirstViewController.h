//
//  FirstViewController.h
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import "BadgerModel.h"

#import "Reactions.h"

#import "SoundEffects.h"

@interface FirstViewController : UIViewController {

    bool isAsleep;
    
    int happiness;
    
    int consecutivePets;
    
    //Badger model
    BadgerModel *badger;
    
    //icon images
    UIImage* heartImage;
    UIImage* sleepIcon;
    UIImage* angelIcon;
    UIImage* devilIcon;
    UIImage* soundOnIcon;
    UIImage* soundOffIcon;
    
    //button rectangles
    CGRect cobraButtonFrame;
    CGRect beeButtonFrame;
    CGRect notifyButtonFrame;
    
    //helper classes
    Reactions* reactions;
    SoundEffects* soundEffects;
    NSTimer* timer;
    
    //message box
    UIAlertView *alertWithOkButton;
    
    //badger images
    UIImage* badgerAwake;
    UIImage* badgerSleeping;
    UIImage* badgerHappy;
    UIImage* badgerReallyHappy;
    UIImage* badgerAngry;
    
}

@property (nonatomic, retain) IBOutlet UIImageView *badgerView;

@property (nonatomic, retain) IBOutlet UILabel *messageBox;
@property (nonatomic, retain) IBOutlet UIButton *notifyBox;

@property (nonatomic, retain) IBOutlet UIButton *mood;
@property (nonatomic, retain) IBOutlet UILabel *age;
@property (nonatomic, retain) IBOutlet UIProgressView *hunger;
@property (nonatomic, retain) IBOutlet UIProgressView *grumpiness;
@property (nonatomic, retain) IBOutlet UIButton *grumpBarAngel;
@property (nonatomic, retain) IBOutlet UIButton *grumpBarDevil;

@property (nonatomic, retain) IBOutlet UIButton *leftEar;
@property (nonatomic, retain) IBOutlet UIButton *rightEar;
@property (nonatomic, retain) IBOutlet UIButton *forehead;
@property (nonatomic, retain) IBOutlet UIButton *chin;

@property (nonatomic, retain) IBOutlet UIButton *leftEye;
@property (nonatomic, retain) IBOutlet UIButton *rightEye;
@property (nonatomic, retain) IBOutlet UIButton *mouth;

@property (nonatomic, retain) IBOutlet UIButton *cobraButton;
@property (nonatomic, retain) IBOutlet UIButton *beesButton;
@property (nonatomic, retain) IBOutlet UIButton *aboutButton;
@property (nonatomic, retain) IBOutlet UIButton *muteButton;

//@property (nonatomic, retain) IBOutlet UIToolbar *bottomToolBar;

- (IBAction)Pet:(id)sender;
- (IBAction)DoublePet:(id)sender;

- (IBAction)Poke:(id)sender;
- (IBAction)DoublePoke:(id)sender;

- (IBAction)FeedCobra:(id)sender;
- (IBAction)FeedBees:(id)sender;

- (IBAction)SoundButtonClick:(id)sender;

- (void)SleepBadger:(bool)showMessage;
- (void)WakeBadger;

- (void)SetMessage:(NSString*)message;
- (void)SetHungerBar;
- (void)SetGrumpyBar;

- (void)Resurrect;

- (void)CheckAchievement;

- (void)Notify:(NSString*)message;

-(IBAction) About:(id)sender;

@end
