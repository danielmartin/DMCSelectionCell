// DMCSelectionChooserView.m
//
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

#import "DMCSelectionChooserView.h"
#import "DMCSelectionView.h"
#import "DMCSelectionCell.h"

@interface DMCSelectionChooserView ()

@property (nonatomic, strong) NSMutableArray *mutableItemsArray;

@end

@implementation DMCSelectionChooserView

- (void)resetSubviews
{
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (void)addSelectionViewWithImage:(UIImage *)image text:(NSString *)text index:(int)index
{
    DMCSelectionView *selectionView = [[DMCSelectionView alloc] initWithImage:image text:text index:index];
    if (!self.mutableItemsArray) {
        self.mutableItemsArray = [[NSMutableArray alloc] init];
    }
    [self.mutableItemsArray addObject:selectionView];
    [self addSubview:selectionView];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat centroid = CGRectGetWidth(self.bounds) / ([self.subviews count] + 1.0);
    CGFloat viewCenter = CGRectGetHeight(self.bounds) / 2.0;
    for (int i = 0; i < [self.subviews count]; ++i) {
        DMCSelectionView *selectionView = self.subviews[i];
        selectionView.center = CGPointMake(centroid * (i + 1), viewCenter);
        selectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    for (int i = 0; i < [self.mutableItemsArray count]; ++i) {
        DMCSelectionView *unselectedView =  self.mutableItemsArray[i];
        [unselectedView setSelected:NO];
    }
    DMCSelectionView *selectedView = self.mutableItemsArray[_selectedIndex];
    [selectedView setSelected:YES];
}

- (NSArray *)itemViews
{
    return [self.mutableItemsArray copy];
}

- (void)setItemViews:(NSArray *)itemViews
{
    _mutableItemsArray = [itemViews mutableCopy];
}

@end
