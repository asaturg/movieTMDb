//
//  APIManager.m
//  Movies
//
//  Created by Asatur Galstyan on 8/16/17.
//  Copyright © 2017 RealizeIt, LLC. All rights reserved.
//

#import "APIManager.h"
#import "NSDictionary+URLEncoding.h"

static NSString * apiUrl = @"https://api.themoviedb.org/3/movie/";
static NSString * apiKey = @"a7c0259ec7f2f9620a2bbe80cdee0022";
static NSString * imageUrl = @"http://image.tmdb.org/t/p/w500";

@implementation APIManager

+ (void)fetchNewInTheatresMoviesWithCompletion:( void (^) (id responseData, NSError *error))handler {
    
    NSString* method = @"now_playing";
    NSDictionary *params = @{ @"api_key" : apiKey};
    
    NSMutableURLRequest *request = [self requestForGetMethod:method withParams:[params urlEncodedString]];
    
    [self executeRequest:request withCompletion:handler];
}

+ (void)fetchPopularMoviesWithCompletion:( void (^) (id responseData, NSError *error))handler {
    
    NSString* method = @"popular";
    NSDictionary *params = @{ @"api_key" : apiKey};
    
    NSMutableURLRequest *request = [self requestForGetMethod:method withParams:[params urlEncodedString]];
    
    [self executeRequest:request withCompletion:handler];
}

+ (void)fetchTopRatedMoviesWithCompletion:( void (^) (id responseData, NSError *error))handler {
    NSString* method = @"top_rated";
    NSDictionary *params = @{ @"api_key" : apiKey};
    
    NSMutableURLRequest *request = [self requestForGetMethod:method withParams:[params urlEncodedString]];
    
    [self executeRequest:request withCompletion:handler];
}

#pragma mark - Request helpers

+ (void)executeRequest:(NSURLRequest*)request withCompletion:( void (^) (id responseData, NSError *error))handler  {
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            handler(data, error);
        });
    }] resume];
}

+ (NSMutableURLRequest *) requestForGetMethod:(NSString *)method withParams:(NSString *)params {
    
    NSString* url = [NSString stringWithFormat:@"%@%@", apiUrl, method];
    if (params.length > 0) {
        url = [NSString stringWithFormat:@"%@%@?%@", apiUrl, method, params];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
    [request setHTTPMethod:@"GET"];
    
    return request;
}

#pragma mark Helpers

+ (NSURL*)imageUrlForPath:(NSString *)imagePath {
    
    NSURL *url = [NSURL URLWithString:[imageUrl stringByAppendingString:imagePath]];
    
    return url;
}

@end
