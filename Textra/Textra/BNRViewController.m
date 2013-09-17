//
//  BNRViewController.m
//  Textra
//
//  Created by Owen Mathews on 9/16/13.
//  Copyright (c) 2013 Owen Mathews. All rights reserved.
//

#import "BNRViewController.h"
#import "BNRTextFunction.h"

@interface BNRViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *textInput;
@property (nonatomic, weak) IBOutlet UISegmentedControl *inputStyleSelector;
@property (nonatomic, weak) IBOutlet UILabel *status;

@property (nonatomic) NSMutableArray *inputTransformers;
@property (nonatomic) NSMutableArray *textFunctions;

@property (nonatomic) BNRTextFunction *currentInputTransformer;

@property (nonatomic) JSContext *context;

@property (nonatomic) BOOL bypassTextProcessing;

@end

@implementation BNRViewController

- (IBAction)clearInput:(id)sender {
    self.textInput.text = @"";
}

- (IBAction)selectInputStyle:(UISegmentedControl *)sender {
    self.currentInputTransformer = self.inputTransformers[sender.selectedSegmentIndex];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a new JS execution context.
    self.context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
    
    // Load base objects.
    NSString *baseScript = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"globals" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
    [self.context evaluateScript:baseScript];
    
    // Load the functions.
    NSDictionary *functions = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Transformation Functions" ofType:@"plist"]];
 
    // Process the input transformers.
    NSArray *inputTransformersDict = functions[@"Input Transformers"];
    self.inputTransformers = [NSMutableArray arrayWithCapacity:inputTransformersDict.count + 1];
    [self.inputStyleSelector removeAllSegments];
    [self.inputStyleSelector insertSegmentWithTitle:@"Normal" atIndex:0 animated:NO];
    self.currentInputTransformer = [[BNRTextFunction alloc] init];
    [self.inputTransformers addObject:self.currentInputTransformer];
    for (NSDictionary *functionParams in inputTransformersDict) {
        BNRTextFunction *function = [[BNRTextFunction alloc] initWithName:functionParams[@"Function Name"] body:functionParams[@"Function Body"]];
        [function installInContext:self.context];
        if (function.isValid) {
            [self.inputTransformers addObject:function];
            [self.inputStyleSelector insertSegmentWithTitle:functionParams[@"Name"] atIndex:self.inputStyleSelector.numberOfSegments animated:NO];
        }
    }
    self.inputStyleSelector.selectedSegmentIndex = 0;
    
    // Process the text transformers.
    NSArray *textFunctionsDict = functions[@"Text Transformers"];
    self.textFunctions = [NSMutableArray arrayWithCapacity:inputTransformersDict.count];
    for (NSDictionary *functionParams in textFunctionsDict) {
        BNRTextFunction *function = [[BNRTextFunction alloc] initWithName:functionParams[@"Function Name"] body:functionParams[@"Function Body"]];
        [function installInContext:self.context];
        if (function.isValid) {
            UIButton *button = (UIButton *)[self.view viewWithTag:1000 + self.textFunctions.count];
            if (button) {
                [button setTitle:functionParams[@"Name"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(textFunctionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            }
            [self.textFunctions addObject:function];
        }
    }
}

- (void)textFunctionButtonTapped:(UIButton *)button {
    NSInteger index = button.tag - 1000;
    NSString *oldText = self.textInput.text;
    BNRTextFunction *function = self.textFunctions[index];
    NSString *newText = [function evaluateWithInput:oldText];
    self.bypassTextProcessing = YES;
    self.textInput.text = newText;
    self.bypassTextProcessing = NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (self.bypassTextProcessing || text.length == 0)
        return YES;
    
    NSString *toAppend = [self.currentInputTransformer evaluateWithInput:text];
    self.bypassTextProcessing = YES;
    self.textInput.text = [self.textInput.text stringByAppendingString:toAppend];
    self.bypassTextProcessing = NO;
    
    return NO;
}

@end
