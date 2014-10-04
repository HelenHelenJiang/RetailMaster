//
//  WelcomeViewController.m
//  RetailMaster
//
//  Created by Jack on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "WelcomeViewController.h"
#import "RegisterViewController.h"

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
    welcomeLabel.textColor  = [UIColor orangeColor];
    welcomeLabel.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    BOOL isRegistered = [defualts objectForKey:@"isRegistered"];
    
    if (isRegistered) {
        
        NSString *name  = [defualts objectForKey:@"name"];
        welcomeLabel.text = [NSString stringWithFormat:@"Hi %@",name];
        
    } else {
        
        welcomeLabel.text = @"Welcome to Retail Master!";
        
    }
    
    [self.button setTitle:@"Register" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.button.backgroundColor= [UIColor orangeColor];
    self.button.layer.cornerRadius = 10;
    [self.view addSubview:self.button];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 80, 30)];
    locationLabel.textColor = [UIColor orangeColor];
    locationLabel.text = @"Location:";
    [self.view addSubview:locationLabel];
    
    UIButton *locationButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 310, 140, 50)];
    locationButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [locationButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [locationButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:locationButton];
    
    if (isRegistered) {
        [locationButton setTitle:@"LOL" forState:UIControlStateNormal];
    } else {
        
        [locationButton setTitle:@"pick a retail store location" forState:UIControlStateNormal];
    }
    
    [self.view addSubview:locationButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     
     
     
     
 }

@end