//
//  WebserviceCall.h
//  Play_24X7
//
//  Created by Kishore on 04/12/17.
//  Copyright © 2017 Way. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Constants.h"
#import "Reachability.h"
@interface WebserviceCall : NSObject<NSURLSessionDelegate>
{
    
}
+ (id)sharedManager;

- (BOOL)flickerImages:(int)page sendRequestonCompletion:(ServiceResponseBlock)onCompletionBlock onFailure:(ServiceResponseBlock)onFailureBlock;


@end
