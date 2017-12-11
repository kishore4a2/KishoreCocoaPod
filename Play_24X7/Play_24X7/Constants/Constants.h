//
//  Constants.h
//  Play_24X7
//
//  Created by Kishore on 04/12/17.
//  Copyright © 2017 Way. All rights reserved.
//

#ifndef Constants_h
#define Constants_h
#define kServiceURL "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f2ddfcba0e5f88c2568d96dcccd09602&format=json&nojsoncallback=1&safe_search=%@&text=kittens"

#define kImagesUrl @"https://farm%@.static.flickr.com/%@/%@_%@.jpg"
#define kServiceTimeOutInterval 60


#define kFarm   @"farm"
#define kServer  @"server"
#define kId      @"id"
#define kSecret  @"secret"
#define kInternetConnection "Internet connection"
#define kNoInternetMessage "Please check your internet connection"

typedef void (^ServiceResponseBlock)(id);

#endif /* Constants_h */
