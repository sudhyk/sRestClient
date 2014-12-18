//
//  sRestManager.h
//  sRestClient
//
//  Created by Sudheendra K Kaanugovi on 12/17/14.
//  Copyright (c) 2014 Sudhy Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sRestManager : NSObject

+ (id)sharedManager;

@property (nonatomic, retain) NSMutableDictionary *serviceConfig;


@end
