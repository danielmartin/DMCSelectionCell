// DMCSelectionCell.m
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

#import "DMCSelectionCell.h"
#import "DMCSelectionChooserView.h"
#import "DMCSelectionView.h"

@implementation DMCSelectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initializeCell];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initializeCell];
    }
    return self;
}

- (void)_initializeCell
{
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
    [self.contentView addGestureRecognizer:_tapRecognizer];
    _selectionChooserView = [[DMCSelectionChooserView alloc] initWithFrame:self.contentView.frame];
    [self.contentView addSubview:self.selectionChooserView];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)tappedView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint tapPoint = [tapGestureRecognizer locationInView:self.contentView];
        id tappedView = [self.contentView hitTest:tapPoint withEvent:nil];
        if ([tappedView isKindOfClass:[DMCSelectionView class]]) {
            [self.selectionChooserView setSelectedIndex:[tappedView index]];
            [self.delegate didSelectSelectionCell:self atIndex:[tappedView index]];
        }
    }
}

- (void)reloadData
{
    [self.selectionChooserView resetSubviews];
    
    NSInteger numItems = [self.dataSource numberOfItemsForSelectionCell:self];
    for (int i = 0; i < numItems; ++i) {
        UIImage *image = [self.dataSource imageForItem:i inSelectionCell:self];
        NSString *text = [self.dataSource textForItem:i inSelectionCell:self];
        [self.selectionChooserView addSelectionViewWithImage:image text:text index:i];
    }
}

- (void)dealloc
{
    [self.contentView removeGestureRecognizer:self.tapRecognizer];
}

@end
