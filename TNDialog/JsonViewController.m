//
//  JsonViewController.m
//  TNDialog
//
//  Created by kantawit on 8/15/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import "JsonViewController.h"
#import "WebViewController.h"
@interface JsonViewController ()

@end
QRootElement *root;
QEntryTableViewCell *cells;
NSString *urlWeb;
@implementation JsonViewController
@synthesize selectedFile = _selectedFile;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    cells = [[root elementWithIndex:indexPath] getCellForTableView:nil controller:nil];
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
    urlWeb = [[[[[dict objectForKey:@"sections"] objectAtIndex:0]objectForKey:@"elements"]objectAtIndex:0]objectForKey:@"url"];

    if ([[[[[[dict objectForKey:@"sections"] objectAtIndex:0]objectForKey:@"elements"]objectAtIndex:0]objectForKey:@"type"] isEqualToString:@"QWebElement"]) {
               
        WebViewController *webViewController = [[WebViewController alloc]init];
        webViewController.urlWeb = urlWeb;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    
    
}

@end
