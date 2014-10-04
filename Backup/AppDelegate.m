//
//  AppDelegate.m
//  RetailMasterHack
//
//  Created by Jack on 2014-10-01.
//  Copyright (c) 2014 RetailMaster. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"wS8MIO5z0tCiJyIIU7XaBtNiwcyLPdjJkqIetfHP"
                  clientKey:@"LJp1vLvGyzXpz0fmbJYyPDD0rR1JfVb8zLY4kAQL"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [self uploadData];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)uploadData{
    PFObject *raspberries = [PFObject objectWithClassName:@"Fruit"];
    raspberries[@"description"] = @"Fresh raspberries. Product of U.S.A. 6oz pkg";
    raspberries[@"price"] = @"2 for $5";
    raspberries[@"nutritionFact"] = @"Vitamin ABCDE";
    raspberries[@"isSold"] = @NO;
    [raspberries saveInBackground];
    
    PFObject *pear = [PFObject objectWithClassName:@"Fruit"];
    pear[@"description"] = @"Fresh Bosc or Bartlett Pears. Product of Ontario. 2L basket.";
    pear[@"price"] = @"$2.99";
    pear[@"nutritionFact"] = @"Vitamin ABCDE";
    pear[@"isSold"] = @NO;
    [pear saveInBackground];
    
    PFObject *fruitTray = [PFObject objectWithClassName:@"Fruit"];
    fruitTray[@"description"] = @"Longo's Fresh Fruit Tray. 2.5kg tray.";
    fruitTray[@"price"] = @"$19.99";
    fruitTray[@"nutritionFact"] = @"Vitamin ABCDE";
    fruitTray[@"isSold"] = @NO;
    [fruitTray saveInBackground];
    
    PFObject *tomatoes = [PFObject objectWithClassName:@"Fruit"];
    tomatoes[@"description"] = @"Product of Ontario. 2.18/kg";
    tomatoes[@"price"] = @"$99c/lb";
    tomatoes[@"nutritionFact"] = @"Vitamin ABCDE";
    tomatoes[@"isSold"] = @NO;
    [tomatoes saveInBackground];
    
    PFObject *apples = [PFObject objectWithClassName:@"Fruit"];
    apples[@"description"] = @"Product of Ontario. 2.18/kg";
    apples[@"price"] = @"$99c/lb";
    apples[@"nutritionFact"] = @"Vitamin ABCDE";
    apples[@"isSold"] = @NO;
    [apples saveInBackground];
    
    PFObject *grapes = [PFObject objectWithClassName:@"Fruit"];
    grapes[@"description"] = @"Fresh Red Seedless Grapes. Product of U.S.A.. 4.39/kg";
    grapes[@"price"] = @"$1.99/lb";
    grapes[@"nutritionFact"] = @"Vitamin ABCDE";
    grapes[@"isSold"] = @NO;
    [grapes saveInBackground];

    PFObject *iceCream = [PFObject objectWithClassName:@"Frozen"];
    iceCream[@"description"] = @"Haagen-Dazs Ice Cream, Gelato, Novelties or Skinny Cow Treats";
    iceCream[@"price"] = @"$4.49/500mL";
    iceCream[@"nutritionFact"] = @"Fat";
    iceCream[@"isSold"] = @NO;
    [iceCream saveInBackground];
    
    PFObject *burritos = [PFObject objectWithClassName:@"Frozen"];
    burritos[@"description"] = @"Amy's Frozen Burritos";
    burritos[@"price"] = @"2 for $5";
    burritos[@"nutritionFact"] = @"Fat";
    burritos[@"isSold"] = @NO;
    [burritos saveInBackground];
    
    PFObject *frozenPizza = [PFObject objectWithClassName:@"Frozen"];
    frozenPizza[@"description"] = @"Delissio Rising Crust, Pizzeria Vintage or Thin Crispy Crust Frozen Pizza";
    frozenPizza[@"price"] = @"$4.49";
    frozenPizza[@"nutritionFact"] = @"2000 Calories";
    frozenPizza[@"isSold"] = @NO;
    [frozenPizza saveInBackground];
    
    PFObject *chicken = [PFObject objectWithClassName:@"Frozen"];
    chicken[@"description"] = @"Pinty’s Pub & Grill or Eat Well Chicken";
    chicken[@"price"] = @"$12.99";
    chicken[@"nutritionFact"] = @"2000 Calories";
    chicken[@"isSold"] = @NO;
    [chicken saveInBackground];
    
    PFObject *burgers = [PFObject objectWithClassName:@"Frozen"];
    burgers[@"description"] = @"Prime Chicken Wings, Nuggets, Strips or Burgers";
    burgers[@"price"] = @"$7.99";
    burgers[@"nutritionFact"] = @"2000 Calories";
    burgers[@"isSold"] = @NO;
    [burgers saveInBackground];
    
    PFObject *pierogies = [PFObject objectWithClassName:@"Frozen"];
    pierogies[@"description"] = @"Supreme Pierogies";
    pierogies[@"price"] = @"2 for $4";
    pierogies[@"nutritionFact"] = @"2000 Calories";
    pierogies[@"isSold"] = @NO;
    [pierogies saveInBackground];
    
    PFObject *stouffers = [PFObject objectWithClassName:@"Frozen"];
    stouffers[@"description"] = @"Stouffer’s Lean Cuisine, Red Box or Bistro Crustini";
    stouffers[@"price"] = @"2 for $4";
    stouffers[@"nutritionFact"] = @"2000 Calories";
    stouffers[@"isSold"] = @NO;
    [stouffers saveInBackground];
    
    PFObject* tuna = [PFObject objectWithClassName: @"SeaFood"];
    tuna[@"description"] = @"Solid or Flaked White Albacore Tuna";
    tuna[@"price"] = @"$1.99 ea";
    tuna[@"nutritionFact"] = @"Protein";
    tuna[@"isSold"] = @NO;
    [tuna saveInBackground];
    
    PFObject* cod = [PFObject objectWithClassName: @"SeaFood"];
    cod[@"description"] = @"Fresh Wild Caught Jumbo Cod Fillets";
    cod[@"price"] = @"$12.99/lb";
    cod[@"nutritionFact"] = @"Protein";
    cod[@"isSold"] = @NO;
    [cod  saveInBackground];
    
    PFObject* scallop = [PFObject objectWithClassName: @"SeaFood"];
    scallop[@"description"] = @"Fresh Wild Caught Ocean Scallops";
    scallop[@"price"] = @"$24.99/lb";
    scallop[@"nutritionFact"] = @"Protein";
    scallop[@"isSold"] = @NO;
    [scallop saveInBackground];
    
    PFObject* shrimp = [PFObject objectWithClassName: @"SeaFood"];
    shrimp[@"description"] = @"Frozen Cooked Black Tiger Shrimp";
    shrimp[@"price"] = @"$14.99/lb";
    shrimp[@"nutritionFact"] = @"Protein";
    shrimp[@"isSold"] = @NO;
    [shrimp saveInBackground];
    
    PFObject* haddock = [PFObject objectWithClassName: @"SeaFood"];
    haddock[@"description"] = @"Janes Frozen Haddock";
    haddock[@"price"] = @"$11.99 ea";
    haddock[@"nutritionFact"] = @"Protein";
    haddock[@"isSold"] = @NO;
    [haddock saveInBackground];
    
    PFObject* salmonSteak = [PFObject objectWithClassName: @"SeaFood"];
    salmonSteak[@"description"] = @"Fresh Canadian Atlantic Salmon Steaks Value Pack";
    salmonSteak[@"price"] = @"$5.99/lb";
    salmonSteak[@"nutritionFact"] = @"Protein";
    salmonSteak[@"isSold"] = @NO;
    [salmonSteak saveInBackground];
    
    
    PFObject* bread = [PFObject objectWithClassName: @"Bakery"];
    bread[@"description"] = @"Amaya Naan Bread";
    bread[@"price"] = @"$2.49 ea";
    bread[@"nutritionFact"] = @"Grain";
    bread[@"isSold"] = @NO;
    [bread saveInBackground];
    
    PFObject* brownies = [PFObject objectWithClassName: @"Bakery"];
    brownies[@"description"] = @"Brownies or Macaroons";
    brownies[@"price"] = @"$2.99 ea";
    brownies[@"nutritionFact"] = @"Grain";
    brownies[@"isSold"] = @NO;
    [brownies saveInBackground];
    
    PFObject* cinnamonRoll = [PFObject objectWithClassName: @"Bakery"];
    cinnamonRoll[@"description"] = @"Mini Cinnamon Rolls";
    cinnamonRoll[@"price"] = @"$2.99 ea";
    cinnamonRoll[@"nutritionFact"] = @"Grain";
    cinnamonRoll[@"isSold"] = @NO;
    [cinnamonRoll saveInBackground];
    
    PFObject* ryeBread = [PFObject objectWithClassName: @"Bakery"];
    ryeBread[@"description"] = @"Stonemill Prince Edward County Rye Bread";
    ryeBread[@"price"] = @"$3.99 ea";
    ryeBread[@"nutritionFact"] = @"Grain";
    ryeBread[@"isSold"] = @NO;
    [ryeBread saveInBackground];
    
    PFObject* largeBuns = [PFObject objectWithClassName: @"Bakery"];
    largeBuns[@"description"] = @"Fresh Large Buns";
    largeBuns[@"price"] = @"6 For $2.99";
    largeBuns[@"nutritionFact"] = @"Grain";
    largeBuns[@"isSold"] = @NO;
    [largeBuns saveInBackground];
    
    PFObject* triangleBuns = [PFObject objectWithClassName: @"Bakery"];
    triangleBuns[@"description"] = @"Triangle Buns Focaccia or Multigrain";
    triangleBuns[@"price"] = @"$2.99 ea";
    triangleBuns[@"nutritionFact"] = @"Grain";
    triangleBuns[@"isSold"] = @NO;
    [triangleBuns saveInBackground];
    
    PFObject* cookies = [PFObject objectWithClassName: @"Bakery"];
    cookies[@"description"] = @"Voortman's Turnover Cookies";
    cookies[@"price"] = @"3 for $5";
    cookies[@"nutritionFact"] = @"Grain";
    cookies[@"isSold"] = @NO;
    [cookies saveInBackground];
    
    PFObject* challahBread = [PFObject objectWithClassName: @"Bakery"];
    challahBread[@"description"] = @"Silversteinís Challah Bread";
    challahBread[@"price"] = @"$2.99 ea";
    challahBread[@"nutritionFact"] = @"Grain";
    challahBread[@"isSold"] = @NO;
    [challahBread saveInBackground];
    
    PFObject *pork = [PFObject objectWithClassName: @"RawMeat"];
    pork[@"description"] = @"Fresh Ontario Pork Tenderloin";
    pork[@"price"] = @"$3.99/lb";
    pork[@"nutritionFact"] = @"Protein";
    pork[@"isSold"] = @NO;
    [pork saveInBackground];
    
    PFObject* chickenLegs = [PFObject objectWithClassName: @"RawMeat"];
    chickenLegs[@"description"] = @"Fresh Ontario, 6 Packs Chicken Leg";
    chickenLegs[@"price"] = @"$4.99/lb";
    chickenLegs[@"nutritionFact"] = @"Protein";
    chickenLegs[@"isSold"] = @NO;
    [chickenLegs saveInBackground];
    
    PFObject* chickenBreast = [PFObject objectWithClassName: @"RawMeat"];
    chickenBreast[@"description"] = @"Fresh Ontario, Air Chilled, Grain Fed, Boneless Chicken Breast";
    chickenBreast[@"price"] = @"$5.99/lb";
    chickenBreast[@"nutritionFact"] = @"Protein";
    chickenBreast[@"isSold"] = @NO;
    [chickenBreast saveInBackground];
    
    PFObject* beef = [PFObject objectWithClassName: @"RawMeat"];
    beef[@"description"] = @"Cut From Canada AAA Grade Beef Striploin Steaks";
    beef[@"price"] = @"$10.99/lb";
    beef[@"nutritionFact"] = @"Protein";
    beef[@"isSold"] = @NO;
    [beef saveInBackground];
    
    PFObject* turkeyBreast = [PFObject objectWithClassName: @"RawMeat"];
    turkeyBreast[@"description"] = @"Fresh Ontario, Air Chilled, Grain Fed, Boneless Turkey Breast";
    turkeyBreast[@"price"] = @"$4.99/lb";
    turkeyBreast[@"nutritionFact"] = @"Protein";
    turkeyBreast[@"isSold"] = @NO;
    [turkeyBreast saveInBackground];
    
    PFObject* turkeyLegs = [PFObject objectWithClassName: @"RawMeat"];
    turkeyLegs[@"description"] = @"Fresh Ontario turkey legs";
    turkeyLegs[@"price"] = @"$3.49/lb";
    turkeyLegs[@"nutritionFact"] = @"Protein";
    turkeyLegs[@"isSold"] = @NO;
    [turkeyLegs saveInBackground];
    
    PFObject* salmon = [PFObject objectWithClassName: @"RawMeat"];
    salmon[@"description"] = @"Fresh Canadian Skinless Atlantic Salmon Fillets";
    salmon[@"price"] = @"$11.99/lb";
    salmon[@"nutritionFact"] = @"Protein";
    salmon[@"isSold"] = @NO;
    [salmon saveInBackground];
    
    PFObject* ham = [PFObject objectWithClassName: @"RawMeat"];
    ham[@"description"] = @"Brandts Ham Kolbassa";
    ham[@"price"] = @"$4.99 ea";
    ham[@"nutritionFact"] = @"Protein";
    ham[@"isSold"] = @NO;
    [ham saveInBackground];
    
    PFObject* sausage = [PFObject objectWithClassName: @"RawMeat"];
    sausage[@"description"] = @"Family Recipe Italian Pork Sausage";
    sausage[@"price"] = @"$5 ea";
    sausage[@"nutritionFact"] = @"Protein";
    sausage[@"isSold"] = @NO;
    [sausage saveInBackground];
    
    PFObject* chickenKabobs = [PFObject objectWithClassName: @"Kitchen"];
    chickenKabobs[@"description"] = @"Fresh Ontario Chicken Kabobs or Souvlakis";
    chickenKabobs[@"price"] = @"$3.50 ea";
    chickenKabobs[@"nutritionFact"] = @"Protein";
    chickenKabobs[@"isSold"] = @NO;
    [chickenKabobs saveInBackground];
    
    PFObject* gourmet = [PFObject objectWithClassName: @"Kitchen"];
    gourmet[@"description"] = @"Gourmet Grilled Cheese";
    gourmet[@"price"] = @"$5.49 ea";
    gourmet[@"nutritionFact"] = @"Protein";
    gourmet[@"isSold"] = @NO;
    [gourmet saveInBackground];
    
    PFObject* veggieTray = [PFObject objectWithClassName: @"Kitchen"];
    veggieTray[@"description"] = @"Longoís Fresh Veggie Tray with Ranch Dip";
    veggieTray[@"price"] = @"$16.99";
    veggieTray[@"nutritionFact"] = @"Vitamins";
    veggieTray[@"isSold"] = @NO;
    [veggieTray saveInBackground];

    
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
