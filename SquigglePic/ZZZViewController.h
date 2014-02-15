//
//  ZZZViewController.h
//  SquigglePic
//
//  Created by _Zach on 2/14/14.
//  Copyright (c) 2014 Zacg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZZViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightToolbarButton;
- (IBAction)rightToolbarTouch:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftToolbarButton;
- (IBAction)leftToolbarTouch:(id)sender;

@end
