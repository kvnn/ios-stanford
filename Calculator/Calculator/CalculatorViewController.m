//
//  CalculatorViewController.m
//  Calculator

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"


@interface CalculatorViewController()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) NSMutableDictionary *variableValues;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

@synthesize allDisplay;
@synthesize variablesDisplay;
@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize variableValues = _variableValues;
@synthesize brain = _brain;


- (CalculatorBrain *)brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (NSMutableDictionary *)variableValues {
    if (!_variableValues) {
        _variableValues = [[NSMutableDictionary alloc] init];
    }
    return _variableValues;
}


- (IBAction)enterPressed {

    NSString *text = self.display.text;
    
    NSArray *variableKeys = [[self variableValues] allKeys];
    
    NSLog(@"variableValues is %@", [self variableValues]);

    // if text is a variable key
    if ([variableKeys containsObject: text]) {
        NSLog(@"variable pressed");
        [self.brain pushVariable:text];

    } else {
        [self.brain pushOperand:[text doubleValue]];
    
    }
    
    // run the program and get the result    
    double result = [[self.brain class] runProgram:[self.brain program] usingVariableValues:[self variableValues]];
    
    // update the display with the result
    NSLog(@"result is %f", result);
    
    self.display.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:result]];
    
    [self updateAllDisplay];
    
    // the user is no longer entering a number
    self.userIsInTheMiddleOfEnteringANumber = NO;
    
}


- (void)updateAllDisplay {
    id program = [self.brain program];
    NSString* description = [[self.brain class]descriptionOfProgram:program];
    
    NSLog(@"program is %@", program);
    NSLog(@"description is %@", description);
    self.allDisplay.text = description;
}


- (IBAction)testPressed:(UIButton *)sender {
    
    NSString *label = [sender currentTitle];
    
    NSNumber *x;
    NSNumber *y;
    NSNumber *foo;
    
    if ([label isEqualToString:@"Test 1"]) {
        
        x = [NSNumber numberWithInt:(5)];
        
        y = [NSNumber numberWithDouble:(4.3)];
        
        foo = [NSNumber numberWithInt:(1)];
        
    } else if ([label isEqualToString:@"Test 2"]) {
        
        x = [NSNumber numberWithInt:(2)];
        
        y = [NSNumber numberWithDouble:(7.7)];
        
        foo = [NSNumber numberWithDouble:(1.2)];
        
    } else if ([label isEqualToString:@"Test 3"]) {
        
        self.variableValues = nil;
        
    }
    
    if (self.variableValues) {
    
        [[self variableValues] setObject:x forKey:@"x"];
        [[self variableValues] setObject:y forKey:@"y"];
        [[self variableValues] setObject:foo forKey:@"foo"];
    
    }
    
    NSString *text = [NSString stringWithFormat:@"x = %@ , y = %@ , foo = %@", x, y, foo];
    
    self.variablesDisplay.text = text;
    
}


- (IBAction)varPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    self.display.text = sender.currentTitle;

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
    
    [self updateAllDisplay];
    
    //NSString *text = [self.display.text stringByAppendingString:@" "];
    //self.allDisplay.text = [self.allDisplay.text stringByAppendingString:text];
}


- (IBAction)clearPressed {
    [self.brain clear];
    self.display.text = @"";
    
    [self updateAllDisplay];
    //self.allDisplay.text = @"";
}


- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    [self.brain pushOperation: [sender currentTitle]];
    
    // run the program and get the result    
    double result = [[self.brain class] runProgram:[self.brain program] usingVariableValues:[self variableValues]];
    
    // update the display with the result
    NSLog(@"result is %f", result);
    
    self.display.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:result]];

    [self updateAllDisplay];
    
    //NSString *text = [operation stringByAppendingString:@" "];
    //self.allDisplay.text = [self.allDisplay.text stringByAppendingString: text];

}


- (void)viewDidUnload {
    [self setVariablesDisplay:nil];
    [super viewDidUnload];
}


@end
