//
//  DetailViewController.h
//  TNDialog
//
//  Created by kantawit on 8/5/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeViewController.h"

@interface DetailViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) NSString *selectedType;
@property(nonatomic,strong) TypeViewController* typeViewController;
@end
