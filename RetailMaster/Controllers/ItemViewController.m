//
//  ItemViewController.m
//  RetailMasterHack
//
//  Created by Helen Jiang on 2014-10-04.
//  Copyright (c) 2014 RetailMaster. All rights reserved.
//

#import "ItemViewController.h"
#import "CollectionViewCell.h"
//#import <Parse/Parse.h>

@interface ItemViewController ()

@end

@implementation ItemViewController

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
    //    [self queryByClassName:@"Frozen"];
    
    
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
    return ImageNames.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellID = @"CellID";
    CollectionViewCell *myCell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    myCell.ImageInCell.image = [UIImage imageNamed:[ImageNames objectAtIndex:indexPath.item]];
    myCell.NameLabel.text = [NameLabels objectAtIndex:indexPath.item];
    myCell.PriceLabel.text = [PriceLabels objectAtIndex:indexPath.item];
    
    return myCell;
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
