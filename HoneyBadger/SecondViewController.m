//
//  SecondViewController.m
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"


@implementation SecondViewController

@synthesize name;
@synthesize age;
@synthesize born;
@synthesize resurrections;
@synthesize cobras;
@synthesize bees;
@synthesize fingers;
@synthesize hands;
@synthesize pets;
@synthesize pokes;
@synthesize grumpiness;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    angelIcon = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/angel.png", [[NSBundle mainBundle] bundlePath]]];
    
    devilIcon = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/devil.png", [[NSBundle mainBundle] bundlePath]]];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    badger = [[[BadgerModel alloc] initWithTitle:@"BadgerModel"] autorelease];
    
    NSDate* bornDate = [badger GetDateValue:@"birthday"];
    
    double myAgeDays = (double)(-1*[bornDate timeIntervalSinceNow]) /60/60/24;
    
    age.text = [NSString stringWithFormat:@"%d Days", (int)(floor(myAgeDays))];
    
    //age.text = [badger GetStringValue:@"age"];
    
    born.text = [badger GetDateAsString:@"birthday"];
    
    resurrections.text = [badger GetStringValue:@"resurrections"];
    
    cobras.text = [badger GetStringValue:@"cobras"];
    
    bees.text = [badger GetStringValue:@"bees"];
    
    fingers.text = [badger GetStringValue:@"fingers"];
    
    hands.text = [badger GetStringValue:@"hands"];
    
    pets.text = [NSString stringWithFormat:@"%d", [badger GetTotalPets]];
    
    pokes.text = [NSString stringWithFormat:@"%d", [badger GetTotalPokes]];
    
    int grump = [badger GetGrumpiness];

    [grumpiness setTitle:[NSString stringWithFormat:@"%d/100", grump] forState:UIControlStateNormal];
    
    if( grump >= 50 )
    {
        [grumpiness setImage:devilIcon forState:UIControlStateNormal];
    }
    else
    {
        [grumpiness setImage:angelIcon forState:UIControlStateNormal];
    }
}

- (void)dealloc
{
    [super dealloc];
    
    //[badger release];
}

@end
