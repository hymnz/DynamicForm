//
//  JsonViewController.m
//  TNDialog
//
//  Created by kantawit on 8/15/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import "JsonViewController.h"
#import "WebViewController.h"
#import "MapViewController.h"
@interface JsonViewController ()

@end
QRootElement *root;

@implementation JsonViewController
@synthesize selectedFile = _selectedFile;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = _selectedFile;
    NSString *strPath = [[NSString alloc] initWithString: [_selectedFile stringByReplacingOccurrencesOfString:@".json" withString:@""] ];
    root = [[QRootElement alloc] initWithJSONFile:strPath];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [root.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return ([((QSection*)[root.sections objectAtIndex:section]).elements count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    QEntryTableViewCell *cells = [[root elementWithIndex:indexPath] getCellForTableView:nil controller:nil];
    cell = cells;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get string from json in document
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *fullPath = [[paths lastObject] stringByAppendingPathComponent:_selectedFile];
    NSData *jsonData = [NSData dataWithContentsOfFile:fullPath];
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];

    if ([[[[[[dict objectForKey:@"sections"] objectAtIndex:0]objectForKey:@"elements"]objectAtIndex:0]objectForKey:@"type"] isEqualToString:@"QWebElement"]) {
        NSString *urlWeb = [[[[[dict objectForKey:@"sections"] objectAtIndex:0]objectForKey:@"elements"]objectAtIndex:0]objectForKey:@"url"];       
        WebViewController *webViewController = [[WebViewController alloc]init];
        webViewController.urlWeb = urlWeb;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    else if ([[[[[[dict objectForKey:@"sections"] objectAtIndex:0]objectForKey:@"elements"]objectAtIndex:0]objectForKey:@"type"] isEqualToString:@"QMapElement"]) {
        float latitude = [[[[[[dict objectForKey:@"sections"] objectAtIndex:0]objectForKey:@"elements"]objectAtIndex:0]objectForKey:@"lat"] doubleValue];
        float longtitude = [[[[[[dict objectForKey:@"sections"] objectAtIndex:0]objectForKey:@"elements"]objectAtIndex:0]objectForKey:@"lng"] doubleValue];
                
        MapViewController *mapViewController = [[MapViewController alloc]init];
        mapViewController.latitude = latitude;
        mapViewController.longtitude = longtitude;
        [self.navigationController pushViewController:mapViewController animated:YES];
    }
    
}

@end
