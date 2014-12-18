//
//  sRestManager.m
//  sRestClient
//
//  Created by Sudheendra K Kaanugovi on 12/17/14.
//  Copyright (c) 2014 Sudhy Studios. All rights reserved.
//

#import "sRestManager.h"

@implementation sRestManager

@synthesize serviceConfig;

#pragma mark Singleton Methods
+ (id)sharedManager {
    static sRestManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        //Configuring all properties here
        
        //Get Service Config file
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServiceConfig" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        self.serviceConfig = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


@end
