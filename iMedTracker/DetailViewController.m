//
//  DetailViewController.m
//  iMedTracker
//
//  Created by Jesus Guerra Rosas on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()



@end

@implementation DetailViewController
@synthesize name;
@synthesize dosis;
@synthesize delegate;
@synthesize med;
@synthesize medImage;



#pragma mark -  

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.medImage.layer.cornerRadius= 8.0;
    self.medImage.clipsToBounds = YES;
    
    if (!self.med) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(addNewMed)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAdd)];
        
        [self.name becomeFirstResponder];
    }
}

-(void) cancelAdd{
    [self.navigationController dismissModalViewControllerAnimated:YES];    
}

-(void)addNewMed{
    self.med = [[Medecine alloc] init];
    self.med.name = self.name.text;
    self.med.dosis = [self.dosis.text intValue];
    NSLog(@"MedName before send %@", self.med.name);
    [self.delegate addMedToList:self.med];
    [self cancelAdd];
}

- (void)viewDidUnload
{
    [self setName:nil];
    [self setDosis:nil];
    [self setMedImage:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
   if (self.med) {  
       self.name.text = self.med.name;
       self.dosis.text = [NSString stringWithFormat:@"%i", self.med.dosis];
       
   }

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}








- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self.medImage setImage:image];
    [self dismissModalViewControllerAnimated:YES];
}





-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
        
        UIImagePickerController *imagePicker;
        
        if(!imagePicker){
            imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
        }

        if (buttonIndex == 0) {
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera; 
        } else if (buttonIndex == 1) {
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum; 
        }else {
            return;
        }
        
        
        [self presentModalViewController:imagePicker animated:YES];

}


- (IBAction)showActionSheet:(id)sender {

    [self.name resignFirstResponder];
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Select Source:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Gallery", nil];
    [action showInView:self.view];
}
@end
