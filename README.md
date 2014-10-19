## DMCSelectionCell

[![Build Status](https://travis-ci.org/danielmartin/DMCSelectionCell.svg?branch=master)](https://travis-ci.org/danielmartin/DMCSelectionCell)

DMCSelectionCell is a custom cell that shows a list of exclusive options in a graphical way. It is inspired by Apple's alert style screen for push notifications.

## Usage

In your `viewDidLoad:` method, add the following code to configure the cell's data source and delegate, and perform a first refresh:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectionCell.dataSource = self;
    self.selectionCell.delegate = self;
    [self.selectionCell reloadData];
    // Rest of your viewDidLoad: implementation
}
```

You must provide the image and explanation text for each option. For example:

```objective-c
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
```

The instance of `DMCSelectionCell` is provided to you as a parameter for the case where you have more than one of these cells in your `UITableView`.

Then, implement the delegate and respond appropriately:

```objective-c
- (void)didSelectSelectionCell:(DMCSelectionCell *)selectionCell atIndex:(NSUInteger)index
{
    DMCModel *model = self.model[index];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Info", @"Info title") message:[NSString stringWithFormat:NSLocalizedString(@"You have selected the \"%@\" alert style.", @""), model.imageTitle] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
    [alert show];
}
```

Check the sample project for more information.

## License

DMCSelectionCell is available under the MIT license. See the [LICENSE file](https://github.com/danielmartin/DMCSelectionCell/blob/master/LICENSE) for more info.
