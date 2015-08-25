//
//  CCViewController.m
//  CCTagsTextView
//
//  Created by Daniel Mandea on 08/24/2015.
//  Copyright (c) 2015 Daniel Mandea. All rights reserved.
//

#import "CCViewController.h"
#import <CCTagsTextView/TagsTextView.h>

NSString *const kTagsMarker = @"#";

@interface CCViewController ()<TagsTextViewDelegate>

@property (weak, nonatomic) IBOutlet TagsTextView *tagsInputView;

@property (weak, nonatomic) IBOutlet UILabel *relatedTagsLabel;

@end

#define DESCRIPTION_TEXT_VIEW_PLACEHOLDER NSLocalizedStringFromTable(@"Complete with your notes and tags", @"Loan Page", @"DESCRIPTION_TEXT_VIEW_PLACEHOLDER: Complete with your notes and tags")

@implementation CCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // setup tags text view
    
    // Setup Tags Text View
    self.tagsInputView.tagsMarker = kTagsMarker;
    self.tagsInputView.placeholderText = DESCRIPTION_TEXT_VIEW_PLACEHOLDER;
    self.tagsInputView.textDefaultAttributes = @{
                                                NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                NSForegroundColorAttributeName:[UIColor blackColor],
                                                NSBackgroundColorAttributeName: [UIColor whiteColor]};
    
    self.tagsInputView.placeholderDefaultAttributes = @{
                                                       NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                       NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    
    self.tagsInputView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TagsTextViewDelegate

- (void)tagsTextViewUpdatedText:(NSString * __nullable)text {
    // Here is all the string 
}

- (void)tagsTextViewUpdatedTags:(NSArray * __nullable)tags {
    NSMutableString *tagsString = [[NSMutableString alloc] init];
    for (NSString *tag in tags) {
        [tagsString appendString:[NSString stringWithFormat:@"%@ ", tag]];
    }
    self.relatedTagsLabel.text = tagsString;
}


@end
