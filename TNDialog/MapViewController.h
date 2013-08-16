//
//  MapViewController.h
//  TNDialog
//
//  Created by kantawit on 8/16/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController<MKMapViewDelegate>
@property(nonatomic,assign) double latitude;
@property(nonatomic,assign) double longtitude;
@end
