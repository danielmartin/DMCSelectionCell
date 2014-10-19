// The MIT License (MIT)
//
// Copyright (c) 2014 Daniel Martín
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "DMCTableViewController.h"
#import "DMCModel.h"

@interface DMCTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *badgeAppIconLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertSoundLabel;
@property (weak, nonatomic) IBOutlet DMCSelectionCell *selectionCell;
@property (nonatomic, strong) NSArray *model;

@end

@implementation DMCTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initModel
{
    DMCModel *noneAlert = [[DMCModel alloc] init];
    noneAlert.imageName = @"None";
    noneAlert.imageTitle = NSLocalizedString(@"None", @"None alert type");
    
    DMCModel *bannerAlert = [[DMCModel alloc] init];
    bannerAlert.imageName = @"Banner";
    bannerAlert.imageTitle = NSLocalizedString(@"Banner", @"Banner alert type");
    
    DMCModel *alertAlert = [[DMCModel alloc] init];
    alertAlert.imageName = @"Alert";
    alertAlert.imageTitle = NSLocalizedString(@"Alert", @"Alert alert type");
    
    self.model = @[noneAlert, bannerAlert, alertAlert];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initModel];
    self.badgeAppIconLabel.text = NSLocalizedString(@"Vibrate", @"Vibrate device when an in-app notification arrives");
    self.alertSoundLabel.text = NSLocalizedString(@"Alert Sound", @"Alert sound table cell");
    self.selectionCell.dataSource = self;
    self.selectionCell.delegate = self;
    [self.selectionCell reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return NSLocalizedString(@"IN-APP ALERT STYLE", @"Section 0 header");
    } else {
        return @"";
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return NSLocalizedString(@"Alerts require an action before proceeding.\nBanners appear at the top of the screen and go away automatically", @"Section 0 header");
    } else {
        return @"";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0 && [self.model count] > 0) {
        DMCModel *firstItem = self.model[0];
        return [UIImage imageNamed:firstItem.imageName].size.height + 60.0;
    }
    else return UITableViewAutomaticDimension;
}

#pragma mark - DMCSelectionCellDataSource

- (NSUInteger)numberOfItemsForSelectionCell:(DMCSelectionCell *)selectionCell
{
    return [self.model count];
}

- (UIImage *)imageForItem:(NSUInteger)index inSelectionCell:(DMCSelectionCell *)selectionCell
{
    if (index >= [self.model count]) {
        return nil;
    }
    DMCModel *model = self.model[index];
    return [UIImage imageNamed:model.imageName];
}

- (NSString *)textForItem:(NSUInteger)index inSelectionCell:(DMCSelectionCell *)selectionCell
{
    if (index >= [self.model count]) {
        return nil;
    }
    DMCModel *model = self.model[index];
    return model.imageTitle;
}

#pragma mark - DMCSelectionCellDelegate

- (void)didSelectSelectionCell:(DMCSelectionCell *)selectionCell atIndex:(NSUInteger)index
{
    DMCModel *model = self.model[index];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Info", @"Info title") message:[NSString stringWithFormat:NSLocalizedString(@"You have selected the \"%@\" alert style.", @""), model.imageTitle] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
    [alert show];
}

@end
