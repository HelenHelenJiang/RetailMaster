//
//  DetailViewController.m
//  RetailMaster
//
//  Created by Helen Jiang on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "DetailViewController.h"
#import "ItemsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ParseManager.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize DetailTableView;
@synthesize myObject;
@synthesize nutritionArray;

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
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, 320, 180)];
    UIImageView *itemImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 120, 170)];
    UILabel *nameView = [[UILabel alloc] initWithFrame:CGRectMake(135, 10, 50, 10)];
    UILabel *priceView = [[UILabel alloc] initWithFrame:CGRectMake(135, 25, 50, 10)];
    UIButton *buttonView = [[UIButton alloc] initWithFrame:CGRectMake(135, 35, 50, 10)];
    buttonView.imageView.image = [UIImage imageNamed:@"ShopIcon.jpg"];
    
    [headerView addSubview:itemImage];
    [headerView addSubview:nameView];
    [headerView addSubview:priceView];
    [headerView addSubview:buttonView];

    nameView.text = myObject.name;
    priceView.text = myObject.price;
    [itemImage sd_setImageWithURL:myObject.imageURL];
    CALayer *imgLayer=itemImage.layer;
    [imgLayer setCornerRadius:10];
    [imgLayer setBorderWidth:1];
    [imgLayer setMasksToBounds:YES];
    
    self.nutritionArray = [[NSMutableArray alloc] init];

    [nutritionArray addObject:[myObject.nutritionFact objectForKey:@"Calcium"]];
    [nutritionArray addObject:[myObject.nutritionFact objectForKey:@"Calories"]];
    [nutritionArray addObject:[myObject.nutritionFact objectForKey:@"Carb"]];
    [nutritionArray addObject:[myObject.nutritionFact objectForKey:@"Fat"]];
    [nutritionArray addObject:[myObject.nutritionFact objectForKey:@"Iron"]];
    [nutritionArray addObject:[myObject.nutritionFact objectForKey:@"Protein"]];
    [nutritionArray addObject:[myObject.nutritionFact objectForKey:@"VitaminA"]];
    [nutritionArray addObject:[myObject.nutritionFact objectForKey:@"VitaminB"]];
    [nutritionArray addObject:[myObject.nutritionFact objectForKey:@"VitaminC"]];
    [nutritionArray addObject:[myObject.nutritionFact objectForKey:@"VitaminD"]];
    [nutritionArray addObject:[myObject.nutritionFact objectForKey:@"VitaminE"]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"DetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    cell.textLabel.text = [NSString stringWithFormat:@"%@",[nutritionArray objectAtIndex:indexPath.row]];
    return cell;
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

@end
