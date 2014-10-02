/**
 @mainpage
 Simplify by Mastercard iOS SDK. Start taking payments today.
 
 @section intro_sec Introduction
 Welcome to the Simplify SDK and sample app. You can use this SDK to generate a card token for a payment, and the sample app is included for you to see how to properly use the SDK. The sample app uses a SIMChargeCardViewController to handle the complete lifecycle of user input to token generation. But, there are two other avenues through which you can request a payment token: SIMSimplify and SIMChargeCardModel.
 
 @section implementation_sec Implementation
 
 You can implement the SDK using three different mechanisms: SIMChargeCardViewController,  SIMChargeCardModel and SIMSimplify.
 <br/><br/>
 SIMChargeCardViewController and SIMChargeCardViewControllerDelegate - This is the turn key solution. Simply create a SIMChargeCardViewController, signup as a SIMChargeCardViewControllerDelegate and implement the callbacks. All card input validation and token creation is handled for you. You simply present the UIViewController subclass and wait for for the token
 <br/><br/>
 SIMChargeCardModel and SIMChargeCardModelDelegate - This model allows you to input the fields required to make a payment, validates them and then allows you to retrieve a token. Create a SIMChargeCardModel, signup as a SIMChargeCardModelDelegate, implement the callbacks and then ask the SIMChargeCardModel to retrieveToken.
 <br/><br/>
 SIMSimplify - This object allows you to pass in the parameters required for tokenization and a completionHandler that will either return the token or an error.
 
 @class SIMChargeCardViewController
 
 @author Copyright (c) 2014 Mastercard International Incorporated. All Rights Reserved.
 @file
 */


@interface SIMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
