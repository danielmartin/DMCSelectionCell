// DMCSelectionCellTests.m
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

#import <XCTest/XCTest.h>
#import "DMCSelectionCell.h"
#import "DMCSelectionChooserView.h"
#import "DMCSelectionView.h"
#import "DMCMockSelectionCellDataSource.h"
#import "DMCMockSelectionView.h"
#import "UIImage+DMCColor.h"

@interface DMCSelectionCellTests : XCTestCase

@property (nonatomic, strong) DMCSelectionCell *sut;

@end

@implementation DMCSelectionCellTests

- (void)setUp
{
    [super setUp];
    self.sut = [[DMCSelectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test-cell"];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testThatTheTapRecognizerIsCreatedWithTheCorrectClass
{
    XCTAssertNotNil(self.sut.tapRecognizer, @"The tap gesture recognizer of this cell is nil!");
    XCTAssertEqual([self.sut.tapRecognizer class], [UITapGestureRecognizer class], @"The tap gesture recognizer is not an instance of UITapGestureRecognizer!");
}

- (void)testThatTheSelectionViewIsCreatedWithTheCorrectClass
{
    XCTAssertNotNil(self.sut.selectionChooserView, @"The selection view of this cell is nil!");
    XCTAssertEqual([self.sut.selectionChooserView class], [DMCSelectionChooserView class], @"The selection view is not an instance of DMCSelectionView!");
}

- (void)testThatReloadDataCreatesTheCorrectNumberOfSubviews
{
    // Given
    DMCMockSelectionCellDataSource *mockDataSource = [[DMCMockSelectionCellDataSource alloc] init];
    self.sut.dataSource = mockDataSource;
    
    // When
    [self.sut reloadData];
    
    // Then
    XCTAssertTrue([self.sut.selectionChooserView.subviews count] == 3);
}

- (void)testThatReloadDataCreatesTheCorrectLabels
{
    // Given
    DMCMockSelectionCellDataSource *mockDataSource = [[DMCMockSelectionCellDataSource alloc] init];
    self.sut.dataSource = mockDataSource;
    
    // When
    [self.sut reloadData];
    
    // Then
    DMCSelectionView *firstView = self.sut.selectionChooserView.subviews[0];
    DMCSelectionView *secondView = self.sut.selectionChooserView.subviews[1];
    DMCSelectionView *thirdView = self.sut.selectionChooserView.subviews[2];
    XCTAssertTrue([firstView.selectionLabel.text isEqualToString:@"Item 1"]);
    XCTAssertTrue([secondView.selectionLabel.text isEqualToString:@"Item 2"]);
    XCTAssertTrue([thirdView.selectionLabel.text isEqualToString:@"Item 3"]);
}

- (void)testThatSelectingAnItemSelectsThatItemAndDeselectsTheRest
{
    // Given
    DMCMockSelectionCellDataSource *mockDataSource = [[DMCMockSelectionCellDataSource alloc] init];
    self.sut.dataSource = mockDataSource;
    DMCMockSelectionView *firstMockSelectionView = [[DMCMockSelectionView alloc] init];
    DMCMockSelectionView *secondMockSelectionView = [[DMCMockSelectionView alloc] init];
    DMCMockSelectionView *thirdMockSelectionView = [[DMCMockSelectionView alloc] init];
    self.sut.selectionChooserView.itemViews = @[firstMockSelectionView,
                                         secondMockSelectionView,
                                         thirdMockSelectionView];
    
    // When
    [self.sut.selectionChooserView setSelectedIndex:0];
    
    // Then
    XCTAssertEqual(firstMockSelectionView.wasSelected, YES);
    XCTAssertEqual(secondMockSelectionView.wasSelected, NO);
    XCTAssertEqual(thirdMockSelectionView.wasSelected, NO);
}

- (void)testThatItemsAreAddedToTheArrayOfItemViews
{
    // When
    [self.sut.selectionChooserView addSelectionViewWithImage:[UIImage dmc_imageWithColor:[UIColor blackColor]] text:@"test" index:0];
    [self.sut.selectionChooserView addSelectionViewWithImage:[UIImage dmc_imageWithColor:[UIColor blackColor]] text:@"test" index:1];
    [self.sut.selectionChooserView addSelectionViewWithImage:[UIImage dmc_imageWithColor:[UIColor blackColor]] text:@"test" index:2];
    
    // Then
    XCTAssertEqual(self.sut.selectionChooserView.itemViews.count, 3);
}

- (void)testThatSelectingAnItemTwiceDoesTheRightThing
{
    // Given
    DMCMockSelectionCellDataSource *mockDataSource = [[DMCMockSelectionCellDataSource alloc] init];
    self.sut.dataSource = mockDataSource;
    DMCMockSelectionView *firstMockSelectionView = [[DMCMockSelectionView alloc] init];
    DMCMockSelectionView *secondMockSelectionView = [[DMCMockSelectionView alloc] init];
    DMCMockSelectionView *thirdMockSelectionView = [[DMCMockSelectionView alloc] init];
    self.sut.selectionChooserView.itemViews = @[firstMockSelectionView,
                                         secondMockSelectionView,
                                         thirdMockSelectionView];
    
    // When
    [self.sut.selectionChooserView setSelectedIndex:1];
    [self.sut.selectionChooserView setSelectedIndex:1];
    
    // Then
    XCTAssertEqual(firstMockSelectionView.wasSelected, NO);
    XCTAssertEqual(secondMockSelectionView.wasSelected, YES);
    XCTAssertEqual(thirdMockSelectionView.wasSelected, NO);
}

@end
