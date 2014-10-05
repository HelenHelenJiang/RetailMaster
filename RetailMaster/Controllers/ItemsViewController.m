//
//  ItemsViewController.m
//  RetailMaster
//
//  Created by carlzhou on 10/4/14.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "ItemsViewController.h"
#import "ParseManager.h"
#import "Item.h"
#import "ItemsViewTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailViewController.h"

@interface ItemsViewController ()

@end

@implementation ItemsViewController

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
    
    self.navigationItem.title = self.catName;
    
    self.tableview.delaysContentTouches = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view from its nib.
    self.items = [NSMutableArray array];
    
    [[ParseManager sharedManager] fetchItemsWithCatagory:self.catName Limit:100 Skip:0 Completion:^(BOOL success, NSArray *objects){
        if (success)
        {
            self.items = [objects mutableCopy];
            [self.tableview reloadData];
        }
    }];
}


#pragma mark - Table View

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    ItemsViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemsViewTableViewCell" owner:self options:nil];
        cell = (ItemsViewTableViewCell *)[nib objectAtIndex:0];
    }
    
    Item *item = self.items[indexPath.row];
    
    [cell.itemImageView sd_setImageWithURL:[NSURL URLWithString:item.imageURL]];
    cell.itemNameLabel.text = item.itemDescription;
    cell.itemPriceLabel.text = [NSString stringWithFormat:@"$ %0.2f", [item.price doubleValue]];
//    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    
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
    
    Item *item = self.items[indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.myObject = item;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ([view isKindOfClass:[UITextView class]])
    {
        return NO;
    }
    
    return YES;
}

@end
