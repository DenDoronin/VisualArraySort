//
//  DORArrayVisualizer.h
//  VisualArraySorting
//
//  Created by Doronin Denis on 5/3/17.
//  Copyright © 2017 DOR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DORArrayVisualizer : NSObject

@property (nonatomic,weak) UIView * contentView;

- (instancetype) initWithContentView:(UIView*) contentView;

/**
 * Checks if new element can be added.
 * This method is used before any insert operation is performed on array
 *
 * @return YES if element can be added to the Visualizer, otherwise NO;
 */
- (BOOL) canAddElement;

/**
 * Draws element by provided index.
 * Uses content view as parent for any element.
 *
 * @param index ordered number of element in array
 * @param array target array
 */
- (void) drawElementAtIndex:(NSInteger) index forArray:(NSArray*) array;

/**
 * Draws all elements.
 * Uses content view as parent for any element.
 *
 * @param array target array
 */
- (void) drawArray:(NSArray*) array;

/**
 * Replaces elements with animation.
 * This method can be overrided in child classes.
 *
 * @param firstIndex index of object to replace, order of indexes doesn't matter
 * @param secondIndex index of object to replace, order of indexes doesn't matter
 * @param array target array
 */
- (void) replaceElementAtIndex:(NSInteger) firstIndex withAnotherElement:(NSInteger) secondIndex forArray:(NSArray*) array;

@end
