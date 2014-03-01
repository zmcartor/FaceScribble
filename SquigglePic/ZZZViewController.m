//
//  ZZZViewController.m
//  SquigglePic
//
//  Created by _Zach on 2/14/14.
//  Copyright (c) 2014 Zacg. All rights reserved.
//

#import "ZZZViewController.h"
#import "ZZZSmoothBezierInterp.h"
#import "KKColorListPicker.h"

@interface ZZZViewController ()

@end

@implementation ZZZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.toolbarHidden = NO;

    ZZZSmoothBezierInterp *view = (ZZZSmoothBezierInterp *)self.view;
    [view attachRecognizers];
    
    [self updateStrokeColor:[self randomColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)leftToolbarTouch:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showActionSheetPhotoDatasource];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)colorButtonTouch:(id)sender {
    KKColorListViewController *controller = [[KKColorListViewController alloc] initWithSchemeType:KKColorsSchemeTypePantone];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)showActionSheetPhotoDatasource {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Sharing option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Snap a picture",
                            @"Choose from library",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark - UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
   
    // present the cropper control
    
}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    NSLog(@"cancelled");
//    
//}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if (buttonIndex == 0) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - KKColorDelegate
- (void)colorListController:(KKColorListViewController *)controller didSelectColor:(KKColor *)color {
    [self updateStrokeColor:color.uiColor];
}

- (void)updateStrokeColor:(UIColor *)color {
    ZZZSmoothBezierInterp *view = (ZZZSmoothBezierInterp *)self.view;
    view.strokeColor = color;
    
    // set the color of the button to this color
    [self.colorButton setTintColor:color];
}

- (UIColor *)randomColor {
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return color;
}


@end
