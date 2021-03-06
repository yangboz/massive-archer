//
//  M_AViewController.m
//  massive-archer
//
//  Created by yangboz on 14-5-2.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "M_AViewController.h"

#define HONGKONG_LATITUTE 22.15
#define HONGKONG_LONGITTUTE 114.10
#define HONGKONG_TITLE @"Hong Kong"

@interface M_AViewController ()

@end

@implementation M_AViewController

@synthesize tableView = _tableView;
@synthesize rows = _rows;
@synthesize searchBar = _searchBar;

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
    #if TARGET_IPHONE_SIMULATOR
    //Simulator
    [self hackLocationFix];
    #else
    // Device
    #endif
    //
    self.rows = [[NSMutableArray alloc] initWithCapacity:5];
    [self.rows insertObject:@"Lat." atIndex:0];
    [self.rows insertObject:@"Long." atIndex:1];
    [self.rows insertObject:@"Alt." atIndex:2];
    [self.rows insertObject:@"Speed" atIndex:3];
    [self.rows insertObject:@"Course" atIndex:4];
    //Update timer in seconds
    timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(onTimerUpdate:) userInfo:nil repeats:NO];
    //Show user location
    self.mapView.showsUserLocation = YES;
    //Add annotation with HongKong
    CLLocationCoordinate2D hongKongCoord = {HONGKONG_LATITUTE,HONGKONG_LONGITTUTE};
    M_AAnnotation *hongKongAnnotation = [[M_AAnnotation alloc] initWithCoordinate:hongKongCoord];
    hongKongAnnotation.title = HONGKONG_TITLE;
    hongKongAnnotation.subtitle = @"22° 15' 0' N / 114° 10' 0' E";
    [self.mapView addAnnotation:hongKongAnnotation];
    //Select it to display
    [self.mapView selectAnnotation:hongKongAnnotation animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    CLLocationCoordinate2D hongKongCenter = CLLocationCoordinate2DMake(22, 114);
    CLLocationDistance radius = 300.0;
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:hongKongCenter radius:radius];
    [circle setTitle:@" "];
    [self.mapView addOverlay:circle];
}

- (void)onTimerUpdate:(NSTimer *)timer
{
//    [locationManager startUpdatingLocation];
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
    //Monitor or upate mapview
    double miles = 40.0;//Map Pan Zoom value.
    double scalingFactor =
    ABS( cos(2 * M_PI * newLocation.coordinate.latitude /360.0) );
    MKCoordinateSpan span;
    span.latitudeDelta = miles/69.0; span.longitudeDelta = miles/( scalingFactor*69.0 ); MKCoordinateRegion region;
    region.span = span;
    region.center = newLocation.coordinate;
    [self.mapView setRegion:region animated:YES];
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
    //TODO:fixture,sw_x: 112, sw_y: 21, ne_x: 117, ne_y: 24, zoom: 9
    float latitude = HONGKONG_LATITUTE;
    float longitude = HONGKONG_LONGITTUTE;  //Any value;
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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( section == 0 ) {
        return 1;
    } else if ( section == 1 ) {
        return 5;
    } else {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if ( indexPath.section == 0 ) {
        cell = self.mapCell;
    } else {
        static NSString *identifier = @"cell";
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"]; if ( cell == nil ) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = [self.rows objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark - MKMapViewDelegate
-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    //Overlay circle configuation.
    MKCircle *circle = overlay;
    MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:circle];
    if ([circle.title isEqualToString:HONGKONG_TITLE]) {
        circleView.fillColor = [UIColor redColor];
        circleView.alpha = 0.4;
    }
    return circleView;
}
@end
