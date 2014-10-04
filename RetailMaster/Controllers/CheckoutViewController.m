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
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

@end
