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
    
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    
    self.confirmButton.layer.cornerRadius = 5.0f;
    
    [self.tableview setTableFooterView:self.tableViewBottomView];
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"$%0.2f", [self getTotalPrice]];
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
            return 1;
        case 2:
            return 1;
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
        
        //        Building *item = self.buildings[indexPath.row];
        cell.textLabel.text = @"Pickup Date: ";
        cell.detailTextLabel.text = @"";
        
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    else
    {
        UITableViewCell *cell;
        
        static NSString *cellIdentifier = @"PickupLocation";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        
        //        Building *item = self.buildings[indexPath.row];
        cell.textLabel.text = @"Pickup Location: ";
        cell.detailTextLabel.text = @"";
        
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
    
}

@end
