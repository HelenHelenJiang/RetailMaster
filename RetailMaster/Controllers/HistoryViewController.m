//
//  HistoryViewController.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "HistoryViewController.h"
#import "Order.h"
#import "OrderHistoryTableViewCell.h"
#import "ParseManager.h"

@interface HistoryViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation HistoryViewController

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
    self.orders = [NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
    
    [[ParseManager sharedManager] fetchOrdersFromUserID:nil Limit:100 Skip:0 Completion:^(BOOL success, NSArray *objects){
        self.orders = [objects mutableCopy];
        [self.tableview reloadData];
    }];
}

#pragma mark - Table View

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 145.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    OrderHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderHistoryTableViewCell" owner:self options:nil];
        cell = (OrderHistoryTableViewCell *)[nib objectAtIndex:0];
    }
    
    Order *order = self.orders[indexPath.row];
    
    cell.orderNumberLabel.text = order.orderNumber;
    cell.orderPriceLabel.text = [NSString stringWithFormat:@"%0.2f", [order.orderPrice doubleValue]];
    cell.orderPickupLocationLabel.text = order.orderPickupLocation;
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    Department *item = self.departments[indexPath.row];
    //    SubjectsViewController *subjectsVC = [[SubjectsViewController alloc] init];
    //    subjectsVC.department = item;
    //    [self.navigationController pushViewController:subjectsVC animated:YES];
}

@end
