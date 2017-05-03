//
//  VisualArraySortingTests.m
//  VisualArraySortingTests
//
//  Created by Doronin Denis on 5/3/17.
//  Copyright © 2017 DOR. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSMutableArray+Visual.h"

@interface VisualArraySortingTests : XCTestCase

@end

@implementation VisualArraySortingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSort {
    NSMutableArray *array = [@[@10,@9,@8,@7,@6,@5,@4,@3,@2,@1] mutableCopy];
    [array visualSortedArrayUsingComparator:^NSComparisonResult(NSNumber*  _Nonnull obj1, NSNumber*  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    for (int i =1; i< [array count]; i++)
        XCTAssertTrue([array[i-1] integerValue] <= [array[i] integerValue]);
}

- (void)testSortWithNegatives {
    NSMutableArray *array = [@[@1,@(-2),@3,@4,@5,@(-6),@7,@7,@9,@10] mutableCopy];
    [array visualSortedArrayUsingComparator:^NSComparisonResult(NSNumber*  _Nonnull obj1, NSNumber*  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    for (int i =1; i< [array count]; i++)
        XCTAssertTrue([array[i-1] integerValue] <= [array[i] integerValue]);
}

- (void)testSortForAlreadySorted {
    NSMutableArray *array = [@[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10] mutableCopy];
    [array visualSortedArrayUsingComparator:^NSComparisonResult(NSNumber*  _Nonnull obj1, NSNumber*  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    for (int i =1; i< [array count]; i++)
        XCTAssertTrue([array[i-1] integerValue] <= [array[i] integerValue]);
}

- (void)testSortOneElement {
    NSMutableArray *array = [@[@10] mutableCopy];
    // check if algorithm forks correctly for one element
    [array visualSortedArrayUsingComparator:^NSComparisonResult(NSNumber*  _Nonnull obj1, NSNumber*  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
}

@end
