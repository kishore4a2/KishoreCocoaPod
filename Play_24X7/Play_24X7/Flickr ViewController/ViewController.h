//
//  ViewController.h
//  Play_24X7
//
//  Created by Kishore on 04/12/17.
//  Copyright © 2017 Way. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
{
     NSMutableArray *imagesArray;
    
    __weak IBOutlet NSLayoutConstraint *adfadsf;
    IBOutlet UICollectionView *flickrCollectionView;
}

@end

