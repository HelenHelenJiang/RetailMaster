//
//  CheckoutViewController.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "CheckoutViewController.h"
#import "Item.h"
#import "ParseManager.h"
#import "DataManager.h"
#import "CheckoutItemTableViewCell.h"
#import "PickupTimeTableViewCell.h"
#import "CheckoutPayButtonTableViewCell.h"
#import "OrderConformationViewController.h"
#import "Order.h"
#import "SIMProductViewController.h"

// Mastercard
#import "SIMProductViewController.h"
#import <Simplify/SIMChargeCardViewController.h>
#import <Simplify/SIMButton.h>
#import <Simplify/UIImage+Simplify.h>
#import <Simplify/UIColor+Simplify.h>
#import <Simplify/SIMResponseViewController.h>


#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface CheckoutViewController ()<UITableViewDataSource, UITableViewDelegate,SIMChargeCardViewControllerDelegate>

@property (strong, nonatomic) UIToolbar *datePickToolbar;
@property (strong, nonatomic) UIDatePicker *datePick;
@property (strong, nonatomic) NSDate *pickupDate;
@property (nonatomic, strong) SIMChargeCardViewController *chargeController;
@property (strong, nonatomic) UIColor *primaryColor;

@end

@implementation CheckoutViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    self.navigationItem.title = @"Checkout";
    
    // Do any additional setup after loading the view from its nib.
    self.shoppingLists = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.pickupDate = [self nextHourDate:[NSDate date]];
    self.primaryColor = [UIColor orangeColor];
    
    //    self.tableView.backgroundColor = [UIColor blackColor];
    
//    [[ParseManager sharedManager] fetchItemsWithCatagory:@"Bakery" Limit:10 Skip:0 Completion:^(BOOL success, NSArray *items){
//        if (success)
//        {
//            self.shoppingLists = [items mutableCopy];
//            [self.tableView reloadData];
//        }
//    }];
    self.navigationController.navigationBar.barTintColor = RGB(238, 220, 137);
    [self loadData];
}

- (NSDate*)nextHourDate:(NSDate*)inDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components: NSEraCalendarUnit|NSYearCalendarUnit| NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit fromDate: inDate];
    [comps setHour: [comps hour]+1]; // Here you may also need to check if it's the last hour of the day
    return [calendar dateFromComponents:comps];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}

- (void)loadData
{
    self.shoppingLists = [DataManager sharedManager].shoppingLists;
    [self.tableView reloadData];
}

- (float)getTotalPrice
{
    __block float totalPrice = 0;
    
    [self.shoppingLists enumerateObjectsUsingBlock:^(Item *item, NSUInteger index, BOOL *stop){
        totalPrice += [item.price doubleValue] * item.orderCount;
    }];
    
    return totalPrice;
}

#pragma mark - Table View

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.section)
    {
        case 0:
            return 44.0f;
        case 1:
            return 60.0f;
        case 2:
            return 44.0f;
        case 3:
            return 44.0f;
        case 4:
            return 60.0f;
        default:
            return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSString *sectionName;
    switch (section)
    {
        case 0:
            return self.shoppingLists.count + 1;
        case 1:
            return 1;
        case 2:
            return 1;
        case 3:
            return 1;
        case 4:
            return 1;
        default:
            return 0;
    }
    //    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == self.shoppingLists.count)
        {
            UITableViewCell *cell;
            
            static NSString *cellIdentifier = @"SubtotalCell";
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if(cell == nil) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            }
            
            //        Building *item = self.buildings[indexPath.row];
            cell.textLabel.text = @"Total: ";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"$%.02f", [self getTotalPrice]];
            
            //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
        
        static NSString *CheckOutCellIdentifier = @"CheckOutCellIdentifier";
        CheckoutItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CheckOutCellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CheckoutItemTableViewCell" owner:self options:nil];
            cell = (CheckoutItemTableViewCell *)[nib objectAtIndex:0];
        }
        
        
        Item *item = self.shoppingLists[indexPath.row];
        //    cell.textLabel.text = item.itemDescription;
        //    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)item.orderCount];
        
        cell.itemNameLabel.text = item.name;
        cell.orderQuantityLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)item.orderCount];
        cell.orderPriceLabel.text = [NSString stringWithFormat:@"%@", item.price];
        
        //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
        
        return cell;
        
    }
    else if (indexPath.section == 1)
    {
        static NSString *PickupTimeCellIdentifier = @"PickupTimeCellIdentifier";
        PickupTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PickupTimeCellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PickupTimeTableViewCell" owner:self options:nil];
            cell = (PickupTimeTableViewCell *)[nib objectAtIndex:0];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm a"];
        NSString *currentTime = [dateFormatter stringFromDate:self.pickupDate];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEEE, MMM d"];
        NSString *prettyVersion = [dateFormat stringFromDate:self.pickupDate];
        
        NSLog(@"%@", prettyVersion);
        
        cell.dateLabel.text = prettyVersion;
        cell.timeLabel.text = currentTime;
        
        //        Item *item = self.shoppingLists[indexPath.row];
        //    cell.textLabel.text = item.itemDescription;
        //    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)item.orderCount];
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    }
    else if (indexPath.section == 2)
    {
        UITableViewCell *cell;
        
        static NSString *cellIdentifier = @"Cell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        
        //        Building *item = self.buildings[indexPath.row];
        cell.textLabel.text = @"123456789";
        cell.detailTextLabel.text = @"1234 Points";
        
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    else if (indexPath.section == 3)
    {
        static NSString *PayButtonCellIdentifier = @"PayButtonCellIdentifier";
        CheckoutPayButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PayButtonCellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CheckoutPayButtonTableViewCell" owner:self options:nil];
            cell = (CheckoutPayButtonTableViewCell *)[nib objectAtIndex:0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.payButton addTarget:self action:@selector(payButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.payButton setEnabled:self.shoppingLists.count == 0 ? NO : YES];
        [cell.payButton setBackgroundColor:self.shoppingLists.count == 0 ? [UIColor lightGrayColor] : [UIColor colorWithRed:214/255.0 green:93/255.0 blue:79/255.0 alpha:1]];
        
        //        Item *item = self.shoppingLists[indexPath.row];
        //    cell.textLabel.text = item.itemDescription;
        //    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)item.orderCount];
        
        
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    else if (indexPath.section == 4)
    {
        UITableViewCell *cell;
        
        static NSString *cellIdentifier = @"Cell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        
        //        Building *item = self.buildings[indexPath.row];
        //        cell.textLabel.text = @"123456789";
        //        cell.detailTextLabel.text = @"1234 Points";
        
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
//        cell.contentView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    Department *item = self.departments[indexPath.row];
    //    SubjectsViewController *subjectsVC = [[SubjectsViewController alloc] init];
    //    subjectsVC.department = item;
    //    [self.navigationController pushViewController:subjectsVC animated:YES];
    if (indexPath.section == 1)
    {
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:4];
        [[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        if (!self.datePick)
        {
            self.datePick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 340, 0, 0)];
            
            // One hour from now
            NSDate *minDate = [[NSDate alloc] initWithTimeIntervalSinceNow:60*60];
            // 7 Days from now
            NSDate *maxDate = [[NSDate alloc] initWithTimeIntervalSinceNow:7*24*60*60];
            
            self.datePick.backgroundColor = [UIColor whiteColor];
            self.datePick.minuteInterval = 15;
            self.datePick.datePickerMode =UIDatePickerModeDateAndTime;
            
            [self.datePick setMinimumDate:minDate];
            [self.datePick setMaximumDate:maxDate];
            
            [self.datePick addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        }
        
        if (!self.datePickToolbar)
        {
            self.datePickToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 40)];
            
            UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain    target:self     action:@selector(datePickDonePressed:)];
            NSArray *toolbarItems = [NSArray arrayWithObjects:spaceItem, customItem, nil];
            [self.datePickToolbar setItems:toolbarItems];
        }
        
        [self.view addSubview:self.datePickToolbar];
        [self.view addSubview:self.datePick];
    }
}

- (void)datePickDonePressed:(id)sender
{
    [self.datePick removeFromSuperview];
    [self.datePickToolbar removeFromSuperview];
}

- (void)dateChanged:(UIDatePicker *)sender
{
    self.pickupDate = sender.date;
    [self.tableView reloadData];
}

- (void)payButtonPressed:(id)sender
{    
    OrderConformationViewController *orderVC = [[OrderConformationViewController alloc] init];
    
    orderVC.orderedItems = self.shoppingLists;
    
    Order *order = [Order object];
    order.orderedObjects = self.shoppingLists;
    order.orderPickupDate = self.pickupDate;
    order.orderPickupLocation = @"Toronto";
    order.orderPrice = [NSNumber numberWithDouble:[self getTotalPrice]];
    order.orderNumber = [[ParseManager sharedManager] randomStringWithLength:7];
    order.isPaid = [NSNumber numberWithBool:false];
    [order saveInBackground];
    
    orderVC.order = order;
    
//    [self.navigationController pushViewController:orderVC animated:YES];
    
//    SIMProductViewController *simVC = [[SIMProductViewController alloc] init];
////    [self.navigationController pushViewController:simVC animated:YES];
//    [self presentViewController:simVC animated:YES completion:nil];
    
    //Mastercard
    //2. Create a SIMChargeViewController with your public api key
    SIMChargeCardViewController *chargeController = [[SIMChargeCardViewController alloc] initWithPublicKey:@"sbpb_NzdlZTRkMTgtYjVkYS00ODljLWIzZjUtMzYzZWU0ZjQ4Zjg4" primaryColor:self.primaryColor];
    
    //3. Assign your class as the delegate to the SIMChargeViewController class which takes the user input and requests a token
    chargeController.delegate = self;
    self.chargeController = chargeController;
    
    //4. Add SIMChargeViewController to your view hierarchy
//    [self.navigationController pushViewController:self.chargeController animated:YES];
    [self presentViewController:self.chargeController animated:YES completion:nil];
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Shopping List";
            break;
        case 1:
            sectionName = @"Pickup Time";
            break;
        case 2:
            sectionName = @"Points Card";
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

#pragma mark - mastercard
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
    SIMResponseViewController *viewController = [[SIMResponseViewController alloc] initWithBackground:blurredView primaryColor:self.primaryColor title:@"Failure." description:@"There was a problem with the payment.\nPlease try again."];
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
    
    
    
    //[postString stringByAppendingString:[NSString stringWithFormat:@"&amount=%f", 10.0]];
    //postString = [NSString stringWithFormat:@"%@&amount=%f",postString,10.0];
    NSLog(@"URL : %@", postString);
    
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(conn) {
        
        NSLog(@"Connection Successful");
        
    } else {
        
        NSLog(@"Connection could not be made");
        
    }
    
    NSError *error;
    
    //Process Request on your own server
    
    if (error) {
        NSLog(@"error:%@", error);
        UIImageView *blurredView = [UIImage blurImage:self.view.layer];
        SIMResponseViewController *viewController = [[SIMResponseViewController alloc] initWithBackground:blurredView primaryColor:self.primaryColor title:@"Failure." description:@"There was a problem with the payment.\nPlease try again."];
        [self presentViewController:viewController animated:YES completion:nil];
        
    } else {
        OrderConformationViewController *orderVC = [[OrderConformationViewController alloc] init];
        
        orderVC.orderedItems = self.shoppingLists;
        
        Order *order = [Order object];
        order.orderedObjects = self.shoppingLists;
        order.orderPickupDate = self.pickupDate;
        order.orderPickupLocation = @"Loblaws\n585 Queen St W";
        order.orderPrice = [NSNumber numberWithDouble:[self getTotalPrice]];
        order.orderNumber = [[ParseManager sharedManager] randomStringWithLength:7];
        order.isPaid = [NSNumber numberWithBool:false];
        [order saveInBackground];
        
        orderVC.order = order;
        
        [self.navigationController pushViewController:orderVC animated:YES];
//        UIImageView *blurredView = [UIImage blurImage:self.view.layer];
//        SIMResponseViewController *viewController = [[SIMResponseViewController alloc] initWithBackground:blurredView primaryColor:self.primaryColor title:@"Success!" description:@"You purchased a cupcake!"];
//        [self presentViewController:viewController animated:YES completion:nil];
    }
    
}

@end
