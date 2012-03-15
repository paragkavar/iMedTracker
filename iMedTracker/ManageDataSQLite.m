//
//  ManageDataSQLite.m
//  SOS Panic Button
//
//  Created by Jesus Guerra on 7/9/11.
//  Copyright 2011 Nearsoft. All rights reserved.
//

#import "ManageDataSQLite.h"
#define DATABASE_NAME @"MedTrakerDB"


@implementation ManageDataSQLite


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(void)executeSentence:(NSString *)sentence sentenceIsSelect:(BOOL )isSelect{
    // Variables para realizar la consulta
    static sqlite3 *db;
    sqlite3_stmt *resultado;
    const char* siguiente;
    
    // Buscar el archivo de base de datos
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
    
    // Abre el archivo de base de datos
    if (sqlite3_open([path UTF8String], &db) == SQLITE_OK) {
        
        if (isSelect){
            
            // Ejecuta la consulta
            if ( sqlite3_prepare(db,[sentence UTF8String],[sentence length],&resultado,&siguiente) == SQLITE_OK ){
                
                // Recorre el resultado
                while (sqlite3_step(resultado)==SQLITE_ROW){
                    NSLog([NSString stringWithFormat:@"ID:%@ NAME:%@ ", 
                           [NSString stringWithUTF8String: (char *)sqlite3_column_text(resultado, 0)], 
                           [NSString stringWithUTF8String: (char *)sqlite3_column_text(resultado, 1)] 
                           ]);
                }
            }
        }
        else {
            // Ejecuta la consulta
            if ( sqlite3_prepare_v2(db,[sentence UTF8String],[sentence length],&resultado,&siguiente) == SQLITE_OK ){
                sqlite3_step(resultado);
                sqlite3_finalize(resultado);
            }
        }
    }
    // Cierra el archivo de base de datos
    sqlite3_close(db);

    
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
