//
//  ScheduleMedsViewController.h
//  iMedTracker
//
//  Created by Jesus Guerra Rosas on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface ScheduleMedsViewController : UITableViewController<DetailViewControllerDelegate>

@property(nonatomic,strong) NSMutableArray *medsArray;

@end
