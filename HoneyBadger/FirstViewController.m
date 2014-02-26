//
//  FirstViewController.m
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

#import <AudioToolbox/AudioToolbox.h>


@implementation FirstViewController

@synthesize badgerView;

@synthesize messageBox;
@synthesize notifyBox;

@synthesize mood;
@synthesize age;
@synthesize hunger;
@synthesize grumpiness;
@synthesize grumpBarAngel;
@synthesize grumpBarDevil;

@synthesize leftEar;
@synthesize rightEar;
@synthesize forehead;
@synthesize chin;

@synthesize leftEye;
@synthesize rightEye;
@synthesize mouth;

@synthesize cobraButton;
@synthesize beesButton;
@synthesize aboutButton;
@synthesize muteButton;

//@synthesize bottomToolBar;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    heartImage = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/heart.png", [[NSBundle mainBundle] bundlePath]]];
    
    sleepIcon = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/sleep.png", [[NSBundle mainBundle] bundlePath]]];
    
    angelIcon = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/angel.png", [[NSBundle mainBundle] bundlePath]]];
    
    devilIcon = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/devil.png", [[NSBundle mainBundle] bundlePath]]];
    
    soundOnIcon = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/speaker.png", [[NSBundle mainBundle] bundlePath]]];
    
    soundOffIcon = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/speaker-off.png", [[NSBundle mainBundle] bundlePath]]];
    
    devilIcon = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/devil.png", [[NSBundle mainBundle] bundlePath]]];
    
    //badger images
    badgerAwake = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/badger-awake-scaled.png", [[NSBundle mainBundle] bundlePath]]];
    
    badgerSleeping = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/badger-sleeping-scaled.png", [[NSBundle mainBundle] bundlePath]]];
    
    badgerHappy = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/badger-happy-scaled.png", [[NSBundle mainBundle] bundlePath]]];
    
    badgerReallyHappy = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/badger-really-happy-scaled.png", [[NSBundle mainBundle] bundlePath]]];
    
    badgerAngry = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/badger-angry-scaled.png", [[NSBundle mainBundle] bundlePath]]];
    
    reactions = [Reactions alloc];
    
    badger = [[BadgerModel alloc] initWithTitle:@"BadgerStats"];
    
    BOOL isMuted = [badger IsMuted];
    
    soundEffects = [[SoundEffects alloc] init:isMuted];
    
    //set mute icon
    if( isMuted ) [muteButton setImage:soundOffIcon forState:UIControlStateNormal];
                   
    alertWithOkButton = [[UIAlertView alloc] initWithTitle:@"My Pocket Badger"
												   message:@"" 
												  delegate:self 
										 cancelButtonTitle:@"OK" 
										 otherButtonTitles:nil];
    //set food button delegates
    
    cobraButtonFrame = [cobraButton frame];
    cobraButtonFrame.origin.y = 280;
    
    [cobraButton addTarget:self action:@selector(cobraMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    
    [cobraButton addTarget:self action:@selector(cobraReleased:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    beeButtonFrame = [beesButton frame];
    beeButtonFrame.origin.y = 280;
    
    [beesButton addTarget:self action:@selector(beeMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    
    [beesButton addTarget:self action:@selector(beeReleased:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    notifyButtonFrame = [notifyBox frame];
    
    [self SleepBadger:true];
    
    [self SetHungerBar];
    
    [self SetGrumpyBar];
    
    happiness = 0;
    
    consecutivePets = 0;
    
    BOOL isAlive = [badger Simulate];
    
    if( !isAlive )
    {
        [self Resurrect];        
    }
    //start our life timer
    timer = [NSTimer scheduledTimerWithTimeInterval:60
	                                         target:self
	                                       selector:@selector(SimulateLife)
	                                       userInfo:nil
	                                        repeats:YES];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    //badger images
    [badgerAwake release];
    
    [badgerSleeping release];
    
    [badgerHappy release];
    
    [badgerReallyHappy release];
    
    [heartImage release];
    
    [sleepIcon release];
    
    [angelIcon release];
    
    [devilIcon release];
    
    [badger release];
    
    [reactions release];
    
    [soundEffects release];
    
    [super dealloc];
}

- (IBAction)SoundButtonClick:(id)sender{
    //get sound setting then toggle it...
    BOOL isMuted = [badger ToggleSound];
    
    [soundEffects SetMute:isMuted];
    
    //set mute icon
    if( isMuted ) [muteButton setImage:soundOffIcon forState:UIControlStateNormal];
    else [muteButton setImage:soundOnIcon forState:UIControlStateNormal];
    
}

- (IBAction)Pet:(id)sender
{
    
    [leftEye setBackgroundImage:Nil forState:UIControlStateNormal];
    
    [rightEye setBackgroundImage:Nil forState:UIControlStateNormal];
    
    if (isAsleep) 
    {
        [self WakeBadger];
    }
    else
    {
        consecutivePets++;
        
        if( consecutivePets % 3 ){
            
            [badgerView setImage:badgerHappy];
            
        }else{
            
            [soundEffects Happy];
            
            [badgerView setImage:badgerReallyHappy];
            
            [reactions Happy:badgerView];
        }
        
        [self SetMessage:@"Your Badger feels better"];
    }
    
    [mood setImage:angelIcon forState:UIControlStateNormal];
    
    mood.titleLabel.text=@"Calm";
    
    [badger Pet];
    
    [self SetGrumpyBar];
    
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    
    [self CheckAchievement];
    
    /*
    NSString *path  = [[NSBundle *mainBundle] pathForResource : fName ofType :ext];
    if ([[NSFileManager defaultManager] fileExistsAtPath : path])
    {
        NSURL *pathURL = [NSURL fileURLWithPath : path];
        AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
    }
    else
    {
        NSLog(@"error, file not found: %@", path);
    }
     */
    
}

- (IBAction)DoublePet:(id)sender
{
    
    [soundEffects Happy];
    
    if (isAsleep) 
    {
        [self WakeBadger];
    }
    else
    {
        consecutivePets++;
        
        if( consecutivePets % 3 ){
            
            [badgerView setImage:badgerHappy];
            
        }else{
         
            [soundEffects Happy];
            
            [badgerView setImage:badgerReallyHappy];
            
            [reactions Happy:badgerView];
            
        }
        
        [self SetMessage:@"Your Badger loves you so much!"];
        
        [mood setImage:angelIcon forState:UIControlStateNormal];
        
        mood.titleLabel.text=@"Loves!";
        
        [leftEye setBackgroundImage:heartImage forState:UIControlStateNormal];
        
        [rightEye setBackgroundImage:heartImage forState:UIControlStateNormal];
        
    }
    
    [self SetGrumpyBar];
    
    [badger DoublePet];
    
    [self CheckAchievement];
    
}

- (IBAction)Poke:(id)sender
{
    
    [soundEffects Bite];
    
    [badgerView setImage:badgerAngry];
    
    [reactions Angry:badgerView];

    consecutivePets = 0;
    
    [leftEye setBackgroundImage:Nil forState:UIControlStateNormal];
    
    [rightEye setBackgroundImage:Nil forState:UIControlStateNormal];
    
    if (isAsleep) 
    {
        [self WakeBadger];
    }
    
    [self SetMessage:@"You shouldn't touch your Badger there, he'll bite your finger off!"];
    
    mood.titleLabel.text=@"ANGRY";
    
    [mood setImage:devilIcon forState:UIControlStateNormal];
    
    [badger Poke];
    
    [self SetGrumpyBar];
    
    [badger IncrementInteger:@"fingers"];
    
    [self CheckAchievement];
}

- (IBAction)DoublePoke:(id)sender
{
    
    [soundEffects Bite];
    
    [badgerView setImage:badgerAngry];
    
    [reactions Angry:badgerView];
    
    consecutivePets = 0;
    
    [leftEye setBackgroundImage:Nil forState:UIControlStateNormal];
    
    [rightEye setBackgroundImage:Nil forState:UIControlStateNormal];
    
    if (isAsleep) 
    {
        [self WakeBadger];
    }
    
    [self SetMessage:@"You shouldn't touch your Badger there, he'll bite your hand off!"];
    
    mood.titleLabel.text=@"ANGRY";
    
    [mood setImage:devilIcon forState:UIControlStateNormal];
    
    [badger DoublePoke];
    
    [self SetGrumpyBar];
    
    [badger IncrementInteger:@"hands"];
    
    [self CheckAchievement];
}

- (IBAction)FeedBees:(id)sender
{
    [soundEffects Feed];
    
    [badgerView setImage:badgerHappy];
    
    [leftEye setBackgroundImage:Nil forState:UIControlStateNormal];
    
    [rightEye setBackgroundImage:Nil forState:UIControlStateNormal];
    
    [badger DecreaseHunger:0.1];
    
    [self SetHungerBar];
    
    NSString* msg = @"Your Badger likes bees.";
    
    [self SetMessage:msg];
    
    [mood setImage:angelIcon forState:UIControlStateNormal];
    
    mood.titleLabel.text=@"Happy";

    [badger IncrementInteger:@"bees"];
    
    [self CheckAchievement];
    
    //[badger Poke];
    //[self SetGrumpyBar];
    
}

- (IBAction)FeedCobra:(id)sender
{
    [soundEffects Feed];
    
    [leftEye setBackgroundImage:Nil forState:UIControlStateNormal];
    
    [rightEye setBackgroundImage:Nil forState:UIControlStateNormal];
    
    [badger DecreaseHunger:0.2];
    
    [self SetHungerBar];
    
    NSString* msg = @"Your Badger likes Cobra, but must nap now. Gently pet him to wake him up.";
    
    [self SetMessage:msg];
    
    [self SleepBadger:false];
    
    [badger IncrementInteger:@"cobras"];
    
    [self CheckAchievement];
    
    //[badger DoublePoke];
    
}

- (void)SleepBadger:(bool)showMessage
{
    
    consecutivePets = 0;
    
    [soundEffects Snore];
    
    [badgerView setImage:badgerSleeping];
    
    [reactions Snore:badgerView];
    
    if( showMessage )
    {
        [self SetMessage:@"Your Badger is asleep, gently pet him to wake him up."];
    }
    
    isAsleep = true;
    
    cobraButton.enabled = false;
    
    beesButton.enabled = false;  
    
    [mood setTitle:@"Asleep" forState:UIControlStateNormal];
    
    [mood setImage:sleepIcon forState:UIControlStateNormal];
    
}

- (void)WakeBadger
{
    
    [badgerView.layer removeAnimationForKey:@"Snore"];
    
    [badgerView setImage:badgerAwake];
    
    if(  hunger.progress <= 0.5 )
    {
        [self SetMessage:@"Your Badger is awake, but he's grumpy and hungry. Perhaps you should feed him."];
    }
    else
    {
        [self SetMessage:@"Your Badger is awake, and he's grumpy. Perhaps you should pet him."];
    }
    
    isAsleep = false;
    
    beesButton.enabled = true;
    
    cobraButton.enabled = true;
    
    mood.titleLabel.text=@"Grumpy";
    
    [mood setTitle:@"Grumpy" forState:UIControlStateNormal];

    [mood setImage:Nil forState:UIControlStateNormal];
    
}

- (void)SetMessage:(NSString *)message
{
    messageBox.text = message;
}

- (void)SetHungerBar
{
    hunger.progress = 1.0 - [badger GetFloatValue:@"hunger"];
}

- (void)SetGrumpyBar
{
    int grump = [badger GetGrumpiness];
    
    grumpiness.progress = (float)grump/(float)100.0;
    
    if( grump >= 50 )
    {
        [grumpBarAngel setImage:Nil forState:UIControlStateNormal];
        
        [grumpBarDevil setImage:devilIcon forState:UIControlStateNormal];
    }
    else
    {
        [grumpBarAngel setImage:angelIcon forState:UIControlStateNormal];
        
        [grumpBarDevil setImage:Nil forState:UIControlStateNormal];
    }
}

- (void)Notify:(NSString*)message{
    
    //[UIView beginAnimations: @"Fade In" context:nil];
    notifyBox.frame = notifyButtonFrame;
    
    [notifyBox setTitle:message forState:UIControlStateNormal];
    
    // Setup the animation
    [UIView beginAnimations:@"Fade In" context:NULL];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    [UIView setAnimationDidStopSelector:@selector(NotifyDone:finished:context:)];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -255);
    
    [notifyBox setAlpha:1.0];
    
    notifyBox.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];

    
}

- (void)NotifyDone:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
    //fadeout
    //if ([animationID isEqualToString:@"your_animation_name_here"])
    //{
    //    // something done after the animation
    //}
    // Setup the animation
    [UIView beginAnimations:@"Fade Out" context:NULL];
    
    [UIView setAnimationDuration:4.0];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    //[UIView setAnimationDidStopSelector:@selector(notifyDone:finished:context:)];

    [notifyBox  setAlpha:0.0];
    
    // Commit the changes
    [UIView commitAnimations];

}

/*- (void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration
            curve:(int)curve x:(CGFloat)x y:(CGFloat)y
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];

    [UIView setAnimationDuration:duration];
    
    [UIView setAnimationCurve:curve];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    [UIView setAnimationDidStopSelector:@selector(animDone:finished:context:)];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
    
}
*/
//bee button delegates
- (IBAction) cobraMoved:(id) sender withEvent:(UIEvent *) event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    
    UIControl *control = sender;
    
    control.center = point;
}

- (IBAction) cobraReleased:(id) sender withEvent:(UIEvent *) event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    
    UIControl *control = sender;
    
    control.center = point;
    
    if(CGRectContainsPoint([mouth frame], point))
    {
        //feed the badger and reset the button
        [self FeedCobra:NULL];
        
        cobraButton.imageView.alpha = 0;
        
        cobraButton.hidden = true; 
        
        cobraButton.frame = cobraButtonFrame;
        
        cobraButton.hidden = false;
        
        [reactions Eat:badgerView];
        
        [UIView beginAnimations: @"Fade In" context:nil];
        
        // wait for time before begin
        [UIView setAnimationDelay:0];
        
        // druation of animation
        [UIView setAnimationDuration:1.0];
        
        cobraButton.imageView.alpha = 1;
        
        [UIView commitAnimations];
    }
    else
    {
        [badgerView setImage:badgerAngry];
        
        [reactions Angry:badgerView];
        
        consecutivePets = 0;

        cobraButton.frame = cobraButtonFrame;
    }
    
}

//bee button delegates
- (IBAction) beeMoved:(id) sender withEvent:(UIEvent *) event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    
    UIControl *control = sender;
    
    control.center = point;
}

- (IBAction) beeReleased:(id) sender withEvent:(UIEvent *) event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    
    UIControl *control = sender;
    
    control.center = point;

    if(CGRectContainsPoint([mouth frame], point))
    {
        //feed the badger and reset the button
        [self FeedBees:NULL];
        
        beesButton.imageView.alpha = 0;
        
        beesButton.hidden = true; 
        
        beesButton.frame = beeButtonFrame;
        
        beesButton.hidden = false;
        
        [reactions Eat:badgerView];
        
        [UIView beginAnimations: @"Fade In" context:nil];
        
        // wait for time before begin
        [UIView setAnimationDelay:0];
        
        // druation of animation
        [UIView setAnimationDuration:1.0];
        
        beesButton.imageView.alpha = 1;
        
        [UIView commitAnimations];
    }
    else
    {
        [badgerView setImage:badgerAngry];
        
        [reactions Angry:badgerView];
        
        consecutivePets = 0;

        beesButton.frame = beeButtonFrame;
    }
    
}

- (void)SimulateLife
{
    BOOL isAlive = [badger Simulate];
    
    if( !isAlive )
    {
        [self Resurrect];
    }
    
    [self SetHungerBar];
}

- (void)Resurrect{

    int resurrections = [badger Ressurect];
    if( resurrections <= 1 )
    {
        [alertWithOkButton setMessage:@"Your new Pocket Badger has just been born!\r\n\r\nIf you're kind to him, he'll love you forever.\r\n\r\nBut be careful where you pet him, you never know when he might bite you. That's the sacrifice you make keeping a Pocket Badger.\r\n\r\nYour Pocket Badger needs food, keep him alive by feeding him bees and cobras.\r\n\r\nDon't forget to feed him regularly!\r\n\r\nPet him often to keep him calm, because there's nothing worse than an angry Pocket Badger!"];
    }
    else if( resurrections <= 5 )
    {
        [alertWithOkButton setMessage:[NSString stringWithFormat:@"Your Badger is Dead! You killed him because you didn't feed him enough.\r\n\r\nIn fact, you've killed him %d times!\r\n\r\nLucky for you, Pocket Badger don't care! He's come back from the dead to give you another chance.",resurrections]];
    }
    else
    {
        [alertWithOkButton setMessage:[NSString stringWithFormat:@"Your Badger is Dead! You killed him because you didn't feed him enough.\r\n\r\nIn fact, you've killed him %d times! That's just sick!\r\n\r\nLucky for you, Pocket Badger don't care! He's come back from the dead to give you another chance.",resurrections]];
    }
    //put up a message box and reset our hunger level...
    
    
    [alertWithOkButton show];
    
}

- (IBAction)About:(id) sender{
    
    [alertWithOkButton setMessage:
     @"Welcome to your new Pocket Badger!\r\n\r\nIf you're kind to him, he'll love you forever.\r\n\r\nBut be careful where you pet him, you never know when he might bite you. That's the sacrifice you make keeping a Pocket Badger.\r\n\r\nYour Pocket Badger needs food, keep him alive by feeding him bees and cobras.\r\n\r\nDon't forget to feed him regularly!\r\n\r\nPet him often to keep him calm, because there's nothing worse than an angry Pocket Badger!"];
    
    [alertWithOkButton show];
    
}

- (void)CheckAchievement
{
    NSString* str = [badger CheckAchievements];
    
    if( str != Nil ) [self Notify:str];
}
@end
