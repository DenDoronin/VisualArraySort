//
//  NSArray+Heapsort.m
//  VisualArraySorting
//
//  Created by Doronin Denis on 5/3/17.
//  Copyright © 2017 DOR. All rights reserved.
//

#import "NSMutableArray+Visual.h"

@import ObjectiveC.runtime;

@implementation NSMutableArray (Visual)

- (id)arrayVisualizer {
    
    NSMutableArray *visualizer = objc_getAssociatedObject(self, @selector(arrayVisualizer));
    
    return visualizer;
}

- (void)setArrayVisualizer: (id)arrayVisualizer {
    objc_setAssociatedObject(self, @selector(arrayVisualizer), arrayVisualizer, OBJC_ASSOCIATION_RETAIN);
}

- (void)visualSortedArrayUsingComparator:(NSComparator NS_NOESCAPE)cmptr
{
    quicksortInPlace(self, 0, self.count - 1, cmptr,self.arrayVisualizer);
}

void quicksortInPlace(NSMutableArray *array, NSInteger first, NSInteger last, NSComparator comparator, DORArrayVisualizer *arrayVisualizer) {
    if (first >= last) return;
    id pivot = array[(first + last) / 2];
    NSInteger left = first;
    NSInteger right = last;
    while (left <= right) {
        while (comparator(array[left], pivot) == NSOrderedAscending)
            left++;
        while (comparator(array[right], pivot) == NSOrderedDescending)
            right--;
        if (left <= right)
        {
            swap(array, left++, right--, comparator, arrayVisualizer);
        }
    }
    quicksortInPlace(array, first, right, comparator,arrayVisualizer);
    quicksortInPlace(array, left, last, comparator,arrayVisualizer);
}

void swap(NSMutableArray *array, NSInteger first, NSInteger second, NSComparator comparator, DORArrayVisualizer *arrayVisualizer)
{
    [array exchangeObjectAtIndex:first withObjectAtIndex:second];
    
    if (arrayVisualizer)
    {
        [arrayVisualizer replaceElementAtIndex:first
                            withAnotherElement:second
                                      forArray:array];
    }
    
}

@end
