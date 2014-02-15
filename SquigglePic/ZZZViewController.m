//
//  ZZZViewController.m
//  SquigglePic
//
//  Created by _Zach on 2/14/14.
//  Copyright (c) 2014 Zacg. All rights reserved.
//

#import "ZZZViewController.h"
#import "ZZZSmoothBezierInterp.h"

@interface ZZZViewController ()

@end

@implementation ZZZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    ZZZSmoothBezierInterp *view = (ZZZSmoothBezierInterp *)self.view;
    [view attachRecognizers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rightToolbarTouch:(id)sender {
    NSLog(@"right click");
}

// TODO use an actionsheet to pick camera or library ...
- (IBAction)leftToolbarTouch:(id)sender {
    
    // TODO verify the sourceType 
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {}
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // flip to library sourceType
    //UIImagePickerControllerSourceTypeCamera
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

}

@end
