//
//  LocationViewController.m
//  RetailMaster
//
//  Created by Jack on 2014-10-04.
//  Copyright (c) 2014 CZLabs. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationCell.h"

@interface LocationViewController () {
    NSMutableArray *locationArray;
}

@end

@implementation LocationViewController

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
    // Do any additional setup after loading the view.
    locationArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *longos = [[NSMutableDictionary alloc]init];
    [longos setObject:@"Longos" forKey:@"name"];
    [longos setObject:@"15 York Street" forKey:@"location"];
    [longos setObject:@"Longos.jpg" forKey:@"image"];
    [locationArray addObject:longos];
    
    NSMutableDictionary *sobeys = [[NSMutableDictionary alloc]init];
    [sobeys setObject:@"Sobeys" forKey:@"name"];
    [sobeys setObject:@"777 Bay St" forKey:@"location"];
    [sobeys setObject:@"Sobeys.jpg" forKey:@"image"];
    [locationArray addObject:sobeys];
    
    NSMutableDictionary *loblaws = [[NSMutableDictionary alloc]init];
    [loblaws setObject:@"Loblaws" forKey:@"name"];
    [loblaws setObject:@"585 Queen St W" forKey:@"location"];
    [loblaws setObject:@"Loblaws.png" forKey:@"image"];
    [locationArray addObject:loblaws];
    
    NSMutableDictionary *zehrs = [[NSMutableDictionary alloc]init];
    [zehrs setObject:@"Zehrs" forKey:@"name"];
    [zehrs setObject:@"487 Queen St S" forKey:@"location"];
    [zehrs setObject:@"Zehrs.png" forKey:@"image"];
    [locationArray addObject:zehrs];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (IBAction)cancelHit:(id)sender {
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [locationArray count];    //count number of row from counting array hear cataGorry is An Array
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Cell";
    
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[LocationCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:MyIdentifier];
    }
    
    NSDictionary *locationDic = [locationArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.nameLabel.text = [locationDic objectForKey:@"name"];
    cell.detailLabel.text = [locationDic objectForKey:@"location"];
    cell.imageName = [locationDic objectForKey:@"image"];
    NSLog(@"Name: %@",cell.imageName);
    
    [cell assignImage];
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
