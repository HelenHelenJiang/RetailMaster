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

- (void)uploadData
{
    PFObject *fruit = [PFObject objectWithClassName:@"Fruit"];
    
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
    
    PFObject *frozen = [PFObject objectWithClassName:@"Frozen"];
    
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
}

@end
