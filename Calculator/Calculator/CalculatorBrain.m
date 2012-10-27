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


+ (double)popOperandOffStack:(NSMutableArray *)stack withVariableValues: (NSDictionary *)variableValues {

    NSLog(@"stack is %@", stack);
   
    double result = 0;
    NSArray* variableKeys = [variableValues allKeys];
    id topOfStack = [stack lastObject];
    if(topOfStack) [stack removeLastObject];
    
    NSLog(@"topOfStack is %f", [topOfStack doubleValue]);
    
    // if topOfStack is a number
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        // TODO: [topOfStack doubleValue makes 0 turn into null]
        NSLog(@"topOfSack is an NSNumber");
        result = [topOfStack doubleValue];
    }
    // if topOfStack is a var
    else if ([variableKeys containsObject: topOfStack]) {
        NSLog(@"topOfStack is a variable");
        
    } else if ([topOfStack isKindOfClass:[NSString class]]) {
        
        id obj;
        int index = 0;
        NSString* operation = topOfStack;
        NSEnumerator *enumerator = [stack objectEnumerator];
        
        NSLog(@"topOfStack is an operation");
        
        // for every obj in programStack
        while ((obj = [enumerator nextObject])) {
            NSNumber* varVal;
            
            // if obj is a variable key
            if ([variableKeys containsObject:obj]) {
                
                // if it does not have a value
                if (![variableValues objectForKey: obj]) {
                    
                    varVal = [NSNumber numberWithInt:(0)];
                    NSLog(@"varVal is 0?, %@", varVal);
                    
                } else {
                    
                    varVal = [variableValues objectForKey:(obj)];
                    NSLog(@"varVal is, %@", varVal);
                    
                }
                
                // replace the variable with value from usingVariableValues OR 0
                [stack replaceObjectAtIndex:(index) withObject:varVal];
                
                NSLog(@"Replacing object at index %d of stack with var %@", index, varVal);
            }
            
            
            index += 1;
            
        }
        
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
