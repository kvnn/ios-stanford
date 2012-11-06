//
//  CalculatorViewController.h
//  Calculator


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *allDisplay;
@property (weak, nonatomic) IBOutlet UILabel *variablesDisplay;



@end


// Lecture 5 notes

// a class can declare a delegate and set itself as the delegator, and then recieve messages (built into the delegate, declared in the class) from the delegate object.

// we try to implement our gestures statelessly. for example, you normally wouldn't: set some state when "Began" starts and set some state in yourself, and then track the state and undo the state when it ends

// gestures get cancelled when a phone call comes in :D

// 
 