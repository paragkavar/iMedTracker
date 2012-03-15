//
//  ManageDataSQLite.h
//  SOS Panic Button
//
//  Created by Jesus Guerra on 7/9/11.
//  Copyright 2011 Nearsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Medecine.h"


@interface ManageDataSQLite : NSObject
+(void)createEditableCopyOfDatabaseIfNeeded;
+(NSMutableArray *)getMedsFromDB;
+(void)insertMed:(Medecine *)aMed;

@end
