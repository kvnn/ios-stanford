//
//  CalculatorBrain.m
//  Calculator

#import "CalculatorBrain.h"

// a class
@interface CalculatorBrain()

// an instance variable
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;


// a private getter method used to init our programStack array on demand
- (NSMutableArray *)programStack {
    if (!_programStack) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

// a public method to get an instance's current program array
- (id)program {
    return [self.programStack copy];
}

// a public method to push a variable into the stack
- (void)pushVariable:(NSString *) varKey {
    [self.programStack addObject: varKey];
}

// a public method to push a number into the stack
- (void)pushOperand:(double)operand { 
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (void)clear {
    [self.programStack removeAllObjects];
}


- (void)pushOperation:(NSString *)operation {
    [self.programStack addObject:operation];
}


+ (NSString *)descriptionOfProgram:(id)program {
    id obj;
    NSString* description;
    description = @"";
    NSEnumerator *enumerator = [program objectEnumerator];
    
    NSLog(@"description program is %@", program);
    while (obj = [enumerator nextObject]) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            obj = [obj stringValue];
        }
        
        description = [description stringByAppendingString: (NSString*) obj];
        
        if ([obj isKindOfClass:[NSString class]]) {
            NSLog(@"description is an NSString");
        } else {
            NSLog(@"description is NOT an NSString");
        }
        
        description = [description stringByAppendingString: @" "];
        NSLog(@"while description is %@", description);
    }
    
    return description;
}


+ (double)popOperandOffStack:(NSMutableArray *)stack withVariableValues: (NSDictionary *)variableValues {

    NSLog(@"stack is %@", stack);
   
    double result;
    NSArray* operationKeys = [NSArray arrayWithObjects:@"*", @"+", @"-", @"/", @"π", @"sqrt", @"SIN", @"COS", nil];
    id topOfStack = [stack lastObject];
    if(topOfStack) [stack removeLastObject];
    
    NSLog(@"topOfStack is %@", topOfStack);
    
    // if topOfStack is a number
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        NSLog(@"topOfSack is an NSNumber");
        result = [topOfStack doubleValue];
    
    // TODO: THIS WILL ALWAYS GET CALLED FOR A VARIABLE
    } else if ([operationKeys containsObject: topOfStack]) {
        
        NSString* operation = topOfStack;
        
        NSLog(@"topOfStack is an operation");
        
        
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack withVariableValues: variableValues] + [self popOperandOffStack:stack withVariableValues: variableValues];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffStack:stack withVariableValues: variableValues] * [self popOperandOffStack:stack withVariableValues: variableValues];
        } else if ([@"-" isEqualToString:operation]) {
            double subtrahend = [self popOperandOffStack:stack withVariableValues: variableValues];
            result = [self popOperandOffStack:stack withVariableValues: variableValues] - subtrahend;
        } else if ([@"/" isEqualToString:operation]) {
            double divisor = [self popOperandOffStack:stack withVariableValues: variableValues];
            if (divisor) result = [self popOperandOffStack:stack withVariableValues: variableValues] / divisor;
        } else if ([@"π" isEqualToString:operation]) {
            result = M_PI;
        } else if ([@"sin" isEqualToString:operation]) {
            NSLog(@"SIN PRESSED");
            result = sin([self popOperandOffStack:stack withVariableValues: variableValues]);
        } else if ([@"cos" isEqualToString:operation]) {
            NSLog(@"COS PRESSED");
            result = cos([self popOperandOffStack:stack withVariableValues: variableValues]);
        } else if ([@"sqrt" isEqualToString:operation]) {
            NSLog(@"COS PRESSED");
            result = sqrt([self popOperandOffStack:stack withVariableValues: variableValues]);
        } else {
            // test if a variable has been pushed
        }
    }
    
    // if topOfStack is a var or unkown
    else if (topOfStack) {
        NSLog(@"topOfStack is a variable or unknown");
        
        // if var has a value
        if ([variableValues objectForKey: topOfStack]) {
            
            // return its value
            result = [[variableValues objectForKey: topOfStack] doubleValue];
            
        } else {
            
            // replace it with 0
            result = 0;
            
            NSLog(@"var has no value, rsult is %f", result);
        }

    }    
    
    NSLog(@"popOperandOffStack result is %f", result);
    
    return result;
}


+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *) variableValues 
{
    
    NSLog(@"variableValues is %@", variableValues);

    NSMutableArray *stack;
    
    if ([program isKindOfClass:[NSArray class]]) {
    
        stack = [program mutableCopy];
        
    }
    
    return [self popOperandOffStack:stack withVariableValues: variableValues];
}


@end
