//
//  sRestClient.h
//  sRestClient
//
//  Created by Sudheendra K Kaanugovi on 12/17/14.
//  Copyright (c) 2014 Sudhy Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sRestClient : NSObject

typedef void (^ServiceCallBlock) (NSDictionary *response, NSString *status);

//Takes Constructed NSURL, Data in NSString format and asychronously gives back the result

- (void) makeServiceCallWithURL:(NSURL *) url andData:(NSMutableDictionary *) requestDict success:(ServiceCallBlock)successCallBack error:(ServiceCallBlock) errorCallBack sender:(id) callerInstance;

- (void) callrestservice:(NSString *) service withModelStack:(NSMutableDictionary *) stack success:(ServiceCallBlock)successCallBack error:(ServiceCallBlock) errorCallBack sender:(id) callerInstance;



@end
