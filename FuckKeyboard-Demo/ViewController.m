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
    NSArray *array =  [self subviewsOfView:keyboard type:@"UIKBKeyView"];
    
    for (UIView *view in array) {
        UIButton *newButrton = [self newButtonWithOld:view];
        [view.superview addSubview:newButrton];
    }
}

- (UIView *)findKeyboard {
    for (UIWindow* window in [UIApplication sharedApplication].windows) {
        UIView *inputSetContainer = [self viewWithPrefix:@"<UIInputSetContainerView" inView:window];
        if (inputSetContainer) {
            UIView *inputSetHost = [self viewWithPrefix:@"<UIInputSetHostView" inView:inputSetContainer];
            if (inputSetHost) {
                UIView *kbinputbackdrop = [self viewWithPrefix:@"<_UIKBCompatInput" inView:inputSetHost];
                if (kbinputbackdrop) {
                    UIView *theKeyboard = [self viewWithPrefix:@"<UIKeyboard" inView:kbinputbackdrop];
                    return theKeyboard;
                }
            }
        }
    }
    return nil;
}

- (UIView *)viewWithPrefix:(NSString *)prefix inView:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if ([[subview description] hasPrefix:prefix]) {
            return subview;
        }
    }
    return nil;
}

- (NSArray *)subviewsOfView:(UIView *)view type:(NSString *)type
{
    
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *subview in [view subviews]) {
        if ([[subview description] hasPrefix:[NSString stringWithFormat:@"<%@",type]]) {
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
