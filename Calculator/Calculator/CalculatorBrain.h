//
//  CalculatorBrain.h
//  Calculator

#import <UIKit/UIKit.h>

@interface CalculatorBrain : NSObject

- (void)pushVariable:(NSString *)varKey;

- (void)pushOperand:(double)operand;

- (double)performOperation:(NSString *)operation;

- (void)clear;

@property (readonly) id program;

+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;

+ (NSString *)descriptionOfProgram:(id)program;

+ (NSSet *)variablesUsedInProgram:(id)program;

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
