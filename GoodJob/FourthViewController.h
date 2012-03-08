//
//  FourthViewController.h
//  GoodJob
//
//  Created by again on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeScroller.h"

@interface FourthViewController : UIViewController<TimeScrollerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *_tableView;
    
    NSMutableArray *_datasource;
    TimeScroller *_timeScroller;
}

@end
