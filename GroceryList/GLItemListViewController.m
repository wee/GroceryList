//
//  GLItemListViewController.m
//  GroceryList
//
//  Created by Martin Ortega on 1/13/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "GLItemListViewController.h"
#import "GLItemTableViewCell.h"


static NSString *itemCellReuseIdentifier = @"item-cell-reuse-identifier";


@interface GLItemListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *tableView;

@end


@implementation GLItemListViewController

#pragma mark - Initialization

- (NSString *)title
{
  return @"Groceries";
}


- (void)loadView
{
  _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  [_tableView registerClass:[GLItemTableViewCell class] forCellReuseIdentifier:itemCellReuseIdentifier];
  _tableView.delegate = self;
  _tableView.dataSource = self;
  self.view = self.tableView;
}


#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  GLItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCellReuseIdentifier];
  cell.textLabel.text = @"TODO";
  
  return cell;
}

@end
