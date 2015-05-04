//
//  MainViewController.h
//  TableViewSorting
//
//  Created by Stephen Shaw on 3/30/15.
//  Copyright (c) 2015 Stephen Shaw. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;
- (IBAction)ButtonClicked:(id)sender;

@property NSMutableArray *data;
@end
