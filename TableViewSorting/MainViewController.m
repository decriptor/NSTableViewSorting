//
//  MainViewController.m
//  TableViewSorting
//
//  Created by Stephen Shaw on 3/30/15.
//  Copyright (c) 2015 Stephen Shaw. All rights reserved.
//

#import "MainViewController.h"

@interface NSString (compareInts)
-(NSComparisonResult)compareInts:(NSString*)other;
@end

@implementation NSString (compareInts)
-(NSComparisonResult)compareInts:(NSString *)other {
    NSAssert([other isKindOfClass:[NSString class]], @"Must be a string");
    int x = [self intValue];
    int y = [other intValue];
    
    if ([self isEqual:other]) {
        return NSOrderedSame;
    } else if (x > y) {
        return NSOrderedAscending;
    }
    
    return NSOrderedDescending;
}
@end

@implementation MainViewController
@synthesize tableView;
@synthesize data;

- (void)viewWillAppear
{
    [self buildDataArray];
    [self setupTableView];
}

-(void)buildDataArray
{
    data = [NSArray arrayWithObjects:
                      [NSDictionary dictionaryWithObjectsAndKeys:@"1002",@"First",@"1002",@"Second",@"1003",@"Third",@"1004",@"Fourth", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"2005",@"First",@"2002",@"Second",@"2003",@"Third",@"2004",@"Fourth", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"3004",@"First",@"3002",@"Second",@"3003",@"Third",@"3004",@"Fourth", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"4001",@"First",@"4002",@"Second",@"4003",@"Third",@"4004",@"Fourth", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"5007",@"First",@"5002",@"Second",@"5003",@"Third",@"5004",@"Fourth", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"6006",@"First",@"6002",@"Second",@"6003",@"Third",@"6004",@"Fourth", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"7009",@"First",@"7002",@"Second",@"7003",@"Third",@"7004",@"Fourth", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"8003",@"First",@"8002",@"Second",@"8003",@"Third",@"8004",@"Fourth", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"9008",@"First",@"9002",@"Second",@"9003",@"Third",@"9004",@"Fourth", nil],
                      nil];
}

-(void)setupTableView
{
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    NSTableColumn *firstColumn = [tableView tableColumnWithIdentifier:@"First"];
    NSTableColumn *secondColumn = [tableView tableColumnWithIdentifier:@"Second"];
    
    NSSortDescriptor *firstColumnDescriptor = [[NSSortDescriptor alloc] initWithKey:@"First" ascending:YES comparator:comparisonBlock];
    NSSortDescriptor *secondColumnDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Second" ascending:YES selector:@selector(compareInts:)];
    
    [firstColumn  setSortDescriptorPrototype:firstColumnDescriptor];
    [secondColumn setSortDescriptorPrototype:secondColumnDescriptor];
}

NSComparator comparisonBlock = ^(id first, id second)
{
    int x = [first intValue] % 1000;
    int y = [second intValue] % 1000;
    
    if (x > y)
        return NSOrderedAscending;
    if (y > x)
        return NSOrderedDescending;
    
    return NSOrderedSame;
};

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    long recordCount = [self.data count];
    return recordCount;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *aString;
    aString = [[self.data objectAtIndex:row] objectForKey:[tableColumn identifier]];
    return aString;
}

-(void)tableView:(NSTableView *)aTableView sortDescriptorsDidChange:(NSArray *)oldDescriptors
{
    self.data = [self.data sortedArrayUsingDescriptors:[aTableView sortDescriptors]];
    [aTableView reloadData];
}
@end
