//
//  CheckoutViewController.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "CheckoutViewController.h"
#import "Item.h"

@interface CheckoutViewController ()

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
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shoppingLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *CommentCellIdentifier = @"RankingCellIdentifier";
    //    RankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
    //
    //    if (cell == nil)
    //    {
    //        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RankingTableViewCell" owner:self options:nil];
    //        cell = (RankingTableViewCell *)[nib objectAtIndex:0];
    //    }
    //
    UITableViewCell *cell;
    
    static NSString *cellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Item *item = self.shoppingLists[indexPath.row];
    cell.textLabel.text = item.itemDescription;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)item.orderCount];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
