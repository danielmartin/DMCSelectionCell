// DMCSelectionView.m
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

#import "DMCSelectionView.h"

@interface DMCSelectionView ()

@property (nonatomic, strong) NSDictionary *textDict;

@end

@implementation DMCSelectionView

- (instancetype)initWithImage:(UIImage *)image text:(NSString *)text index:(NSUInteger)index
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImage *typeImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _defaultImageView = [[UIImageView alloc] initWithImage:typeImage];
        [self addSubview:_defaultImageView];
        _selectionLabel = [[UILabel alloc] init];
        _selectionLabel.text = text;
        _selectionLabel.textColor = self.defaultImageView.tintColor;
        _selectionLabel.font = [UIFont systemFontOfSize:15.0];
        _selectionLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_selectionLabel];
        _index = index;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.selectionLabel.frame = CGRectZero;
    self.selectionLabel.numberOfLines = 0;
    [self.selectionLabel sizeToFit];
    self.selectionLabel.frame = CGRectMake(self.selectionLabel.frame.origin.x - 5.0,
                                           self.selectionLabel.frame.origin.y - 5.0,
                                           self.selectionLabel.frame.size.width + 10.0,
                                           self.selectionLabel.frame.size.height + 10.0);
    self.selectionLabel.center = self.defaultImageView.center;
    self.selectionLabel.transform = CGAffineTransformMakeTranslation(0, (CGRectGetHeight(self.defaultImageView.frame) + CGRectGetHeight(self.selectionLabel.frame)) / 2.0 + 5.0);
    if (self.isSelected) {
        self.selectionLabel.layer.borderWidth = 2.0;
        self.selectionLabel.layer.borderColor = self.defaultImageView.tintColor.CGColor;
        self.selectionLabel.layer.cornerRadius = 10.0;
    } else {
        self.selectionLabel.layer.borderWidth = 0.0;
        self.selectionLabel.layer.cornerRadius = 0.0;
    }
    [self sizeToFit];
}

- (void)sizeToFit
{
    self.bounds = CGRectMake(CGRectGetMinX(self.defaultImageView.frame),
                             CGRectGetMinY(self.defaultImageView.frame),
                             CGRectGetWidth(self.defaultImageView.frame),
                             CGRectGetMinY(self.selectionLabel.frame) + CGRectGetHeight(self.selectionLabel.frame));
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsLayout];
}

@end
