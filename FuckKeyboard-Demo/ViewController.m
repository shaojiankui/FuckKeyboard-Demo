//
//  ViewController.m
//  FuckKeyboard-Demo
//
//  Created by www.skyfox.org on 2017/6/30.
//  Copyright © 2017年 Jakey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.textFiled.keyboardAppearance = UIKeyboardAppearanceLight;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show:) name:UIKeyboardWillShowNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show:) name:UIKeyboardDidShowNotification object:nil];

}
- (void)show:(id)item{
    UIView *keyboard = [self findKeyboard];
    NSArray *array =  [self subviewsOfView:keyboard type:@"KBKeyView"];
    
    for (UIView *view in array) {
        UIButton *newButrton = [self newButtonWithOld:view];
        [view.superview addSubview:newButrton];
    }
}

- (UIView *)findKeyboard {
    for (UIWindow* window in [UIApplication sharedApplication].windows) {
        UIView *inputSetContainer = [self viewWithSuffix:@"InputSetContainerView" inView:window];
        if (inputSetContainer) {
            UIView *inputSetHost = [self viewWithSuffix:@"InputSetHostView" inView:inputSetContainer];
            if (inputSetHost) {
                UIView *kbinputbackdrop = [self viewWithSuffix:@"KBCompatInputView" inView:inputSetHost];
                if (kbinputbackdrop) {
                    UIView *theKeyboard = [self viewWithSuffix:@"KeyboardAutomatic" inView:kbinputbackdrop];
                    return theKeyboard;
                }
            }
        }
    }
    return nil;
}

- (UIView *)viewWithSuffix:(NSString *)suffix inView:(UIView *)view {
    for (UIView *subview in view.subviews) {
        NSString *viewName = NSStringFromClass(subview.class);
        if ([viewName hasPrefix:@"UI"] && [viewName hasSuffix:suffix]) {
            return subview;
        }
        if ([viewName hasPrefix:@"_UI"] && [viewName hasSuffix:suffix]) {
            return subview;
        }
    }
    return nil;
}

- (NSArray *)subviewsOfView:(UIView *)view type:(NSString *)type
{
    
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *subview in [view subviews]) {
         NSString *viewName = NSStringFromClass(subview.class);
        if ([[viewName description] hasPrefix:@"UI"] && [[viewName description] hasSuffix:type]) {
            [array addObject:subview];
        }else{
           [array addObjectsFromArray:[self subviewsOfView:subview type:type]];
        }
    }
    return array;
}

- (UIButton *)newButtonWithOld:(UIView *)oldButton
{
    CGRect oldFrame = oldButton.frame;
    CGRect newFrame =oldFrame;
    UIButton *newButton = [[UIButton alloc] initWithFrame:newFrame];
    newButton.backgroundColor = [UIColor redColor];
    newButton.layer.cornerRadius = 4;
    [newButton setTitle:@"啥啥啥" forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
    return newButton;
}
- (void)touched:(UIButton*)button{
    NSLog(@"xxxxxxxxx");
}

@end
