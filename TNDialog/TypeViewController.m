//
//  TypeViewController.m
//  TNDialog
//
//  Created by kantawit on 8/5/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import "TypeViewController.h"
#import "DetailViewController.h"

@interface TypeViewController ()

@end

@implementation TypeViewController
@synthesize saveFormViewController = _saveFormViewController;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.title = @"Type";
        _listFullNameType = [[NSMutableArray alloc]initWithObjects:@"QButtonElement", @"QDateTimeInlineElement"
                     ,@"QLabelElement",@"QBadgeElement",@"QBooleanElement",@"QEntryElement",@"QMapElement",@"QTextElement",@"QWebElement"
                     ,nil];
        
        _listShortNameType = [[NSMutableArray alloc]initWithObjects:@"Button", @"DateTime"
                     ,@"Label",@"Badge",@"Boolean",@"TextField",@"Map",@"Text",@"Web"
                     ,nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_listFullNameType count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = _listShortNameType[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc]init];
    for (int i=0; i<[_listFullNameType count]; i++) {
        if (indexPath.row == i) {
            detailViewController.selectedType = [_listFullNameType objectAtIndex:indexPath.row];
        }
    }
    detailViewController.typeViewController = self;
    [self.navigationController pushViewController:detailViewController animated:YES];

}

@end
