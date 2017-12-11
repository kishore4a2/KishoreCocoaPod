//
//  ViewController.m
//  Play_24X7
//
//  Created by Kishore on 04/12/17.
//  Copyright © 2017 Way. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"
#import "UIImageView+AFNetworking.h"
#import "ImagesCollectionViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imagesArray = [[NSMutableArray alloc]init];
    
    adfadsf.constant = 100;
    
    [self getDataFromServer];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)getDataFromServer
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[DataManager sharedManager]getFlickrList:^void(NSMutableDictionary * response) {
                
        [imagesArray addObjectsFromArray:[[response valueForKey:@"photos"]valueForKey:@"photo"]];
        
        NSLog(@"the response is %@", imagesArray);
        
        [flickrCollectionView reloadData];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        });
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imagesArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"flickrCell";
   
    ImagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *imageUrl = [NSString stringWithFormat:kImagesUrl,[[imagesArray objectAtIndex:indexPath.row]valueForKey:kFarm],[[imagesArray objectAtIndex:indexPath.row]valueForKey:kServer],[[imagesArray objectAtIndex:indexPath.row]valueForKey:kId],[[imagesArray objectAtIndex:indexPath.row]valueForKey:kSecret]];
    
     [cell.flickrImageView setImageWithURL:[NSURL URLWithString:imageUrl]];
    
    if (indexPath.row == [imagesArray count]-1)
    {
        [self getDataFromServer];
    }
    
   return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/3 - 1, [UIScreen mainScreen].bounds.size.width/3 - 2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
