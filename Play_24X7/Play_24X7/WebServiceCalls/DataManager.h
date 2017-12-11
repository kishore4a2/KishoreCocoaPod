//
//  DataManager.h
//  Play_24X7
//
//  Created by Kishore on 04/12/17.
//  Copyright © 2017 Way. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebserviceCall.h"

@interface DataManager : NSObject
{
    int pagesCount;
}
@property (nonatomic, strong)__block WebserviceCall *requestHandler;

+ (id)sharedManager ;

- (NSArray *)getFlickrList:(ServiceResponseBlock)onCompletionBlock;
@end
