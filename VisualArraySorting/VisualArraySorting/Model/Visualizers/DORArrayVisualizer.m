//
//  DORArrayVisualizer.m
//  VisualArraySorting
//
//  Created by Doronin Denis on 5/3/17.
//  Copyright © 2017 DOR. All rights reserved.
//

#import "DORArrayVisualizer.h"
@interface DORArrayVisualizer()

@end

@implementation DORArrayVisualizer

- (instancetype) initWithContentView:(UIView*) contentView
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) drawElementAtIndex:(NSInteger) index forArray:(NSArray*) array
{
    
}

- (void) drawArray:(NSArray*) array
{

}

- (void) replaceElementAtIndex:(NSInteger) firstIndex withAnotherElement:(NSInteger) secondIndex forArray:(NSArray*) array
{

}

- (void) animateLabelsChangeForIndex:(NSInteger) firstIndex withAnotherElement:(NSInteger) secondIndex
{

}

- (UILabel*) createLabelWithValue:(NSObject*)value forIndex:(NSInteger) index
{
    return nil;
}

- (BOOL) canAddElement
{
    return NO;
}
@end
