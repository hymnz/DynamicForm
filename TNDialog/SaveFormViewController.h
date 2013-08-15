//
//  SaveFormViewController.h
//  TNDialog
//
//  Created by kantawit on 8/5/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveFormViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSMutableDictionary *dictSection;
@property(nonatomic,strong) NSMutableArray *arrayElement;
@end
