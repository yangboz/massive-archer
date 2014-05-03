//
//  M_AViewController.h
//  massive-archer
//
//  Created by yangboz on 14-5-2.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface M_AViewController : UITableViewController
<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CLLocationManager *locationManager;
    NSTimer *timer;
}
//Properties
@property(strong,nonatomic) NSMutableArray *rows;
//IBActions
@property(strong,nonatomic) IBOutlet UITableView *tableView;
@end
