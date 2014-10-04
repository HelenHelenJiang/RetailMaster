//
//  ItemViewController.m
//  RetailMasterHack
//
//  Created by Helen Jiang on 2014-10-04.
//  Copyright (c) 2014 RetailMaster. All rights reserved.
//

#import "ItemViewController.h"
#import "CollectionViewCell.h"
#import "ItemDetailView.h"
#import "ParseManager.h"
#import <Parse/Parse.h>


@interface ItemViewController ()

@end

@implementation ItemViewController

@synthesize catName;
@synthesize NameLabels;
@synthesize PriceLabels;
@synthesize ImageURLs;


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

    self.NameLabels =[NSMutableArray array];
    self.PriceLabels = [NSMutableArray array];
    self.ImageURLs = [NSMutableArray array];
    //    [self queryByClassName:@"Frozen"];
   
  /*  [[ParseManager sharedManager] fetchItemsWithCatagory:catName Limit:100 Skip:0 Completion:^(BOOL success, NSArray *objects){
        if (success)
        {
            //reload table view
        }
    }];*/
    
    [self queryByClassName:catName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return NameLabels.count;
}

-(void)queryByClassName:(NSString *)className{
    PFQuery *query = [PFQuery queryWithClassName:@"Item"];
    [query whereKey:@"catagory" equalTo:catName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d records.", objects.count);
            for (int i=0; i<objects.count; ++i) {
                PFObject *myObject = objects[i];
                NSString *myName = [myObject objectForKey:@"itemDescription"];
                NSString *myPrice = [myObject objectForKey:@"price"];
                NSString *myImageUrl = [myObject objectForKey:@"imageURL"];
                [NameLabels addObject:myName];
                [PriceLabels addObject:myPrice];
                [ImageURLs addObject:myImageUrl];
            }
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                NSLog(@"%@", object.description);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellID = @"CellID";
    CollectionViewCell *myCell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
  //  myCell.ImageInCell.image = [UIImage imageNamed:[ImageNames objectAtIndex:indexPath.item]];
    myCell.NameLabel.text = [NameLabels objectAtIndex:indexPath.item];
    myCell.PriceLabel.text = [PriceLabels objectAtIndex:indexPath.item];
    
    return myCell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ItemToDetail"]) {
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
         ItemDetailView *detailView = [segue destinationViewController];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor blueColor]; // highlight selection
    [self performSegueWithIdentifier:@"ItemToDetail" sender:nil];
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor redColor]; // Default color
}



//-(void)queryByClassName:(NSString *)className{
//    PFQuery *query = [PFQuery queryWithClassName:className];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            // The find succeeded.
//            NSLog(@"Successfully retrieved %d scores.", objects.count);
//            // Do something with the found objects
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//                NSLog(@"%@", object.description);
//            }
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
//}




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
