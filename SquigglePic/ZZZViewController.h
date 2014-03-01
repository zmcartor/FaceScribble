//
//  ZZZViewController.h
//  SquigglePic
//
//  Created by _Zach on 2/14/14.
//  Copyright (c) 2014 Zacg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKColorListPicker.h"

@interface ZZZViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, KKColorListViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftToolbarButton;
- (IBAction)leftToolbarTouch:(id)sender;

- (IBAction)colorButtonTouch:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *colorButton;

// thickness control
@property (strong, nonatomic) IBOutlet UIView *thicknessControlView;
@property (weak, nonatomic) IBOutlet UISlider *thicknessSlider;
@property (weak, nonatomic) IBOutlet UIView *thicknessVisualizer;
- (IBAction)thicknessButtonTapped:(id)sender;
- (IBAction)thicknessSliderChanged:(UISlider *)sender;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbarView;


@end
