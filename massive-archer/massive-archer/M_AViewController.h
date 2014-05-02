//
//  M_AViewController.h
//  massive-archer
//
//  Created by yangboz on 14-5-2.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface M_AViewController : UIViewController
<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}
@end
