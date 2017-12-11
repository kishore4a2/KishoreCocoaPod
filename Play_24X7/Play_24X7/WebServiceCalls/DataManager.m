//  DataManager.m
//  Play_24X7
//
//  Created by Kishore on 04/12/17.
//  Copyright © 2017 Way. All rights reserved.


#import "DataManager.h"

@implementation DataManager

+ (id)sharedManager
{
    static DataManager *sharedManager = nil;

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        

    });
    return sharedManager;
}
- (NSArray *)getFlickrList:(ServiceResponseBlock)onCompletionBlock
{
    pagesCount = pagesCount + 1;
    
    [[WebserviceCall sharedManager]flickerImages:pagesCount sendRequestonCompletion:^void(NSMutableDictionary * response) {
        
        onCompletionBlock(response);
        
    }onFailure:^(id error) {
        NSLog(@"failure");
    }];
    return nil;
}


@end
