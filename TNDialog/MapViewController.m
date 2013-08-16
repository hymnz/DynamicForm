//
//  MapViewController.m
//  TNDialog
//
//  Created by kantawit on 8/16/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import "MapViewController.h"
#import "Annotation.h"
@interface MapViewController ()

@end

@implementation MapViewController
@synthesize latitude = _latitude;
@synthesize longtitude = _longtitude;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
    // Set some coordinates for our position (Buckingham Palace!)
	CLLocationCoordinate2D location;
	location.latitude = _latitude;
	location.longitude = _longtitude;
    
	// Add the annotation to our map view
	 Annotation *newAnnotation = [[Annotation alloc] initWithTitle:@"I'm here" andCoordinate:location];
	[mapView addAnnotation:newAnnotation];
    
    
}
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
	MKAnnotationView *annotationView = [views objectAtIndex:0];
	id <MKAnnotation> mp = [annotationView annotation];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 1500, 1500);
	[mv setRegion:region animated:YES];
	[mv selectAnnotation:mp animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
