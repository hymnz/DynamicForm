//
//  TypeViewController.h
//  TNDialog
//
//  Created by kantawit on 8/5/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveFormViewController.h"
@interface TypeViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray *listFullNameType;
@property(nonatomic,strong) NSMutableArray *listShortNameType;
@property(nonatomic,strong) SaveFormViewController *saveFormViewController;
@end
