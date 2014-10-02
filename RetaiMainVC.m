//
//  RetaiMainVC.m
//  RetailMasterHack
//
//  Created by Jack on 2014-10-01.
//  Copyright (c) 2014 RetailMaster. All rights reserved.
//

#import "RetaiMainVC.h"
#import <Simplify/SIMChargeCardViewController.h>

@interface SIMProductViewController: UIViewController <SIMChargeCardViewControllerDelegate>

@end

@implementation SIMProductViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //2. Create a SIMChargeViewController with your public api key
    SIMChargeCardViewController *chargeVC = [[SIMChargeCardViewController alloc] initWithPublicKey:@"sbpb_NzdlZTRkMTgtYjVkYS00ODljLWIzZjUtMzYzZWU0ZjQ4Zjg4"];
    
    //3. Assign your class as the delegate to the SIMChargeViewController class which takes the user input and requests a token
    chargeVC.delegate = self;
    
    //4. Add SIMChargeViewController to your view hierarchy
    [self presentViewController:chargeVC animated:YES completion:nil];
    
}

#pragma mark SIMChargeCardViewControllerDelegate callback
//5. This method will be called on your class whenever the user presses the Charge Card button and tokenization succeeds
-(void)creditCardTokenProcessed:(SIMCreditCardToken *)token {
    
    //Process the provided token
    NSLog(@"Token:%@", token.token);
    
}

@end

@interface RetaiMainVC ()

@end

@implementation RetaiMainVC

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
