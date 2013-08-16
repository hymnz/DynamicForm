//
//  DetailViewController.m
//  TNDialog
//
//  Created by kantawit on 8/5/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController ()

@end
UIAlertView *alert;
UITextField *inputTitle;
NSString *titleName;
NSString *strPath;
QRootElement *root;
int rowCount;
@implementation DetailViewController
@synthesize typeViewController = _typeViewController;

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

    //Test
//    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDir error:nil];
//    NSArray *jsonArray = [dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.json'"]];
    
    
//        strPath = [[NSString alloc] initWithString: [filePath stringByReplacingOccurrencesOfString:@".json" withString:@""] ];
    if ([_selectedType isEqualToString:@"QButtonElement"] || [_selectedType isEqualToString:@"QDateTimeInlineElement"] || [_selectedType isEqualToString:@"QDecimalElement"] || [_selectedType isEqualToString:@"QfloatElement"]) {
        root = [[QRootElement alloc] initWithJSONFile:@"Button"];
    }
    else if ([_selectedType isEqualToString:@"QLabelElement"]) {
        root = [[QRootElement alloc] initWithJSONFile:@"Label"];
    }
    else if ([_selectedType isEqualToString:@"QBadgeElement"]) {
        root = [[QRootElement alloc] initWithJSONFile:@"Badge"];
    }
    else if ([_selectedType isEqualToString:@"QBooleanElement"]) {
        root = [[QRootElement alloc] initWithJSONFile:@"Boolean"];
    }
    else if ([_selectedType isEqualToString:@"QEntryElement"]) {
        root = [[QRootElement alloc] initWithJSONFile:@"Entry"];
    }
    else if ([_selectedType isEqualToString:@"QMapElement"]) {
        root = [[QRootElement alloc] initWithJSONFile:@"Map"];
    }
    else if ([_selectedType isEqualToString:@"QTextElement"]) {
        root = [[QRootElement alloc] initWithJSONFile:@"Text"];
    }
    else if ([_selectedType isEqualToString:@"QEntryElement"]) {
        root = [[QRootElement alloc] initWithJSONFile:@"Entry"];
    }
    else if ([_selectedType isEqualToString:@"QWebElement"]) {
        root = [[QRootElement alloc] initWithJSONFile:@"Web"];
    }
    else if ([_selectedType isEqualToString:@"QColorPickerElement"] || [_selectedType isEqualToString:@"QSegmentedElement"] || [_selectedType isEqualToString:@"QPickerElement"]) {
        root = [[QRootElement alloc] initWithJSONFile:@"Picker"];
    }
    else if ([_selectedType isEqualToString:@"QRadioElement"]) {
        root = [[QRootElement alloc] initWithJSONFile:@"Radio"];
    }
    
    //Add Save Button to navigationbar
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveData:)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [root.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    rowCount = [((QSection*)[root.sections objectAtIndex:section]).elements count];
    return ([((QSection*)[root.sections objectAtIndex:section]).elements count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell = [[root elementWithIndex:indexPath] getCellForTableView:nil controller:nil];
    return cell;
}

-(void)saveData:(id)sender
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];

    [dict setObject:_selectedType forKey:@"type"];
    for (int i=0; i<rowCount; i++) {
        [dict setObject:((QEntryTableViewCell*)[[root elementWithIndex:[NSIndexPath indexPathForItem:i inSection:0]] getCellForTableView:nil controller:nil]).textField.text forKey:((QEntryTableViewCell*)[[root elementWithIndex:[NSIndexPath indexPathForItem:i inSection:0]] getCellForTableView:nil controller:nil]).textLabel.text];
    }
    
    //    NSMutableArray *arrayElement = [[NSMutableArray alloc] init];
    [_typeViewController.saveFormViewController.arrayElement addObject:dict];
    
    NSMutableDictionary *dictElement = [[NSMutableDictionary alloc] init];
    [dictElement setValue:@"Controls" forKey:@"title"];
    [dictElement setValue:_typeViewController.saveFormViewController.arrayElement forKey:@"elements"];
    
    NSMutableArray *arraySection = [[NSMutableArray alloc] init];
    [arraySection addObject:dictElement];
    
    [_typeViewController.saveFormViewController.dictSection setValue:@"Sample Controls" forKey:@"title"];
    [_typeViewController.saveFormViewController.dictSection setValue:arraySection forKey:@"sections"];
    [_typeViewController.saveFormViewController.dictSection setValue:[NSNumber numberWithBool:YES] forKey:@"grouped"];
    
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
    
    //Old
//    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *filePath = [[[documentsDir stringByAppendingString:@"/"] stringByAppendingString:@"tmp"] stringByAppendingString:@".json"];
//    NSError *error = nil;
//    [[self jsonFromtitleName:titleName andtypeName:_selectedType] writeToFile:filePath options:NSDataWritingAtomic error:&error];
//    NSLog(@"Write returned error: %@", [error localizedDescription]);

    //Test
   
    //_typeViewController.saveFormViewController.data = [self jsonFromtitleName:titleName andtypeName:_selectedType];

//
//    alert = [[UIAlertView alloc] initWithTitle:@"Save" message:@"Input file name." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
//    alert.delegate = self;
//    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
//    [alert show];
}

-(NSData*)jsonFromtitleName:(NSString*)title andtypeName:(NSString*)type
{

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:type forKey:@"type"];
    [dict setObject:title forKey:@"title"];
    
//    NSMutableArray *arrayElement = [[NSMutableArray alloc] init];
    [_typeViewController.saveFormViewController.arrayElement addObject:dict];
    NSLog(@"S: %@",_typeViewController.saveFormViewController.arrayElement);
    
    NSMutableDictionary *dictElement = [[NSMutableDictionary alloc] init];
    [dictElement setValue:@"Controls" forKey:@"title"];
    [dictElement setValue:_typeViewController.saveFormViewController.arrayElement forKey:@"elements"];
    
    NSMutableArray *arraySection = [[NSMutableArray alloc] init];
    [arraySection addObject:dictElement];
    
    [_typeViewController.saveFormViewController.dictSection setValue:@"Sample Controls" forKey:@"title"];
    [_typeViewController.saveFormViewController.dictSection setValue:arraySection forKey:@"sections"];
    [_typeViewController.saveFormViewController.dictSection setValue:[NSNumber numberWithBool:YES] forKey:@"grouped"];
    
    //    NSDictionary* dic = @{@"grouped" : @"true",@"section" :@{@"Username" : @"me", @"Firstname" : firstName, @"Lastname" : lastName}};
    NSData* json = [NSJSONSerialization dataWithJSONObject:_typeViewController.saveFormViewController.dictSection options:0 error:nil];
    return json;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
