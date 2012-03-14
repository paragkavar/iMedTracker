//
//  DetailViewController.h
//  iMedTracker
//
//  Created by Jesus Guerra Rosas on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Medecine.h"
#import "DetailViewController.h"

@protocol DetailViewControllerDelegate;

@protocol DetailViewControllerDelegate <NSObject>
-(void) addMedToList:(Medecine *) med;
@end

@interface DetailViewController : UITableViewController
@property (weak, nonatomic) id<DetailViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *dosis;
@property (strong, nonatomic) Medecine *med;

@end
