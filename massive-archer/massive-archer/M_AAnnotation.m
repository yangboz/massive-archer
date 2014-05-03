//
//  M_AAnnotation.m
//  massive-archer
//
//  Created by yangboz on 14-5-4.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "M_AAnnotation.h"

@implementation M_AAnnotation
@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

+(id)annotationWithCoordinate:(CLLocationCoordinate2D)coord
{
    return [[[self class] alloc] initWithCoordinate:coord];
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord
{
    if (self = [super init]) {
        self.coordinate = coord;
    }
    return self;
}

@end
