//  WebserviceCall.m
//  Play_24X7
//
//  Created by Kishore on 04/12/17.
//  Copyright © 2017 Way. All rights reserved.
//


#import "WebserviceCall.h"

@implementation WebserviceCall


+ (id)sharedManager
{
    static WebserviceCall *webservicecalling = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        webservicecalling = [[self alloc] init];
        
    });
    return webservicecalling;
}

- (BOOL)flickerImages:(int)page sendRequestonCompletion:(ServiceResponseBlock)onCompletionBlock onFailure:(ServiceResponseBlock)onFailureBlock
{
    if ([self isConnectedInternet])
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^void{
            
            NSData *postData = nil;
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@kServiceURL,[NSString stringWithFormat:@"%d",page]]]
                                                                   cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                               timeoutInterval:kServiceTimeOutInterval];
            
            [request setTimeoutInterval:kServiceTimeOutInterval];
            [request setHTTPMethod:@"GET"];
            
            if(postData && [postData length])
            {
                [request setHTTPBody:postData];
            }
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
            
            NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                NSLog(@"the request is %@", request);
                
                if ([data length] > 0 && error == nil)
                {
                    NSMutableDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:&error];
                    
                    if (responseDict) {
                        dispatch_async( dispatch_get_main_queue(), ^{
                            onCompletionBlock(responseDict);
                        });
                    }
                    else{
                        
                        dispatch_async( dispatch_get_main_queue(), ^{
                            onFailureBlock(nil);
                        });
                    }
                }
                else
                {
                    dispatch_async( dispatch_get_main_queue(), ^{
                        onFailureBlock(nil);
                    });
                }
            }];
            
            [postDataTask resume];
            
            [session finishTasksAndInvalidate];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@kInternetConnection
                                                                           message:@kNoInternetMessage
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            
            
            [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alert animated:YES completion:^{
            }];
        });
    }
    return nil;
}

- (BOOL)isConnectedInternet
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    return networkStatus != NotReachable;
}

@end
