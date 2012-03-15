//
//  ManageDataSQLite.m
//  SOS Panic Button
//
//  Created by Jesus Guerra on 7/9/11.
//  Copyright 2011 Nearsoft. All rights reserved.
//

#import "ManageDataSQLite.h"

#define DATABASE_NAME @"MedTrakerDB"
#define SELECT_ALL_MEDS @"SELECT * FROM Meds"

@implementation ManageDataSQLite


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
+(void)insertMed:(Medecine *)aMed
{
    static sqlite3 *db;
    sqlite3_stmt *result;
    const char* next;
    
    NSString *sentence = [NSString stringWithFormat:@"INSERT INTO Meds (Medecine,Dosis) VALUES ( '%@', %i)",aMed.name,aMed.dosis];
    
      
    // Find DB file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
    
    // Open DB
    if (sqlite3_open([path UTF8String], &db) == SQLITE_OK) {
        // Exec Query
        if ( sqlite3_prepare_v2(db,[sentence UTF8String],[sentence length],&result,&next) == SQLITE_OK ){
            sqlite3_step(result);
            sqlite3_finalize(result);
        }else {
            NSLog(@"Error in insert Med");
        }

    }
    // Close DB
    sqlite3_close(db);
}


+(NSMutableArray *)getMedsFromDB
{
    static sqlite3 *db;
    sqlite3_stmt *result;
    const char* next;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    // Find DB file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
    
    // Open DB
    if (sqlite3_open([path UTF8String], &db) == SQLITE_OK) {
        // Exec Query
        if ( sqlite3_prepare(db,[SELECT_ALL_MEDS UTF8String],[SELECT_ALL_MEDS length],&result,&next) == SQLITE_OK ){
            
            // Get Results
            while (sqlite3_step(result)==SQLITE_ROW){
                Medecine *med = [[Medecine alloc] init];
                
                med.name = [NSString stringWithUTF8String: (char *)sqlite3_column_text(result, 1)];
                med.dosis = [[NSString stringWithUTF8String: (char *)sqlite3_column_text(result, 2)] intValue];
                
                [array addObject:med];
                NSLog(@"Array position : %i -  Med name: %@ , Med Dosis: %i",[array count],med.name,med.dosis);
                

            }
        }
    }
       
    
    // Close DB
    sqlite3_close(db);
    return array;
}

+(void)createEditableCopyOfDatabaseIfNeeded{
	
	//First, test for existence.
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath =[documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
	success = [fileManager fileExistsAtPath:writableDBPath];
	if(success) return;
	
	//The writable database does not exist, so copy the default to the appopiate location.
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
	success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
	if (!success) {
		NSAssert1(0,@"Fail to create writable database file with message '%@'",[error localizedDescription]);
	}
}




@end
