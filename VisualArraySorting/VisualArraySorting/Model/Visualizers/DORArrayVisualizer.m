//
//  DORArrayVisualizer.m
//  VisualArraySorting
//
//  Created by Doronin Denis on 5/3/17.
//  Copyright © 2017 DOR. All rights reserved.
//

#import "DORArrayVisualizer.h"
@interface DORArrayVisualizer()

@property (nonatomic, strong) NSMutableArray<UILabel*>* labels;
@property (nonatomic, strong) NSOperationQueue *renderQueue;
@property (nonatomic, assign) BOOL canAddElement;

@end

static CGFloat const elementSize = 50.0;

@implementation DORArrayVisualizer

- (instancetype) initWithContentView:(UIView*) contentView
{
    self = [super init];
    if (self) {
        _contentView      = contentView;
        _labels           = [NSMutableArray array];
        _canAddElement    = YES;
        _renderQueue      = [[NSOperationQueue alloc] init];
        _renderQueue.name = [NSStringFromClass([self class]) stringByAppendingString:@"Queue"];
        
        _renderQueue.maxConcurrentOperationCount = 1;
        _renderQueue.qualityOfService            = NSQualityOfServiceUserInteractive;
        
    }
    return self;
}

- (void) drawElementAtIndex:(NSInteger) index forArray:(NSArray*) array
{
    NSAssert(index < [array count], @"Index is out of bounds");
    
    NSObject *item = array[index];
    
    [self.renderQueue addOperationWithBlock:^{
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            UILabel *label = [self createLabelWithValue:item forIndex:index];
            [self.labels addObject:label];
            label.alpha = 0.0;
            
            [self.contentView addSubview:label];
            [UIView animateWithDuration:0.1
                                  delay:0.0
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 label.alpha = 1.0;
                             }
                             completion:^(BOOL finished) {
                                 dispatch_semaphore_signal(sema);
                             }];
        }];
        // Denis says:
        // don't let operation finish until animation completed
        // this will help to chain mulitple actions and don't block
        // application execution
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }];
}

- (void) drawArray:(NSArray*) array
{
    for (NSInteger i = 0; i< [array count]; i++)
    {
        [self drawElementAtIndex:i forArray:array];
    }
}

- (void) replaceElementAtIndex:(NSInteger) firstIndex withAnotherElement:(NSInteger) secondIndex forArray:(NSArray*) array
{
    [self.renderQueue addOperationWithBlock:^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [UIView animateWithDuration:0.5
                             animations:^{
                                 
                                 CGPoint tmp                     = self.labels[firstIndex].center;
                                 self.labels[firstIndex].center  = self.labels[secondIndex].center;
                                 self.labels[secondIndex].center = tmp;
                                 
                                 [self.labels[firstIndex]  setNeedsUpdateConstraints];
                                 [self.labels[secondIndex] setNeedsUpdateConstraints];
                                 
                                 [self.labels exchangeObjectAtIndex:firstIndex withObjectAtIndex:secondIndex];
                                 
                             } completion:^(BOOL finished) {
                                 dispatch_semaphore_signal(sema);
                             }];
        }];
        
        // Denis says:
        // don't let operation finish until animation completed
        // this will help to chain mulitple actions and don't block
        // application execution
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }];
}

- (void) animateLabelsChangeForIndex:(NSInteger) firstIndex withAnotherElement:(NSInteger) secondIndex
{
    
}

- (UILabel*) createLabelWithValue:(NSObject*)value forIndex:(NSInteger) index
{
    CGFloat contentWidth  = self.contentView.frame.size.width;
    CGFloat contentHeight = self.contentView.frame.size.height;
    
    NSInteger rowsCount   = contentWidth / elementSize;
    NSInteger columnsCount= contentHeight / elementSize;
    
    NSInteger i = (index - (index / rowsCount ) * rowsCount);
    NSInteger j = (index / rowsCount);
    
    if ( j == columnsCount-1 && i == rowsCount-1)
    {
        // Denis says:
        // check if we can add element, so greed will not overflow
        self.canAddElement =  NO;
    }
    
    CGFloat margin = (CGFloat)(contentWidth - rowsCount * elementSize) / ( rowsCount + 1 );
    
    CGFloat x = elementSize * i + margin / 2.0 * (i) + margin;
    CGFloat y = elementSize * j + margin / 2.0 * (j) + margin;
    
    
    UILabel *label        = [[UILabel alloc] initWithFrame:CGRectMake(x, y, elementSize, elementSize)];
    label.text            = [value description];
    label.textAlignment   = NSTextAlignmentCenter;
    label.textColor       = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    
    return label;
}

- (BOOL) canAddElement
{
    return _canAddElement;
}
@end
