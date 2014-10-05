//
//  DetailsViewController.m
//  RetailMaster
//
//  Created by Helen Jiang on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "DetailsViewController.h"
#import "Item.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize nutritionArray, myObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    self.nutritionArray = [[NSMutableArray alloc] init];
    
    [self.nutritionArray addObject:[myObject.nutritionFact objectForKey:@"Calcium"]];
    [self.nutritionArray addObject:[myObject.nutritionFact objectForKey:@"Calories"]];
    [self.nutritionArray addObject:[myObject.nutritionFact objectForKey:@"Carb"]];
    [self.nutritionArray addObject:[myObject.nutritionFact objectForKey:@"Fat"]];
    [self.nutritionArray addObject:[myObject.nutritionFact objectForKey:@"Iron"]];
    [self.nutritionArray addObject:[myObject.nutritionFact objectForKey:@"Protein"]];
    [self.nutritionArray addObject:[myObject.nutritionFact objectForKey:@"VitaminA"]];
    [self.nutritionArray addObject:[myObject.nutritionFact objectForKey:@"VitaminB"]];
    [self.nutritionArray addObject:[myObject.nutritionFact objectForKey:@"VitaminC"]];
    [self.nutritionArray addObject:[myObject.nutritionFact objectForKey:@"VitaminD"]];
    [self.nutritionArray addObject:[myObject.nutritionFact objectForKey:@"VitaminE"]];
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:myObject.imageURL]];
    self.headerNameLabel.text = myObject.itemDescription;
    self.headerPriceLabel.text = [NSString stringWithFormat:@"$ %0.2f", [myObject.price doubleValue]];
    
    [self.tableview setTableHeaderView:self.header];
}

#pragma mark - Tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nutritionArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    static NSString *cellIdentifier = @"detailCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    
    //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[nutritionArray objectAtIndex:indexPath.row]];
    return cell;
}


@end
