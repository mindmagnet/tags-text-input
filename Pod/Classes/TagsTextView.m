//
//  TagsTextView.m
//  TestTagTextView
//
//  Created by Mandea Daniel on 25/06/15.
//  Copyright (c) 2015 Mandea Daniel. All rights reserved.
//

#import "TagsTextView.h"
#import "SyntaxHighlightTextStorage.h"

@interface TagsTextView () <UITextViewDelegate>

@property (nonatomic, strong, nonnull) SyntaxHighlightTextStorage* textStorage;
@property (nonatomic, strong, nonnull) UITextView *textView;
@property (nonatomic, strong, nonnull) NSString *_defaultTagMarker;

@end

@implementation TagsTextView

#pragma mark - Int

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

#pragma mark - Setup View

- (void)setupView {
    
    // 1. Create the text storage that backs the editor
    _textStorage = [SyntaxHighlightTextStorage new];
    CGRect newTextViewRect = self.bounds;
    
    // 2. Create the layout manager
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    
    // 3. Create a text container
    CGSize containerSize = CGSizeMake(newTextViewRect.size.width,  CGFLOAT_MAX);
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:containerSize];
    container.widthTracksTextView = YES;
    [layoutManager addTextContainer:container];
    [_textStorage addLayoutManager:layoutManager];
    
    // 4. Create a UITextView
    _textView = [[UITextView alloc] initWithFrame:newTextViewRect
                                    textContainer:container];
     [_textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_textView setKeyboardType:UIKeyboardTypeTwitter];
    [self addSubview:_textView];
    _textView.delegate = self;
    
    // Width constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem: self.textView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:0]];
    
    // Height constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem: self.textView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:0]];
    
    // Center horizontally
    [self addConstraint:[NSLayoutConstraint constraintWithItem: self.textView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    // Center vertically
    [self addConstraint:[NSLayoutConstraint constraintWithItem: self.textView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    // Set default tag marker
    self._defaultTagMarker = @"#";
}

#pragma mark - Public Setters

- (void)setReplacements:(NSDictionary * __nonnull)replacements {
    // Set text storrage replacements
    self.textStorage.replacements = replacements;
}

- (void)setTagsMarker:(NSString * __nonnull)tagsMarker {
    _tagsMarker = tagsMarker;
    self._defaultTagMarker = tagsMarker;
}

- (void)setPlaceholderText:(NSString * __nonnull)placeholderText {
    _placeholderText = placeholderText;
    // Set text for text view 
    if (self.placeholderDefaultAttributes) {
        self.textView.attributedText = [[NSAttributedString alloc] initWithString:placeholderText
                                                                       attributes:self.placeholderDefaultAttributes];
    } else {
        self.textView.text = placeholderText;
    }
}

- (void)setText:(NSString * __nullable)text {
    _text = text;
    if (self.textDefaultAttributes && text.length) {
        self.textView.attributedText = [[NSAttributedString alloc] initWithString:text
                                                                       attributes:self.textDefaultAttributes];
    } else if (text.length) {
        self.textView.text = text;
    }
    [self updateDelegateWithText:text];
}

- (void)setPlaceholderDefaultAttributes:(NSDictionary * __nonnull)placeholderDefaultAttributes {
    _placeholderDefaultAttributes = placeholderDefaultAttributes;
    // Set placeholder text
    if (self.placeholderText.length) {
        self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.placeholderText attributes:placeholderDefaultAttributes];
    }
}

- (void)setTextDefaultAttributes:(NSDictionary * __nonnull)textDefaultAttributes {
    _textDefaultAttributes = textDefaultAttributes;
    // Set the defaults attributes for text storrage too
    self.textStorage.textAttributes = textDefaultAttributes;
}

#pragma mark - Helper Methods

/**
 *  Use this method in order to get a tags array from text
 *
 *  @param tagMarker The marker that will mark the tags
 *  @param string    The string that contains the tags
 *
 *  @return An NSArray that contains all the tags
 */
- (NSArray *)getTagsMarkedBy:(NSString *)tagMarker fromString:(NSString *)string {
    NSMutableArray *substrings = [NSMutableArray new];
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanUpToString:tagMarker intoString:nil]; // Scan all characters before #
    while(![scanner isAtEnd]) {
        NSString *substring = nil;
        [scanner scanString:tagMarker intoString:nil]; // Scan the # character
        if([scanner scanUpToString:@" " intoString:&substring]) {
            // If the space immediately followed the #, this will be skipped
            [substrings addObject:substring];
        }
        [scanner scanUpToString:tagMarker intoString:nil]; // Scan all characters before next #
    }
    
    return substrings;
}

/**
 *  Use this method in order to update the delegate
 *
 *  @param text The text that will be used to get the tags and passed to delegate methd
 */
- (void)updateDelegateWithText:(NSString *)text {
    NSArray *newTags = [self getTagsMarkedBy:self._defaultTagMarker fromString:text];
    // Update tags added
    if (![newTags isEqual:self.tagsAdded]) {
        _tagsAdded = newTags;
        // Update the delegate
        if (self.delegate && [self.delegate respondsToSelector:@selector(tagsTextViewUpdatedTags:)]) {
            [self.delegate tagsTextViewUpdatedTags:newTags];
        }
    }
    // Update text added
    if (![text isEqualToString:self.textAdded]) {
        _textAdded = text;
        // Update the delegate
        if (self.delegate && [self.delegate respondsToSelector:@selector(tagsTextViewUpdatedText:)]) {
            [self.delegate tagsTextViewUpdatedText:text];
        }
    }
}

#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    // DO some updates here
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.placeholderText]) {
        textView.text = nil;
    }
    // Set text field default attributes
    if (self.textDefaultAttributes.allKeys.count) {
        if (textView.text.length) {
            textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:self.textDefaultAttributes];
        } else {
            textView.attributedText = [[NSAttributedString alloc] initWithString:@" " attributes:self.textDefaultAttributes];
        }
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    // Update after the editing ended
    [self updateDelegateWithText:textView.text];
    if ([textView.text isEqualToString:self.placeholderText]) {
        if (self.textDefaultAttributes.allKeys.count) {
            textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:self.placeholderDefaultAttributes];
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    // Update each time something changes
    [self updateDelegateWithText:textView.text];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}

@end
