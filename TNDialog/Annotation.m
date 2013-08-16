//
//  Annotation.m
//  TNDialog
//
//  Created by kantawit on 8/16/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation
@synthesize coordinate,title,subtitle;
- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d {
	title = ttl;
	coordinate = c2d;
	return self;
}
@end
