//
//  M_AAnnotation.h
//  massive-archer
//
//  Created by yangboz on 14-5-4.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//
//The SimpleAnnotation class is just a container; it implements the MKAnnotation protocol to allow it to hold the coordinates and title (with subtitle) of our annotation.

#import <Foundation/Foundation.h>

@interface M_AAnnotation : NSObject <MKAnnotation>
{}
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;

+(id)annotationWithCoordinate:(CLLocationCoordinate2D) coord;
-(id)initWithCoordinate:(CLLocationCoordinate2D) coord;

@end
