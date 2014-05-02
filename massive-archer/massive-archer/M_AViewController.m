//
//  M_AViewController.m
//  massive-archer
//
//  Created by yangboz on 14-5-2.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "M_AViewController.h"

@interface M_AViewController ()

@end

@implementation M_AViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = 1000;//1km
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([CLLocationManager locationServicesEnabled]) {
        [locationManager startUpdatingLocation];
    }else{
        NSLog(@"Location service is not enabled!!!");
    }
    //
    [self hackLocationFix];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Moved from %@ to %@",oldLocation,newLocation);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Received Core location error %@",error);
    [manager stopUpdatingLocation];
}

#pragma mark - HackLocationFix
- (void)hackLocationFix
{
    //CLLocation *location = [[CLLocation alloc] initWithLatitude:42 longitude:-50];
    float latitude = 26.876812;
    float longitude = 100.22569199999998;  //Any value;
    CLLocation *location= [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [self locationManager:locationManager didUpdateLocation:location fromLocation:nil];
}

- (void)startUpdatingLocation
{
    [self performSelector:@selector(hackLocationFix) withObject:nil afterDelay:0.1];
}
@end
