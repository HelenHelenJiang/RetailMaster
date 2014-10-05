#import "ViewController.h"
#import <NymiSimplify/NYMISimplyfy.h>

#import <Simplify/SIMChargeCardViewController.h>
#import <Simplify/SIMButton.h>
#import <Simplify/UIImage+Simplify.h>
#import <Simplify/UIColor+Simplify.h>
#import <Simplify/SIMResponseViewController.h>


#define kLocalIp @"127.0.0.1"
//#define kLocalIp @"67.211.125.35"

#define kLogCellId @"kLogCellId"

@interface LogTableViewCell : UITableViewCell
@end

@implementation LogTableViewCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

@end

//1. Sign up to be a SIMChargeViewControllerDelegate so that you get the callback that gives you a token
@interface ViewController () <NymiSimplifyListener, UITableViewDataSource, UITableViewDelegate, SIMChargeCardViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, strong) SIMChargeCardViewController *chargeController;
@property (nonatomic, strong) NymiSimplify* handle;
@property (nonatomic, strong) NSMutableArray* logs;

@end

@implementation ViewController

-(void) showAlert:(NSString*) msg title:(NSString*) title {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:title message:msg
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil ];
        [errorAlert show];
    });
}


-(void) onUpdates:(NSString *)msg {
    if(msg.length) {
        NSLog(@"%@", msg);
        [self.logs insertObject:msg atIndex:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}

-(void) onReceivedError:(int) errorCode error:(NSError*) error {
    [self showAlert:[error localizedDescription] title:@"Error"];
}

-(void) onPaymentSucessful:(NSString*) response {
    [self showAlert:response title:@"Success"];
}

-(IBAction) onStart:(id)sender {
    self.logs = [NSMutableArray new];
    [self.handle discoverNymi:self withIp:kLocalIp];

}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[LogTableViewCell class] forCellReuseIdentifier:kLogCellId];
    self.logs = [NSMutableArray new];
    self.handle = [NymiSimplify new];
    self.handle.enableLogs = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Delegates

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logs.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kLogCellId
                                                            forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = self.logs[indexPath.row];
    return cell;
}

#pragma mark - Simplify Commerce

#pragma mark - Navigation
- (IBAction)buyCupcake:(id)sender {
    
    //2. Create a SIMChargeViewController with your public api key. MAKE SURE THAT THIS public key and the hosted Soimplify MATCH!
    SIMChargeCardViewController *chargeController = [[SIMChargeCardViewController alloc] initWithPublicKey:@"sbpb_NzdlZTRkMTgtYjVkYS00ODljLWIzZjUtMzYzZWU0ZjQ4Zjg4" primaryColor:nil];
    
    //3. Assign your class as the delegate to the SIMChargeViewController class which takes the user input and requests a token
    chargeController.delegate = self;
    self.chargeController = chargeController;
    
    //4. Add SIMChargeViewController to your view hierarchy
    [self presentViewController:self.chargeController animated:YES completion:nil];
    
}

#pragma mark - SIMChargeViewController Protocol
-(void)chargeCardCancelled {
    //User cancelled the SIMChargeCardViewController
    
    [self.chargeController dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"User Cancelled");
}

-(void)creditCardTokenFailedWithError:(NSError *)error {
    
    //There was a problem generating the token
    
    NSLog(@"Credit Card Token Failed with error:%@", error.localizedDescription);
    UIImageView *blurredView = [UIImage blurImage:self.view.layer];
    SIMResponseViewController *viewController = [[SIMResponseViewController alloc] initWithBackground:blurredView primaryColor:nil title:@"Failure." description:@"There was a problem with the payment.\nPlease try again."];
    [self presentViewController:viewController animated:YES completion:nil];
}

//5. This method will be called on your class whenever the user presses the Charge Card button and tokenization succeeds
-(void)creditCardTokenProcessed:(SIMCreditCardToken *)token {
    //Token was generated successfully, now you must use it
    
    NSURL *url= [NSURL URLWithString:@"http://retailmaster.herokuapp.com/charge.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = @"simplifyToken=";
    
    postString = [postString stringByAppendingString:token.token];
    
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error;
    NSURLResponse *response;
    
    //Process Request on your own server
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error) {
        NSLog(@"error:%@", error);
        UIImageView *blurredView = [UIImage blurImage:self.view.layer];
        SIMResponseViewController *viewController = [[SIMResponseViewController alloc] initWithBackground:blurredView primaryColor:nil title:@"Failure." description:@"There was a problem with the payment.\nPlease try again."];
        [self presentViewController:viewController animated:YES completion:nil];
        
    } else {
        NSLog(@"response:%@", response);
        NSLog(@"data:%@", [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil]);
        UIImageView *blurredView = [UIImage blurImage:self.view.layer];
        SIMResponseViewController *viewController = [[SIMResponseViewController alloc] initWithBackground:blurredView primaryColor:nil title:@"Success!" description:@"Transaction Successful. See log for details."];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    
}


@end
