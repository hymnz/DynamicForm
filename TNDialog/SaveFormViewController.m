//
//  SaveFormViewController.m
//  TNDialog
//
//  Created by kantawit on 8/5/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import "SaveFormViewController.h"
#import "TypeViewController.h"
@interface SaveFormViewController ()

@end

QRootElement *root;
UITableView *tableView;

@implementation SaveFormViewController
@synthesize dictSection = _dictSection;
@synthesize arrayElement = _arrayElement;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        ////Initial data 
        _dictSection = [[NSMutableDictionary alloc] init];
        _arrayElement = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //init Table View
    //TableVeiw
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:tableView];

    //Add Save Button to navigationbar
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveForm:)];

}

-(void)viewDidAppear:(BOOL)animated
{
    
    ///Init RootElent If Created Form has Element
    if ([_dictSection count] > 0) {
        root = [[QRootElement alloc]initWithJSON:_dictSection andData:nil];
        
        [tableView reloadData];
    }
}

-(void)saveForm:(id)sender
{
    ///Alert View when Save Action to input file name
    UIAlertView *alert;
    //Alert View
    alert = [[UIAlertView alloc] initWithTitle:@"Save" message:@"Input file name." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    alert.delegate = self;
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    ////Save Json File or cancel from alert View
    if (buttonIndex == 0) {
        NSLog(@"Cancel");
    }
    else
    {
        
        NSLog(@"%@",[alertView textFieldAtIndex:0].text);
        NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [[[documentsDir stringByAppendingString:@"/"] stringByAppendingString:[alertView textFieldAtIndex:0].text] stringByAppendingString:@".json"];
        NSError *error = nil;
        NSData* json = [NSJSONSerialization dataWithJSONObject:_dictSection options:0 error:nil];
        [json writeToFile:filePath options:NSDataWritingAtomic error:&error];
        NSLog(@"Write returned error: %@", [error localizedDescription]);
     
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([root.sections count] == 0) {
        return 1;
    }
    return [root.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return (1 + [((QSection*)[root.sections objectAtIndex:section]).elements count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    NSString *CellIdentifier = @"Cell";
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSInteger rowsAmount;
    rowsAmount = [tableView numberOfRowsInSection:[indexPath section]];
    
    if (indexPath.row == rowsAmount-1 ) {
        cell.textLabel.text = @"Add Field";
    }
    else
    {
        cell = [[root elementWithIndex:indexPath] getCellForTableView:nil controller:nil];
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger rowsAmount;
    rowsAmount = [tableView numberOfRowsInSection:[indexPath section]];
    
    if (indexPath.row == rowsAmount-1) {
        TypeViewController *typeViewController = [[TypeViewController alloc]init];
        typeViewController.saveFormViewController = self;
        [self.navigationController pushViewController:typeViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
