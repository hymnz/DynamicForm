//
//  LoadFormViewController.m
//  TNDialog
//
//  Created by kantawit on 8/15/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import "LoadFormViewController.h"
#import "JsonViewController.h"
@interface LoadFormViewController ()

@end
QEntryTableViewCell *cells;
QRootElement *root;
NSArray *jsonArray;
UITableView *tableView;
@implementation LoadFormViewController

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
    
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDir error:nil];
    jsonArray = [dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.json'"]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
        NSLog(@"%@",jsonArray);
    return ([jsonArray count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = jsonArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JsonViewController *jsonViewController = [[ JsonViewController alloc]init];
    jsonViewController.selectedFile = jsonArray[indexPath.row];
    [self.navigationController pushViewController:jsonViewController animated:YES];
//    if (indexPath.row == rowsAmount-1) {
//        TypeViewController *typeViewController = [[TypeViewController alloc]init];
//        typeViewController.saveFormViewController = self;
//        [self.navigationController pushViewController:typeViewController animated:YES];
//        
//    }
    
}
@end
