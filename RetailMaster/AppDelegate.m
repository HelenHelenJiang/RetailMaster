//
//  AppDelegate.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Item.h"

#import "ParseManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Parse class
    [Item registerSubclass];
    
    // Override point for customization after application launch.
    [Parse setApplicationId:@"wS8MIO5z0tCiJyIIU7XaBtNiwcyLPdjJkqIetfHP"
                  clientKey:@"LJp1vLvGyzXpz0fmbJYyPDD0rR1JfVb8zLY4kAQL"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [[ParseManager sharedManager] updateItem];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)uploadData{
    PFObject *milk = [PFObject objectWithClassName:@"Diary"];
    milk[@"score"] = @1337;
    milk[@"playerName"] = @"Sean Plott";
    milk[@"cheatMode"] = @NO;
    [milk saveInBackground];
    
    PFObject *cheese = [PFObject objectWithClassName:@"Diary"];
    cheese[@"score"] = @1337;
    cheese[@"playerName"] = @"Sean Plott";
    cheese[@"cheatMode"] = @NO;
    [cheese saveInBackground];
    
    PFObject *yogurt = [PFObject objectWithClassName:@"Diary"];
    yogurt[@"score"] = @1337;
    yogurt[@"playerName"] = @"Sean Plott";
    yogurt[@"cheatMode"] = @NO;
    [yogurt saveInBackground];
    
    PFObject *soyMilk = [PFObject objectWithClassName:@"Diary"];
    soyMilk[@"score"] = @1337;
    soyMilk[@"playerName"] = @"Sean Plott";
    soyMilk[@"cheatMode"] = @NO;
    [soyMilk saveInBackground];
    
}

-(void)retrieveDataByObjID
{   PFQuery *query = [PFQuery queryWithClassName:@"Diary"];
    [query getObjectInBackgroundWithId:@"xx" block:^(PFObject *milk, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        
        int score = [[milk objectForKey:@"score"] intValue];
        NSString *playerName = milk[@"playerName"];
        BOOL cheatMode = [milk[@"cheatMode"] boolValue];
        
        //special values are provided as properties
        NSString *objectId = milk.objectId;
        NSDate *updatedAt = milk.updatedAt;
        NSDate *createdAt = milk.createdAt;
        
        [milk refresh];
        
        NSLog(@"%@", milk, score, playerName, cheatMode);
    }];
    // The InBackground methods are asynchronous, so any code after this will run
    // immediately.  Any code that depends on the query result should be moved
    // inside the completion block above.
    
}

-(void)saveObjOffline{
    // Create the object.
    //[gameScore deleteInBackground]; to Delete
    PFObject *gameScore = [PFObject objectWithClassName:@"GameScore"];
    gameScore[@"score"] = @1337;
    gameScore[@"playerName"] = @"Sean Plott";
    gameScore[@"cheatMode"] = @NO;
    [gameScore saveEventually];
}

-(void)updateData{
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"xWMyZ4YEGZ" block:^(PFObject *gameScore, NSError *error) {
        
        // Now let's update it with some new data. In this case, only cheatMode and score
        // will get sent to the cloud. playerName hasn't changed.
        gameScore[@"cheatMode"] = @YES;
        gameScore[@"score"] = @1338;
        [gameScore saveInBackground];
        
    }];
}

//Query Methods Start
-(void)queryByNameAndClass{
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    [query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

//other contraints
/*[query whereKey:@"playerName" notEqualTo:@"Michael Yabuti"];
 [query whereKey:@"playerAge" greaterThan:@18];
 
 
 Finds scores from any of Jonathan, Dario, or Shawn
 NSArray *names = @[@"Jonathan Walsh",
 @"Dario Wunsch",
 @"Shawn Simon"];
 [query whereKey:@"playerName" containedIn:names];
 
 Finds objects that have the score set
 [query whereKeyExists:@"score"];
 
 // Finds objects that don't have the score set
 [query whereKeyDoesNotExist:@"score"];
 */

-(void)queryByClassAndContraintsOnKey{
    PFQuery *teamQuery = [PFQuery queryWithClassName:@"Team"];
    [teamQuery whereKey:@"winPct" greaterThan:@(0.5)];
    PFQuery *userQuery = [PFQuery queryForUser];
    [userQuery whereKey:@"hometown" matchesKey:@"city" inQuery:teamQuery];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        // results will contain users with a hometown team with a winning record
    }];
}

-(void)queryByClassAndSelectedKeys{
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    [query selectKeys:@[@"playerName", @"score"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        // objects in results will only contain the playerName and score fields
    }];
}

//The remaining fields can be fetched later by calling one of the fetchIfNeeded variants on the returned objects:
/*
 PFObject *object = (PFObject*)results[0];
 [object fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
 // all fields of the object will now be available here.
 }];
 
 */

-(void)queryWithInnerQuery{
    PFQuery *innerQuery = [PFQuery queryWithClassName:@"Post"];
    [innerQuery whereKeyExists:@"image"];
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query whereKey:@"post" matchesQuery:innerQuery];
    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        // comments now contains the comments for posts with images
    }];
}

-(void)queryRetrievingRelativeData{
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    
    // Retrieve the most recent ones
    [query orderByDescending:@"createdAt"];
    
    // Only retrieve the last ten
    query.limit = 10;
    
    // Include the post data with each comment
    [query includeKey:@"post"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        // Comments now contains the last ten comments, and the "post" field
        // has been populated. For example:
        for (PFObject *comment in comments) {
            // This does not require a network access.
            PFObject *post = comment[@"post"];
            NSLog(@"retrieved related post: %@", post);
        }
    }];
}

//Query Methods End

@end
