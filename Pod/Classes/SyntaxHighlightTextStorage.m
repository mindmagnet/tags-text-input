//
//  SyntaxHighlightTextStorage.m
//  TestTagTextView
//
//  Created by Mandea Daniel on 25/06/15.
//  Copyright (c) 2015 Mandea Daniel. All rights reserved.
//

#import "SyntaxHighlightTextStorage.h"

@implementation SyntaxHighlightTextStorage {
    NSMutableAttributedString *_backingStore;
}

- (instancetype)init {
    if (self = [super init]) {
        _backingStore = [NSMutableAttributedString new];
         [self createHighlightPatterns];
    }
    return self;
}

- (NSString *)string {
    return [_backingStore string];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location
                     effectiveRange:(NSRangePointer)range {
    return [_backingStore attributesAtIndex:location
                             effectiveRange:range];
}

#pragma mark - Override

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [self beginEditing];
    [_backingStore replaceCharactersInRange:range withString:str];
    [self  edited:NSTextStorageEditedCharacters | NSTextStorageEditedAttributes
            range:range
   changeInLength:str.length - range.length];
    [self endEditing];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range {
    [self beginEditing];
    [_backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

-(void)processEditing {
    [self performReplacementsForRange:[self editedRange]];
    [super processEditing];
}

- (void)performReplacementsForRange:(NSRange)changedRange {
    NSRange extendedRange = NSUnionRange(changedRange, [[_backingStore string]
                                                        lineRangeForRange:NSMakeRange(changedRange.location, 0)]);
    extendedRange = NSUnionRange(changedRange, [[_backingStore string]
                                                lineRangeForRange:NSMakeRange(NSMaxRange(changedRange), 0)]);
    [self applyStylesToRange:extendedRange];
}

- (void)applyStylesToRange:(NSRange)searchRange {
    
    // iterate over each replacement
    for (NSString* key in _replacements) {
        NSRegularExpression *regex = [NSRegularExpression
                                      regularExpressionWithPattern:key
                                      options:0
                                      error:nil];
        
        NSDictionary* attributes = _replacements[key];
        
        [regex enumerateMatchesInString:[_backingStore string]
                                options:0
                                  range:searchRange
                             usingBlock:^(NSTextCheckingResult *match,
                                          NSMatchingFlags flags,
                                          BOOL *stop){
                                 // apply the style
                                 NSRange matchRange = [match rangeAtIndex:1];
                                 [self addAttributes:attributes range:matchRange];
                                 
                                 // reset the style to the original
                                 if (NSMaxRange(matchRange) < self.length) {
                                     [self addAttributes:self.textAttributes
                                                   range:NSMakeRange(NSMaxRange(matchRange), 1)];
                                 }
                             }];
    }
}

- (void) createHighlightPatterns {
   
    // 1. base our script font on the preferred body font size
    UIFont* scriptFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:15];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0;
    paragraphStyle.lineSpacing = 5.0;
    
    NSDictionary* tagTextAttributes = @{ NSForegroundColorAttributeName : [UIColor lightTextColor],
                                         NSBackgroundColorAttributeName: [UIColor lightGrayColor],
                                         NSParagraphStyleAttributeName: paragraphStyle,
                                         NSFontAttributeName : scriptFont
                                    };
    
    // Set default text attributes
    _textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                        NSForegroundColorAttributeName:[UIColor blackColor],
                        NSBackgroundColorAttributeName: [UIColor whiteColor]};;
    // 3. construct a dictionary of replacements based on regexes
    _replacements = @{ @"(#\\w+)" : tagTextAttributes};

}

- (NSDictionary*)createAttributesForFontStyle:(NSString*)style
                                    withTrait:(uint32_t)trait {
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor
                                        preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    
    UIFontDescriptor *descriptorWithTrait = [fontDescriptor
                                             fontDescriptorWithSymbolicTraits:trait];
    
    UIFont* font =  [UIFont fontWithDescriptor:descriptorWithTrait size: 0.0];
    return @{ NSFontAttributeName : font };
}

@end