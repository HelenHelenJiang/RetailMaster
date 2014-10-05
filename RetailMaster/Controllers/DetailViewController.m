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
    [headerView addSubview:itemImage];
    [headerView addSubview:nameView];
    [headerView addSubview:priceView];
    [headerView addSubview:buttonView];
    ////    [cell.itemImageView sd_setImageWithURL:[NSURL URLWithString:item.imageURL]];
    //        int score = [[milk objectForKey:@"score"] intValue];

    nameView.text = [myObject objectForKey:@"name"];
    priceView.text = [myObject objectForKey:@"price"];
    NSString *urlStr = [myObject objectForKey:@"imageURL"];
    [itemImage sd_setImageWithURL:@"http://www.indiaretailing.com/uploads/articleimglarg/9646artimg_shutterstock_94240942-d.jpg"];
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

-(void)queryByClassName:(NSString *)className{
    PFQuery *query = [PFQuery queryWithClassName:className];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                myObject = object;
                
                NSLog(@"%@", object.objectId);
                NSLog(@"%@", object.description);
                break;
                
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}



/*-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"DetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)[indexPath row]];
    return cell;
}
*/

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
