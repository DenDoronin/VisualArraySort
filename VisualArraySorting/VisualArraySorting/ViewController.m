//
//  ViewController.m
//  VisualArraySorting
//
//  Created by Doronin Denis on 5/3/17.
//  Copyright © 2017 DOR. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+Visual.h"
#import "DORArrayVisualizer.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *tfInputValue;
@property (strong, nonatomic) IBOutlet UISwitch *swUseRandom;

@property (strong, nonatomic) IBOutlet UIView *arrayContentView;
@property (nonatomic,strong) NSMutableArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.array = [NSMutableArray new];
    self.array.arrayVisualizer = [[DORArrayVisualizer alloc] initWithContentView:self.arrayContentView];
    [self populateInputIfNeeded];
    [self setupKeyboard];
}

- (void) setupKeyboard {
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    
    tapRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void) hideKeyboard:(id) sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) populateInputIfNeeded {
    
    if (self.swUseRandom.on == NO)
        return;
    
    NSInteger lowerBound = 0;
    NSInteger upperBound = 1000;
    NSInteger rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    
    self.tfInputValue.text = [NSString stringWithFormat:@"%ld",(long)rndValue];
}

- (IBAction)addBtnPressed:(id)sender {
    
    if ([self.tfInputValue.text isEqualToString:@""])
    {
        return;
    }
    
    if (![self.array.arrayVisualizer canAddElement])
    {
        return;
    }
    
    NSNumber *value = @([self.tfInputValue.text integerValue]);
    [self.array addObject:value];
    [self.array.arrayVisualizer drawElementAtIndex:self.array.count-1 forArray:self.array];
    [self populateInputIfNeeded];
}
- (IBAction)sortArray:(id)sender {
    
    [self.array visualSortedArrayUsingComparator:^NSComparisonResult(NSNumber*  _Nonnull obj1, NSNumber*  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSLog(@"%@",self.array);
}


@end
