//
//  NSArray+Heapsort.h
//  VisualArraySorting
//
//  Created by Doronin Denis on 5/3/17.
//  Copyright © 2017 DOR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DORArrayVisualizer.h"

@interface NSMutableArray (Visual)

@property (nonatomic,strong) DORArrayVisualizer *arrayVisualizer;

- (void) visualSortedArrayUsingComparator:(NSComparator NS_NOESCAPE)cmptr;

@end
