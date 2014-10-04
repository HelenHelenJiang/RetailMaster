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
#import "CheckoutItemTableViewCell.h"
#import "PickupTimeTableViewCell.h"
#import "CheckoutPayButtonTableViewCell.h"

@interface CheckoutViewController ()<UITableViewDataSource, UITableViewDelegate>

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
    // Do any additional setup after loading the view from its nib.
    self.shoppingLists = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //    self.tableView.backgroundColor = [UIColor blackColor];
    
    [[ParseManager sharedManager] fetchItemsWithCatagory:@"Bakery" Limit:10 Skip:0 Completion:^(BOOL success, NSArray *items){
        if (success)
        {
            self.shoppingLists = [items mutableCopy];
            [self.tableView reloadData];
        }
    }];
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
        default:
            return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSString *sectionName;
    switch (section)
    {
        case 0:
            return self.shoppingLists.count;
        case 1:
            return 1;
        case 2:
            return 1;
        case 3:
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
        cell.orderQuantityLabel.text = @"1";
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
        
        
        
        //        Item *item = self.shoppingLists[indexPath.row];
        //    cell.textLabel.text = item.itemDescription;
        //    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)item.orderCount];
        
        
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    Department *item = self.departments[indexPath.row];
    //    SubjectsViewController *subjectsVC = [[SubjectsViewController alloc] init];
    //    subjectsVC.department = item;
    //    [self.navigationController pushViewController:subjectsVC animated:YES];
    
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

@end
