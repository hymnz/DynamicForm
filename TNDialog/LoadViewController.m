//
//  LoadViewController.m
//  TNDialog
//
//  Created by kantawit on 7/30/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import "LoadViewController.h"

@interface LoadViewController ()

@end

@implementation LoadViewController

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
    
	NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDir error:nil];
    NSArray *jsonArray = [dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.json'"]];
    
    QRootElement *root = [[QRootElement alloc] init];
    QSection *sectionSamples = [[QSection alloc] init];
    root.grouped = YES;
    root.title = @"QuickDialog!";
    
    
    for (int i =0; i<[jsonArray count]; i++) {
        NSString *str = [[NSString alloc] initWithString:[[jsonArray objectAtIndex:i] stringByReplacingOccurrencesOfString:@".json" withString:@""]];
        [sectionSamples addElement:[[QRootElement alloc] initWithJSONFile:str]];
    }
    [root addSection:sectionSamples];
    
    
    UINavigationController *navigation = [QuickDialogController controllerWithNavigationForRoot:root];
    [self presentViewController:navigation animated:YES completion:nil];
//    //[self.navigationController pushViewController:[QuickDialogController controllerForRoot:root] animated:YES];
    
}

-(void)saveData
{
    NSLog(@"fff");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
