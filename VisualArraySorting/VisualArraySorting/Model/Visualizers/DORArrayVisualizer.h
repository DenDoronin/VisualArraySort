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

- (BOOL) canAddElement;

- (void) drawElementAtIndex:(NSInteger) index forArray:(NSArray*) array;

- (void) drawArray:(NSArray*) array;

- (void) replaceElementAtIndex:(NSInteger) firstIndex withAnotherElement:(NSInteger) secondIndex forArray:(NSArray*) array;

@end
