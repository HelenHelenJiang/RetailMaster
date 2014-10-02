#import "SIMAppDelegate.h"
#import <Simplify/Simplify.h>

#import "SIMProductViewController.h"


@interface SIMAppDelegate () 
@property (nonatomic, strong) UIStoryboard *storyboard;
@end

@implementation SIMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.storyboard = [self.window.rootViewController storyboard];
    SIMProductViewController *productController = [self.storyboard instantiateInitialViewController];

    self.window.rootViewController = productController;

    [self.window makeKeyAndVisible];
    return YES;
}

@end
