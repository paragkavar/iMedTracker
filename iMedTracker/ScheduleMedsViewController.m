//
//  ScheduleMedsViewController.m
//  iMedTracker
//
//  Created by Jesus Guerra Rosas on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleMedsViewController.h"
#import "DetailViewController.h"
#import "Medecine.h"

@interface ScheduleMedsViewController ()

@end

@implementation ScheduleMedsViewController
@synthesize medsArray=_medsArray;

#pragma mark - Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ( [[segue identifier] isEqualToString:@"ShowMed"] ){
        
        DetailViewController *dvc = (DetailViewController *)[segue destinationViewController];
        dvc.med = [_medsArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
    }else if ( [[segue identifier] isEqualToString:@"AddMed"] ){
        
        UINavigationController *navController = (UINavigationController *) [segue destinationViewController];
        NSLog(@"%@", [segue destinationViewController]);
        DetailViewController *dvc = (DetailViewController *)[navController topViewController];
        dvc.med = nil;
        dvc.delegate = self;
        
    }
}


#pragma mark - Delegate Method
-(void) addMedToList:(Medecine *) med{
    [self.medsArray addObject:med];
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.medsArray = [[NSMutableArray alloc] init];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.medsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // Configure the cell...
    
    Medecine *med = [self.medsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = med.name;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.medsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}




@end
