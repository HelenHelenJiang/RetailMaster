//
//  OrderConformationViewController.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "OrderConformationViewController.h"
#import "CheckoutItemTableViewCell.h"
#import "Item.h"
#import "ParseManager.h"
#import "MBProgressHUD.h"
#import "CheckoutViewController.h"
#import "DataManager.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface OrderConformationViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation OrderConformationViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (float)getTotalPrice
{
    __block float totalPrice = 0;
    
    [self.orderedItems enumerateObjectsUsingBlock:^(Item *item, NSUInteger index, BOOL *stop){
        totalPrice += [item.price doubleValue];
    }];
    
    return totalPrice;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Confirmation";
    
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    
    self.confirmButton.layer.cornerRadius = 5.0f;
    
//    [self.tableview setTableFooterView:self.tableViewBottomView];
    
    [self.view addSubview:self.tableViewBottomView];
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"$%0.2f", [self getTotalPrice]];
    self.navigationController.navigationBar.barTintColor = RGB(238, 220, 137);
    [self.navigationController.navigationBar setTintColor:RGB(194, 121, 63)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return self.orderedItems.count;
        case 1:
            return 3;
        case 2:
            return 0;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *CheckOutCellIdentifier = @"CheckOutCellIdentifier";
        CheckoutItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CheckOutCellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CheckoutItemTableViewCell" owner:self options:nil];
            cell = (CheckoutItemTableViewCell *)[nib objectAtIndex:0];
        }
        
        Item *item = self.orderedItems[indexPath.row];
        //    cell.textLabel.text = item.itemDescription;
        //    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)item.orderCount];
        
        cell.itemNameLabel.text = item.name;
        cell.orderQuantityLabel.text = @"1";
        cell.orderPriceLabel.text = [NSString stringWithFormat:@"%@", item.price];
        
        //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        UITableViewCell *cell;
        
        static NSString *cellIdentifier = @"PickupDate";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        
        if (indexPath.row == 0)
        {
            //        Building *item = self.buildings[indexPath.row];
            cell.textLabel.text = @"Pickup Date: ";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEEE, MMM d, hh:mm a"];
            NSString *currentTime = [dateFormatter stringFromDate:self.self.order.orderPickupDate];
            
            cell.detailTextLabel.text = currentTime;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"Pickup Location: ";
            cell.detailTextLabel.text = self.order.orderPickupLocation;
        }
        else
        {
            cell.textLabel.text = @"Order #: ";
            cell.detailTextLabel.text = self.order.orderNumber;
        }
        
        return cell;
    }
    else
    {
        UITableViewCell *cell;
        
        static NSString *cellIdentifier = @"OrderNumber";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        
        //        Building *item = self.buildings[indexPath.row];
        cell.textLabel.text = @"Order #: ";
        cell.detailTextLabel.text = self.order.orderNumber;
        
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    Department *item = self.departments[indexPath.row];
    //    SubjectsViewController *subjectsVC = [[SubjectsViewController alloc] init];
    //    subjectsVC.department = item;
    //    [self.navigationController pushViewController:subjectsVC animated:YES];
}

- (IBAction)confirmBtnPressed:(id)sender
{
    self.order.isPaid = [NSNumber numberWithBool:true];
    self.order[@"OrderNumber"] = self.order.orderNumber;
    self.order[@"Price"] = [NSString stringWithFormat:@"%0.2f", [self.order.orderPrice doubleValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *currentTime = [dateFormatter stringFromDate:self.self.order.orderPickupDate];
    self.order[@"PickUpTime"] = currentTime;
    self.order[@"OrderList"] = [[ParseManager sharedManager] parseOrderToString:self.order];
    
    self.tabBarController.selectedIndex = 3;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.order saveInBackgroundWithBlock:^(BOOL successed, NSError *error){
        [[DataManager sharedManager].shoppingLists removeAllObjects];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}


@end
