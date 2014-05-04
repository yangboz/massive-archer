//
//  M_ADataFeedModel.m
//  massive-archer
//
//  Created by yangboz on 14-5-4.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "M_ADataFeedModel.h"

@implementation M_ADataFeedModel
//It declares a static instance of your singleton object and initializes it to nil.

static M_ADataFeedModel *sharedInstance = nil;

static NSMutableArray *dataFeedVOs = nil;

//In your class factory method for the class (named something like “sharedInstance” or “sharedManager”), it generates an instance of the class but only if the static instance is nil.
+(M_ADataFeedModel *)sharedInstance
{
	if (sharedInstance==nil) {
		sharedInstance = [[super allocWithZone:NULL] init];
        //
        dataFeedVOs = [[NSMutableArray alloc] init];
	}
	return sharedInstance;
}
//It overrides the allocWithZone: method to ensure that another instance is not allocated if someone tries to allocate and initialize an instance of your class directly instead of using the class factory method. Instead, it just returns the shared object.
+(id)allocWithZone:(NSZone *)zone
{
	return [ [self sharedInstance] copy];
}
//It implements the base protocol methods copyWithZone:, release, retain, retainCount, and autorelease to do the appropriate things to ensure singleton status. (The last four of these methods apply to memory-managed code, not to garbage-collected code.)
-(id)copyWithZone:(NSZone *)zone
{
	return self;
}
/*
 -(id)retain
 {
 return self;
 }
 
 -(NSUInteger)retainCount
 {
 return NSUIntegerMax;//denotes an object that cannot be released.
 }
 */
//-(void)release
//{
//	//do nothing.
//}

//implementations
-(NSMutableArray *)getDataFeedVOs
{
	return dataFeedVOs;
}

-(void)setDataFeedVOs:(NSMutableArray *)value
{
	dataFeedVOs = value;
}

@end
