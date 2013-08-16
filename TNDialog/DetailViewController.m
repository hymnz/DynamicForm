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
QRootElement *root;
int rowCount;
@implementation DetailViewController
@synthesize typeViewController = _typeViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.title = @"Detail";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([_selectedType isEqualToString:@"QButtonElement"] || [_selectedType isEqualToString:@"QDateTimeInlineElement"] || [_selectedType isEqualToString:@"QDecimalElement"] || [_selectedType isEqualToString:@"QFloatElement"]) {
        root = [[QRootElement alloc] initWithResourceJSONFile:@"Button"];
    }
    else if ([_selectedType isEqualToString:@"QLabelElement"]) {
        root = [[QRootElement alloc] initWithResourceJSONFile:@"Label"];
    }
    else if ([_selectedType isEqualToString:@"QBadgeElement"]) {
        root = [[QRootElement alloc] initWithResourceJSONFile:@"Badge"];
    }
    else if ([_selectedType isEqualToString:@"QBooleanElement"]) {
        root = [[QRootElement alloc] initWithResourceJSONFile:@"Boolean"];
    }
    else if ([_selectedType isEqualToString:@"QEntryElement"]) {
        root = [[QRootElement alloc] initWithResourceJSONFile:@"Entry"];
    }
    else if ([_selectedType isEqualToString:@"QMapElement"]) {
        root = [[QRootElement alloc] initWithResourceJSONFile:@"Map"];
    }
    else if ([_selectedType isEqualToString:@"QTextElement"]) {
        root = [[QRootElement alloc] initWithResourceJSONFile:@"Text"];
    }
    else if ([_selectedType isEqualToString:@"QEntryElement"]) {
        root = [[QRootElement alloc] initWithResourceJSONFile:@"Entry"];
    }
    else if ([_selectedType isEqualToString:@"QWebElement"]) {
        root = [[QRootElement alloc] initWithResourceJSONFile:@"Web"];
    }
    else if ([_selectedType isEqualToString:@"QColorPickerElement"] || [_selectedType isEqualToString:@"QSegmentedElement"] || [_selectedType isEqualToString:@"QPickerElement"]) {
        root = [[QRootElement alloc] initWithResourceJSONFile:@"Picker"];
    }
    else if ([_selectedType isEqualToString:@"QRadioElement"]) {
        root = [[QRootElement alloc] initWithResourceJSONFile:@"Radio"];
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
        QElement *element = [root elementWithIndex:[NSIndexPath indexPathForItem:i inSection:0]];
        if ([element isKindOfClass:[QEntryElement class]]){
            [dict setObject:((QEntryElement*)element).textValue forKey:((QEntryElement*)element).title];
        }
        else if ([element isKindOfClass:[QBooleanElement class]]){
            [dict setObject:[NSNumber numberWithBool:((QBooleanElement*)element).boolValue]  forKey:((QBooleanElement*)element).title];
        }
        
//        [dict setObject:((QEntryTableViewCell*)[[root elementWithIndex:[NSIndexPath indexPathForItem:i inSection:0]] getCellForTableView:nil controller:nil]).textField.text forKey:((QEntryTableViewCell*)[[root elementWithIndex:[NSIndexPath indexPathForItem:i inSection:0]] getCellForTableView:nil controller:nil]).textLabel.text];
    }
    
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
    
    NSData* json = [NSJSONSerialization dataWithJSONObject:_typeViewController.saveFormViewController.dictSection options:0 error:nil];
    return json;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
