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
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = 1000;//1km
    if ([CLLocationManager locationServicesEnabled]) {
        [locationManager startUpdatingLocation];
    }else{
        NSLog(@"Location service is not enabled!!!");
    }
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

@end
