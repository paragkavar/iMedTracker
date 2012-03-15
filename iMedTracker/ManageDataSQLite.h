//
//  ManageDataSQLite.h
//  SOS Panic Button
//
//  Created by Jesus Guerra on 7/9/11.
//  Copyright 2011 Nearsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface ManageDataSQLite : NSObject{

}
+(void)executeSentence:(NSString *)sentence sentenceIsSelect:(BOOL )isSelect;
+(void)createEditableCopyOfDatabaseIfNeeded;

@end
