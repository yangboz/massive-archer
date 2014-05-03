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

@synthesize tableView = _tableView;
@synthesize rows = _rows;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = 1000;//1km
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([CLLocationManager locationServicesEnabled]) {
//        [locationManager startUpdatingLocation];
    }else{
        NSLog(@"Location service is not enabled!!!");
    }
    //
    #if TARGET_IPHONE_SIMULATOR
    //Simulator
    [self hackLocationFix];
    #else
    // Device
    #endif
    //TableView rows data fixture
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //
    self.rows = [[NSMutableArray alloc] initWithCapacity:5];
    [self.rows insertObject:@"Lat." atIndex:0];
    [self.rows insertObject:@"Long." atIndex:1];
    [self.rows insertObject:@"Alt." atIndex:2];
    [self.rows insertObject:@"Speed" atIndex:3];
    [self.rows insertObject:@"Course" atIndex:4];
    //Update timer in seconds
    timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(onTimerUpdate:) userInfo:nil repeats:NO];
}

- (void)onTimerUpdate:(NSTimer *)timer
{
    [locationManager startUpdatingLocation];
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
    //
    NSString *latitude = [NSString stringWithFormat:@"Lat. %f degrees",newLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"Long. %f degrees", newLocation.coordinate.longitude];
    NSString *altitude = [NSString stringWithFormat:@"Alt. %f m", newLocation.altitude];
    NSString *speed = [NSString stringWithFormat:@"Speed %f m/s", newLocation.speed];
    NSString *course =
    [NSString stringWithFormat:@"Course %f degrees", newLocation.course];
    //
    self.rows = [[NSMutableArray alloc] initWithCapacity:5];
    [self.rows insertObject:latitude atIndex:0]; [self.rows insertObject:longitude atIndex:1]; [self.rows insertObject:altitude atIndex:2]; [self.rows insertObject:speed atIndex:3];
    [self.rows insertObject:course atIndex:4];
    [self.tableView reloadData];
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
    CLLocation *newLocation= [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLLocation *oldLocation= [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [self locationManager:locationManager didUpdateLocation:newLocation fromLocation:oldLocation];
}

- (void)startUpdatingLocation
{
    [self performSelector:@selector(hackLocationFix) withObject:nil afterDelay:0.1];
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

#pragma mark - UITableViewDataSource Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell"; UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellStyleDefault;
    }
    cell.textLabel.text = [self.rows objectAtIndex:indexPath.row];

    return cell;
}

@end
