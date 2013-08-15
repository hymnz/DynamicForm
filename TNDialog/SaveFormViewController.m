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
NSInteger rowsAmount;
QEntryTableViewCell *cells;
QRootElement *root;
int rowCount;
UITableView *tableView;
UIButton *saveButton;
UIAlertView *alert;
@implementation SaveFormViewController
@synthesize dictSection = _dictSection;
@synthesize arrayElement = _arrayElement;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    if ([_dictSection count] > 0) {
        root = [[QRootElement alloc]initWithJSON:_dictSection andData:nil];
    }
    [tableView reloadData];
    
    
    //Save Button
    [saveButton setFrame: CGRectMake(tableView.frame.size.width/2 - 30,50*rowCount, 60, 30)];
    [saveButton setTitle:@"SAVE" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveForm) forControlEvents:UIControlEventTouchDown];
    [tableView addSubview:saveButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dictSection = [[NSMutableDictionary alloc] init];
    _arrayElement = [[NSMutableArray alloc]init];
    saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveButton setFrame:CGRectMake(tableView.frame.size.width/2 - 30,50, 60, 30)];
    
    rowCount = 0;

    
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDir error:nil];
    NSArray *jsonArray = [dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.json'"]];

    
    root = [[QRootElement alloc] init];
//    QSection *sectionSamples = [[QSection alloc] init];
    root.grouped = YES;
    root.title = @"QuickDialog!";
    
    
//    for (int i =0; i<[jsonArray count]; i++) {
//        NSString *str = [[NSString alloc] initWithString:[[jsonArray objectAtIndex:1] stringByReplacingOccurrencesOfString:@".json" withString:@""]];
//        //[sectionSamples addElement:[[QRootElement alloc] initWithJSONFile:str]];
//        root = [[QRootElement alloc] initWithJSONFile:str];
//    }
//    [root addSection:sectionSamples];
    
    //TableVeiw
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(10,40, 300, 500) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:tableView];
    
}
-(void)saveForm
{
    //Alert View
    alert = [[UIAlertView alloc] initWithTitle:@"Save" message:@"Input file name." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    alert.delegate = self;
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"Cancel");
    }
    else
    {
        
        NSLog(@"%@",[alert textFieldAtIndex:0].text);
        NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [[[documentsDir stringByAppendingString:@"/"] stringByAppendingString:[alert textFieldAtIndex:0].text] stringByAppendingString:@".json"];
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
    rowCount++;
    return ([((QSection*)[root.sections objectAtIndex:section]).elements count]+1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    rowsAmount = [tableView numberOfRowsInSection:[indexPath section]];
    
    if (indexPath.row == rowsAmount-1 ) {
        cell.textLabel.text = @"Add Field";
    }
    else
    {
//        QSection *section = [root.sections objectAtIndex:0];
//        QElement *element = [section.elements objectAtIndex:0];

//        cells = [[root elementWithKey:[_listData objectAtIndex:indexPath.row]] getCellForTableView:nil controller:nil];
        cells = [[root elementWithIndex:indexPath] getCellForTableView:nil controller:nil];
        cell = cells;
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
