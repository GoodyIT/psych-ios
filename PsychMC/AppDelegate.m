//
//  AppDelegate.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-05.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [FCModel closeDatabase];
    
//    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"msych.sqlite3"];
//    NSLog(@"DB path: %@", dbPath);
    
    NSString* dbPath = [[NSBundle mainBundle] pathForResource:@"psych"
                                                     ofType:@"sqlite3"];
    // New DB on every launch for testing (comment out for persistence testing)
//    [NSFileManager.defaultManager removeItemAtPath:dbPath error:NULL];
    
    [FCModel openDatabaseAtPath:dbPath withDatabaseInitializer:NULL schemaBuilder:^(FMDatabase *db, int *schemaVersion) {
//        [db setCrashOnErrors:YES];
//        //        db.traceExecution = YES; // Log every query (useful to learn what FCModel is doing or analyze performance)
//        [db beginTransaction];
//
//        void (^failedAt)(int statement) = ^(int statement){
//            int lastErrorCode = db.lastErrorCode;
//            NSString *lastErrorMessage = db.lastErrorMessage;
//            [db rollback];
//            NSAssert3(0, @"Migration statement %d failed, code %d: %@", statement, lastErrorCode, lastErrorMessage);
//        };
//
//        if (*schemaVersion < 1) {
//            if (! [db executeUpdate:
//                   @"CREATE TABLE Work ("
//                   @"    ID                 INTEGER PRIMARY KEY,"
//                   @"    historyIDs         TEXT NOT NULL,"
//                   @"    numberOfQuestions  INTEGER NOT NULL DEFAULT 1,"
//                   @"    wrongQuestions     TEXT NOT NULL,"
//                   @"    flaggedQuestions   TEXT NOT NULL,"
//                   @"    missedQuestions    TEXT NOT NULL,"
//                   @"    mode               TEXT NOT NULL,"
//                   @"    totalTime           INTEGER,"
//                   @"    elapsedTime         INTEGER,"
//                   @"    createdAt          TEXT NOT NULL"
//                   @");"
//                   ]) failedAt(1);
//            if (! [db executeUpdate:@"CREATE UNIQUE INDEX IF NOT EXISTS ID ON Work (ID);"]) failedAt(2);
//
////            if (! [db executeUpdate:
////                   @"CREATE TABLE Color ("
////                   @"    name         TEXT NOT NULL PRIMARY KEY,"
////                   @"    hex          TEXT NOT NULL"
////                   @");"
////                   ]) failedAt(3);
//
//            // Create any other tables...
//
//            *schemaVersion = 1;
//        }
////
////        // If you wanted to change the schema in a later app version, you'd add something like this here:
////        /*
////         if (*schemaVersion < 2) {
////         if (! [db executeUpdate:@"ALTER TABLE Person ADD COLUMN lastModified INTEGER NULL"]) failedAt(3);
////         *schemaVersion = 2;
////         }
////         */
//////
//        [db commit];
    }];
    
    [FCModel inDatabaseSync:^(FMDatabase *db) {
        [FCModel inDatabaseSync:^(FMDatabase *db) {
            
        }];
    }];
 
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
