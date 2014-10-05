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
    
    NSString *Calcium = [[NSString alloc] initWithFormat:@"Calcium %@",[myObject.nutritionFact objectForKey:@"Calcium"]];
    NSString *Calories = [[NSString alloc] initWithFormat:@"Calories %@",[myObject.nutritionFact objectForKey:@"Calories"]];
    NSString *Carb = [[NSString alloc] initWithFormat:@"Carb %@",[myObject.nutritionFact objectForKey:@"Carb"]];
    NSString *Fat = [[NSString alloc] initWithFormat:@"Fat %@",[myObject.nutritionFact objectForKey:@"Fat"]];
    NSString *Iron = [[NSString alloc] initWithFormat:@"Iron %@",[myObject.nutritionFact objectForKey:@"Iron"]];
    NSString *Protein = [[NSString alloc] initWithFormat:@"Protein %@",[myObject.nutritionFact objectForKey:@"Protein"]];
    NSString *VitaminA = [[NSString alloc] initWithFormat:@"VitaminA %@",[myObject.nutritionFact objectForKey:@"VitaminA"]];
    NSString *VitaminB = [[NSString alloc] initWithFormat:@"VitaminB %@",[myObject.nutritionFact objectForKey:@"VitaminB"]];
    NSString *VitaminC = [[NSString alloc] initWithFormat:@"VitaminC %@",[myObject.nutritionFact objectForKey:@"VitaminC"]];
    NSString *VitaminD = [[NSString alloc] initWithFormat:@"VitaminD %@",[myObject.nutritionFact objectForKey:@"VitaminD"]];
    NSString *VitaminE = [[NSString alloc] initWithFormat:@"VitaminE %@",[myObject.nutritionFact objectForKey:@"VitaminE"]];
    
    [self.nutritionArray addObject:@"Nutrition Info"];
    [self.nutritionArray addObject:Calcium];
    [self.nutritionArray addObject:Calories];
    [self.nutritionArray addObject:Carb];
    [self.nutritionArray addObject:Fat];
    [self.nutritionArray addObject:Iron];
    [self.nutritionArray addObject:Protein];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nutritionArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *cell;
//    
//    static NSString *cellIdentifier = @"DetailCell";
//    
//    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if(cell == nil) {
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
//    }
    
    static NSString *CellIdentifier = @"CellIdentifier";
    DetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailsTableViewCell" owner:self options:nil];
        cell = (DetailsTableViewCell *)[nib objectAtIndex:0];
    }
    
    
    //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0){
        cell.font = [UIFont boldSystemFontOfSize:20.0];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[nutritionArray objectAtIndex:indexPath.row]];
    return cell;
}


@end
