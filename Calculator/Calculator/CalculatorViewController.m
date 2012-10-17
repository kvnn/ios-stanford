//
//  CalculatorViewController.m
//  Calculator

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize allDisplay;
@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    // if this is not the first number entered
    if (self.userIsInTheMiddleOfEnteringANumber) {
        NSRange range = [self.display.text rangeOfString:@"."];
        
        // if user entered a decimal
        if ([digit isEqualToString:@"."]) {
                        
            // if there is already decimal in display.text
            if (range.location != NSNotFound) {
                return;
            }
            
        }
        
        // update the text
        self.display.text = [self.display.text stringByAppendingString:digit];
        
    // if this is the first number entered
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
    NSString *text = [self.display.text stringByAppendingString:@" "];
    self.allDisplay.text = [self.allDisplay.text stringByAppendingString:text];
}

- (IBAction)enterPressed {
    NSString *text = self.display.text;
    
    [self.brain pushOperand:[text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)clearPressed {
    [self.brain clear];
    self.display.text = @"";
    self.allDisplay.text = @"";
}

- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    NSString *text = [operation stringByAppendingString:@" "];
    self.allDisplay.text = [self.allDisplay.text stringByAppendingString: text];

}

@end
