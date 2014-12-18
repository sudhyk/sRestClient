//
//  sRestClient.m
//  sRestClient
//
//  Created by Sudheendra K Kaanugovi on 12/17/14.
//  Copyright (c) 2014 Sudhy Studios. All rights reserved.
//

#import "sRestClient.h"

#import "sRestManager.h"

#import "AFNetworking.h"

@implementation sRestClient


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) makeServiceCallWithURL:(NSURL *) url
                        andData:(NSMutableDictionary *) requestDict
                        success:(ServiceCallBlock)successCallBack
                          error:(ServiceCallBlock) errorCallBack
                         sender:(id) callerInstance
{
    
    
    //Create Request Object
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    
    //Convert Dict to JSON and JSON to RAW data format
    NSString *jsonRequest = [self convertRequestObjectToJSONString:requestDict];
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
   // [request setHTTPMethod:@"POST"];
   // [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
   // [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPBody: requestData];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             successCallBack(greeting, @"200");
         } else {
             errorCallBack(nil, @"500");
         }
     }];
    
    
    
}

- (NSString *) convertRequestObjectToJSONString:(NSMutableDictionary *) contentDictionary
{
    
    if(contentDictionary != nil){
    NSData *data = [NSJSONSerialization dataWithJSONObject:contentDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data
                                              encoding:NSUTF8StringEncoding];
    
    return jsonStr;
    }else
        return @"";
}

- (void) callrestservice:(NSString *)service withModelStack:(NSMutableDictionary *)stack success:(ServiceCallBlock)successCallBack error:(ServiceCallBlock)errorCallBack sender:(id)callerInstance
{
    AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager setSecurityPolicy:policy];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operationManager POST:[sRestClient getServiceURL:service]
                parameters:stack
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSLog(@"JSON: %@", [responseObject description]);
                   }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"Error: %@", [error description]);
                   }
     ];
}

+ (NSString *) getServiceURL:(NSString *) service
{
    //Get the Service Properties
    sRestManager *manager = [sRestManager sharedManager];
    NSMutableDictionary *config = manager.serviceConfig;
    NSString *url = [config valueForKeyPath:[NSString stringWithFormat:@"%@.url", service]];
    return isEmpty(url) ? @"": url;
}

       
       // Check if the "thing" pass'd is empty
static inline BOOL isEmpty(id objec) {
    return objec == nil
    || [objec isKindOfClass:[NSNull class]]
    || ([objec respondsToSelector:@selector(length)]
        && [(NSData *)objec length] == 0)
    || ([objec respondsToSelector:@selector(count)]
        && [(NSArray *)objec count] == 0);
}

@end
