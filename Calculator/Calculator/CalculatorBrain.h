//
//  CalculatorBrain.h
//  Calculator

#import <UIKit/UIKit.h>

@interface CalculatorBrain : NSObject

- (void)pushVariable:(NSString *)varKey;

- (void)pushOperand:(double)operand;

- (void)pushOperation:(NSString *)operation;

- (void)clear;

+ (double)runProgram:(id)program usingVariableValues:(NSMutableDictionary *)variableValues;

+ (NSString *)descriptionOfProgram:(id)program;

+ (NSSet *)variablesUsedInProgram:(id)program;

@property (readonly) id program;


@end


// Assignment #2

// Add some API to capture the program and add some API
// to run the program and get a description of it

// So the brain captures the data from the View and then
// responds to "run" methods from the View

// Remove the manual display changes in Controller,
// and get [brain descriptionOfProgram] from controller to dump
// it all in at once

// The 'program' parameter for runProgram and descriptionOfProgram is the
// value from the brain's getter: program = [brain program]

// "People can get the program and ask the class to run it"

// runProgram will return the last operand on the stack

// OR if an operation is on top of the stack, it will return the computed result
