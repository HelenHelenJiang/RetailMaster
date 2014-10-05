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
#import "DetailsTableViewCell.h"
#import "DataManager.h"

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
    NSString *Calcium = [[NSString alloc] initWithFormat:@"Calcium,%@",[myObject.nutritionFact objectForKey:@"Calcium"]];
    NSString *Calories = [[NSString alloc] initWithFormat:@"Calories,%@",[myObject.nutritionFact objectForKey:@"Calories"]];
    NSString *Carb = [[NSString alloc] initWithFormat:@"Carb,%@",[myObject.nutritionFact objectForKey:@"Carb"]];
    NSString *Fat = [[NSString alloc] initWithFormat:@"Fat,%@",[myObject.nutritionFact objectForKey:@"Fat"]];
    NSString *Iron = [[NSString alloc] initWithFormat:@"Iron,%@",[myObject.nutritionFact objectForKey:@"Iron"]];
    NSString *Protein = [[NSString alloc] initWithFormat:@"Protein,%@",[myObject.nutritionFact objectForKey:@"Protein"]];
    NSString *VitaminA = [[NSString alloc] initWithFormat:@"VitaminA,%@",[myObject.nutritionFact objectForKey:@"VitaminA"]];
    NSString *VitaminB = [[NSString alloc] initWithFormat:@"VitaminB,%@",[myObject.nutritionFact objectForKey:@"VitaminB"]];
    NSString *VitaminC = [[NSString alloc] initWithFormat:@"VitaminC,%@",[myObject.nutritionFact objectForKey:@"VitaminC"]];
    NSString *VitaminD = [[NSString alloc] initWithFormat:@"VitaminD,%@",[myObject.nutritionFact objectForKey:@"VitaminD"]];
    NSString *VitaminE = [[NSString alloc] initWithFormat:@"VitaminE,%@",[myObject.nutritionFact objectForKey:@"VitaminE"]];
    
    
    
    
    
    
//    [self.nutritionArray addObject:@"Nutrition Info"];
    [self.nutritionArray addObject:Calcium];
    [self.nutritionArray addObject:Calories];
    [self.nutritionArray addObject:Carb];
    [self.nutritionArray addObject:Fat];
    [self.nutritionArray addObject:Iron];
    [self.nutritionArray addObject:Protein];
//    [self.nutritionArray addObject:@"Amount per Serving"];
    [self.nutritionArray addObject:VitaminA];
    [self.nutritionArray addObject:VitaminB];
    [self.nutritionArray addObject:VitaminC];
    [self.nutritionArray addObject:VitaminD];
    [self.nutritionArray addObject:VitaminE];


    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:myObject.imageURL]];
    self.headerNameLabel.text = myObject.itemDescription;
    self.headerPriceLabel.text = [NSString stringWithFormat:@"$ %0.2f", [myObject.price doubleValue]];
    [self.addToCartButton addTarget:self action:@selector(addToCart:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.tableview.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0f];
    
    [self.tableview setTableHeaderView:self.header];
}

- (void)addToCart:(id)sender
{
    [[DataManager sharedManager] addToShoppingList:self.myObject];
}

#pragma mark - Tableview

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)
        return @"Amount per Serving";
    return @"Nutrition Info";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return 6;
    else
        return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    static NSString *cellIdentifier = @"DetailCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
//    static NSString *CellIdentifier = @"CellIdentifier";
//    DetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (cell == nil)
//    {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailsTableViewCell" owner:self options:nil];
//        cell = (DetailsTableViewCell *)[nib objectAtIndex:0];
//    }
//    
//    
//    //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    if (indexPath.row == 0){
//        cell.font = [UIFont boldSystemFontOfSize:20.0];
//    }
//    if (indexPath.row == 7){
//        cell.font = [UIFont boldSystemFontOfSize:20.0];
//    }
    
    NSString *item = [nutritionArray objectAtIndex:indexPath.section == 0 ? indexPath.row : indexPath.row+6];
    NSArray *items = [item componentsSeparatedByString:@","];
    
    cell.textLabel.text = items[0];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
    cell.detailTextLabel.text = items[1];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
    
    //cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

@end
