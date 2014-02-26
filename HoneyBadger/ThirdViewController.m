//
//  ThirdViewController.m
//  HoneyBadger
//
//  Created by Jeff Lutzenberger on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThirdViewController.h"


@implementation ThirdViewController

- (void)viewWillAppear:(BOOL)animated
{
    if( badger != Nil ) [badger release];
    
    badger = [[BadgerModel alloc] initWithTitle:@"BadgerModel"];
    
    int count = [[badger Badges] count];
    
    if( badges != Nil ) [badges release];
    
    badges = [[NSMutableArray alloc] initWithCapacity:count];
    
    for (NSString* key in [badger Badges]) {
        [badges addObject:key];
    }
    
    [badgesTable reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    badgeImage = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/badge.png", [[NSBundle mainBundle] bundlePath]]];
    
    badger = [[BadgerModel alloc] initWithTitle:@"BadgerModel"];
    
    int count = [[badger Badges] count];
    
    badges = [[NSMutableArray alloc] initWithCapacity:count];
    
    for (NSString* key in [badger Badges]) {
        [badges addObject:key];
    }
    
    [badgesTable reloadData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
// get the number of properties for the selected shape
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [badges count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"Badges";

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSString *property = [shapeLoader getKeyValueStringInDict:[m_pickerView selectedRowInComponent:2] keyIndex:[indexPath row]];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    cell.textLabel.text = [badges  objectAtIndex:indexPath.row];
    cell.imageView.image = badgeImage;
    //cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    /*NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
     NSArray *array = [dictionary objectForKey:@"Countries"];
     NSString *selectedCountry = [array objectAtIndex:indexPath.row];
     
     //Initialize the detail view controller and display it.
     DetailViewController *dvController = [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:[NSBundle mainBundle]];
     dvController.selectedCountry = selectedCountry;
     [self.navigationController pushViewController:dvController animated:YES];
     [dvController release];
     dvController = nil;
     
     
     // open a alert with an OK and cancel button
     NSString *alertString = [NSString stringWithFormat:@"Clicked on row #%d", [indexPath row]];
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:@"" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
     [alert show];
     [alert release];*/
}

@end
