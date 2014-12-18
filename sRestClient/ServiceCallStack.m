//
//  ServiceCallStack.m
//  sRestClient
//
//  Created by Sudheendra K Kaanugovi on 12/18/14.
//  Copyright (c) 2014 Sudhy Studios. All rights reserved.
//

#import "ServiceCallStack.h"

@implementation ServiceCallStack
@synthesize count;

- (id)init
{
    if( self=[super init] )
    {
        m_array = [[NSMutableArray alloc] init];
        count = 0;
    }
    return self;
}
- (void)dealloc {
}
- (void)push:(id)anObject
{
    [m_array addObject:anObject];
    count = m_array.count;
}
- (id)pop
{
    id obj = nil;
    if(m_array.count > 0)
    {
        [m_array removeLastObject];
        count = m_array.count;
    }
    return obj;
}
- (void)clear
{
    [m_array removeAllObjects];
    count = 0;
}

@end
