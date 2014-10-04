//
//  WelcomeViewController.m
//  RetailMaster
//
//  Created by Jack on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 320, 20)];
    [self.view addSubview:welcomeLabel];
    welcomeLabel.textColor  = [UIColor blueColor];
    welcomeLabel.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    BOOL isRegistered = [defualts objectForKey:@"isRegistered"];
    
    if (isRegistered) {
        
        NSString *name  = [defualts objectForKey:@"name"];
        welcomeLabel.text = [NSString stringWithFormat:@"Hi %@",name];
        
    } else {
        
        welcomeLabel.text = @"Welcome to Retail Master!";
        
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 140, 120, 30)];
    button.backgroundColor= [UIColor blackColor];
    [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
