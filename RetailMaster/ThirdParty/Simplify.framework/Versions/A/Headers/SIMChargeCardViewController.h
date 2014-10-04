#import <UIKit/UIKit.h>
#import "SIMCreditCardToken.h"

/**
 Public Protocol for communicating success or failure of the token generation after the user completes data entry.
 */

@protocol SIMChargeCardViewControllerDelegate

/**
 Token cancel Callback. The User has elected to cancel the token generation workflow.
 */
-(void)chargeCardCancelled;

/**
 Token failure Callback. If token generation fails, this will be called back and an error will be provided with a localizedDescription and code.
 */
-(void)creditCardTokenFailedWithError:(NSError *)error;

/**
 Token success Callback. If token generation succeeds, this will be called back and the fully hydrated credit card token.
 */
-(void)creditCardTokenProcessed:(SIMCreditCardToken *)token;

@end

/**
 This is the turn key solution. Simply create a SIMChargeCardViewController, signup as a SIMChargeCardViewControllerDelegate and implement the callbacks. All card input validation and token creation is handled for you. You simply present the UIViewController subclass and wait for for the token.

 */

@interface SIMChargeCardViewController : UIViewController

-(instancetype)initWithPublicKey:(NSString *)publicKey;
-(instancetype)initWithPublicKey:(NSString *)publicKey primaryColor:(UIColor *)primaryColor;

@property (nonatomic, weak) id <SIMChargeCardViewControllerDelegate> delegate; /**< Delegate for SIMChargeCardModelDelegate */

@end
