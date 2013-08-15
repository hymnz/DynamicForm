//
//  LoadViewController.h
//  TNDialog
//
//  Created by kantawit on 7/30/13.
//  Copyright (c) 2013 kantawit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadViewController : QuickDialogController <QuickDialogStyleProvider, QuickDialogEntryElementDelegate> 
-(void)saveData;
@end
