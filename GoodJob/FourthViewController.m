//
//  FourthViewController.m
//  GoodJob
//
//  Created by again on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FourthViewController.h"

#import "FourthSettingViewController.h"

@implementation FourthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Fourth", @"Fourth");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        _timeScroller = [[TimeScroller alloc] initWithDelegate:self];
        
        //This is just junk data to be displayed.
        _datasource = [NSMutableArray new];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        NSDate *today = [NSDate date];
        NSDateComponents *todayComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
        
        //控制cell显示的东西
        for (int i = todayComponents.day; i >= 10; i--) {
            
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
            [dictionary setObject:@"Title here" forKey:@"title"];
            
            components.year = todayComponents.year;
            components.month = todayComponents.month;
            components.day = todayComponents.day;
            components.hour = arc4random() % 23;
            components.minute = arc4random() % 59;
            
            NSDate *date = [calendar dateFromComponents:components];
            [dictionary setObject:date forKey:@"date"];
            
            [_datasource addObject:dictionary];
            
        }
        NSLog(@"%d",[_datasource count]);
        [components release];

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (UITableView *)tableViewForTimeScroller:(TimeScroller *)timeScroller {
    
    return _tableView;
    
}

//You should return an NSDate related to the UITableViewCell given. This will be
//the date displayed when the TimeScroller is above that cell.

- (NSDate *)dateForCell:(UITableViewCell *)cell {
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    if (indexPath.row == 0) {
        return [NSDate date];
    }
    NSDictionary *dictionary = [_datasource objectAtIndex:indexPath.row];
    NSDate *date = [dictionary objectForKey:@"date"];
    
    return date;
    
}

#pragma mark UIScrollViewDelegateMethods


//The TimeScroller needs to know what's happening with the UITableView (UIScrollView)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"%f",scrollView.contentOffset.y);
    [_timeScroller scrollViewDidScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [_timeScroller scrollViewDidEndDecelerating];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [_timeScroller scrollViewWillBeginDragging];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate) {
        
        [_timeScroller scrollViewDidEndDecelerating];
        
    }
    
}

#pragma mark UITableViewDelegate Methods


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200 - _tableView.contentOffset.y;
    }
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_datasource count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *identifier = @"TableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        
    }
    
    NSDictionary *dictionary = [_datasource objectAtIndex:indexPath.row];
    NSString *title = [dictionary objectForKey:@"title"];
    cell.textLabel.text = title;
    
    NSDate *date = [dictionary objectForKey:@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    FourthSettingViewController *fourSet = [[[FourthSettingViewController alloc]initWithNibName:@"FourthSettingViewController" bundle:nil]autorelease];
    [self.navigationController pushViewController:fourSet animated:YES];
}




@end
