//
//  SaveViewController.m
//  TNDialog
//
//  Created by kantawit on 7/29/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import "SaveViewController.h"

@interface SaveViewController ()

@end
UITextField *titleText;
UITextField *typeText;
UITextField *fileNameText;
NSArray *typeArray;
UIPickerView *myPickerView;
int textID;
@implementation SaveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor grayColor];
        
        myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
        myPickerView.delegate = self;
        myPickerView.showsSelectionIndicator = YES;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    typeArray = [[NSArray alloc] initWithObjects:
                         @"QLabelElement", @"QButtonElement", @"QTextElement", nil];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
    [titleLabel setText:@"Title:"];
    [self.view addSubview:titleLabel];
    
    titleText = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, 70, 20)];
    titleText.backgroundColor = [UIColor whiteColor];
    titleText.tag = 1;
    [self.view addSubview:titleText];
    
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 45, 20)];
    [typeLabel setText:@"Type:"];
    [self.view addSubview:typeLabel];
    
    typeText = [[UITextField alloc]initWithFrame:CGRectMake(190, 10, 120, 20)];
    typeText.backgroundColor = [UIColor whiteColor];
    typeText.tag = 2;
    [self.view addSubview:typeText];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 80, 20)];
    [nameLabel setText:@"FileName:"];
    [self.view addSubview:nameLabel];
    
    fileNameText = [[UITextField alloc]initWithFrame:CGRectMake(100, 50, 150, 20)];
    fileNameText.backgroundColor = [UIColor whiteColor];
    fileNameText.tag = 3;
    [self.view addSubview:fileNameText];
    
    titleText.delegate = self;
    typeText.delegate = self;
    fileNameText.delegate = self;
    
    UIButton *okButton = [[UIButton alloc]initWithFrame:CGRectMake(120, 150, 50, 40)];
    okButton.backgroundColor = [UIColor blueColor];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:okButton];
    
	
}
-(void)saveData
{
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [[[documentsDir stringByAppendingString:@"/"] stringByAppendingString:fileNameText.text] stringByAppendingString:@".json"];
    NSError *error = nil;
    [[self jsonFromtitleName:titleText.text andtypeName:typeText.text] writeToFile:filePath options:NSDataWritingAtomic error:&error];
    NSLog(@"Write returned error: %@", [error localizedDescription]);

}
-(NSData*)jsonFromtitleName:(NSString*)titleName andtypeName:(NSString*)typeName
{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:@"QLabelElement" forKey:@"type"];
//    [dict setObject:@"Label" forKey:@"title"];
//    
//    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]init];
//    [dict1 setObject:@"QButtonElement" forKey:@"type"];
//    [dict1 setObject:@"Button" forKey:@"title"];
//    
//    NSMutableArray *arrayElement = [[NSMutableArray alloc] init];
//    [arrayElement addObject:dict];
//    [arrayElement addObject:dict1];
//    
//    NSMutableDictionary *dictElement = [[NSMutableDictionary alloc] init];
//    [dictElement setValue:@"Controls" forKey:@"title"];
//    [dictElement setValue:arrayElement forKey:@"elements"];
//    
//    NSMutableArray *arraySection = [[NSMutableArray alloc] init];
//    [arraySection addObject:dictElement];
//    
//    NSMutableDictionary *dictSection = [[NSMutableDictionary alloc] init];
//    [dictSection setValue:@"Sample Controls" forKey:@"title"];
//    [dictSection setValue:arraySection forKey:@"sections"];
//    [dictSection setValue:[NSNumber numberWithBool:YES] forKey:@"grouped"];

    //Test
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:typeName forKey:@"type"];
    [dict setObject:titleName forKey:@"title"];
    
    
    NSMutableArray *arrayElement = [[NSMutableArray alloc] init];
    [arrayElement addObject:dict];

    NSMutableDictionary *dictElement = [[NSMutableDictionary alloc] init];
    [dictElement setValue:@"Controls" forKey:@"title"];
    [dictElement setValue:arrayElement forKey:@"elements"];
    
    NSMutableArray *arraySection = [[NSMutableArray alloc] init];
    [arraySection addObject:dictElement];
    
    NSMutableDictionary *dictSection = [[NSMutableDictionary alloc] init];
    [dictSection setValue:@"Sample Controls" forKey:@"title"];
    [dictSection setValue:arraySection forKey:@"sections"];
    [dictSection setValue:[NSNumber numberWithBool:YES] forKey:@"grouped"];
    
   //    NSDictionary* dic = @{@"grouped" : @"true",@"section" :@{@"Username" : @"me", @"Firstname" : firstName, @"Lastname" : lastName}};
    NSData* json = [NSJSONSerialization dataWithJSONObject:dictSection options:0 error:nil];
    return json;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//Show Picker
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
        if (textField.tag == 1) {
        [fileNameText resignFirstResponder];
            [myPickerView removeFromSuperview];
        textID = 1;
        return YES;
        
    }
    else if (textField.tag == 2)
    {
        [titleText resignFirstResponder];
        [fileNameText resignFirstResponder];
        
        [self.view addSubview:myPickerView];
        
        textID = 2;
        return NO;
    }
    else if (textField.tag == 3)
    {
        [titleText resignFirstResponder];
        [myPickerView removeFromSuperview];
        textID = 3;
        return YES;
    }
    return YES;
}
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [typeArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [typeArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    if (textID == 2)
    {
        typeText.text = [typeArray objectAtIndex:row];

    }

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
