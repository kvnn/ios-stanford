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


- (NSMutableArray *)programStack {
    if (!_programStack) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
} 


- (id)program {
    return [self.programStack copy];
}

- (void)pushVariable:(NSString *) varKey {
    NSLog(@"varKey is %@", varKey);
    [self.programStack addObject: varKey];
}

- (void)pushOperand:(double)operand {
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.programStack addObject:operandObject];
}


- (void)clear {
    [self.programStack removeAllObjects];
}


- (void)pushOperation:(NSString *)operation {
    
    [self.programStack addObject:operation];
    
}


+ (NSString *)descriptionOfProgram:(id)program {
    NSEnumerator *enumerator = [program objectEnumerator];
    NSString* description;
    id obj;
    
    while (obj = [enumerator nextObject]) {
        description = [description stringByAppendingString: (NSString *) obj];
    }
    
    return description;
}


+ (double)popOperandOffStack:(NSMutableArray *)stack {
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if(topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
        
    } else if ([topOfStack isKindOfClass:[NSString class]]) {

        NSString* operation = topOfStack;
        
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([@"-" isEqualToString:operation]) {
            double subtrahend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtrahend;
        } else if ([@"/" isEqualToString:operation]) {
            double divisor = [self popOperandOffStack:stack];
            if (divisor) result = [self popOperandOffStack:stack] / divisor;
        } else if ([@"π" isEqualToString:operation]) {
            result = M_PI;
        } else if ([@"sin" isEqualToString:operation]) {
            NSLog(@"SIN PRESSED");
            result = sin([self popOperandOffStack:stack]);
        } else if ([@"cos" isEqualToString:operation]) {
            NSLog(@"COS PRESSED");
            result = cos([self popOperandOffStack:stack]);
        } else if ([@"sqrt" isEqualToString:operation]) {
            NSLog(@"COS PRESSED");
            result = sqrt([self popOperandOffStack:stack]);
        } else {
            // test if a variable has been pushed
        }
    }
    
    return result;
}


+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *) variableValues 
{
    
    NSLog(@"variableValues is %@", variableValues);

    NSMutableArray *stack;
    
    if ([program isKindOfClass:[NSArray class]]) {
    
        stack = [program mutableCopy];
        
        NSLog(@"runProgram");

        // if vars are passed in
        if ([variableValues isKindOfClass:[NSDictionary class]]) {
            
            NSLog(@"vars are passed in: %@", variableValues);
            
            id obj;
            int index = 0;
            
            NSEnumerator *enumerator = [program objectEnumerator];
            
            // for every obj in programStack
            while ((obj = [enumerator nextObject])) {
                
                id varVal = [variableValues objectForKey:(obj)];
                
                // test
                NSLog(@"usingVariableValues objectForKey:(obj) is %@", varVal);
                
                // if the obj is a variable key
                if (!varVal) {
                    varVal = 0;
                    
                    NSLog(@"varVal is false");
                }
                
                NSLog(@"Replacing object at index %@ of stack with var %@", index, varVal);
                
                
                // replace the variable with value from usingVariableValues OR 0
                [stack replaceObjectAtIndex:(index) withObject:varVal];
                
                index += 1;
                
            }
        }
        
    }
    
    return [self popOperandOffStack:stack];
}


@end
