# CCTagsTextView

[![CI Status](http://img.shields.io/travis/Daniel Mandea/CCTagsTextView.svg?style=flat)](https://travis-ci.org/Daniel Mandea/CCTagsTextView)
[![Version](https://img.shields.io/cocoapods/v/CCTagsTextView.svg?style=flat)](http://cocoapods.org/pods/CCTagsTextView)
[![License](https://img.shields.io/cocoapods/l/CCTagsTextView.svg?style=flat)](http://cocoapods.org/pods/CCTagsTextView)
[![Platform](https://img.shields.io/cocoapods/p/CCTagsTextView.svg?style=flat)](http://cocoapods.org/pods/CCTagsTextView)

##  About 

This is a  wrapper over UITextView that offers support for finding and marking tags in the text entered. Take a look over example project in order to  the ideea .

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

1. Create a view in your storyboard or xib 
2. Connect your IBOutlet with the VC 

```objc
@property (weak, nonatomic) IBOutlet TagsTextView *tagsInputView;
```

3. After the view was loaded setup tags text view 

```objc
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

```


## Requirements

iOS 8 or later 

## Installation

CCTagsTextView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:



```ruby
pod "CCTagsTextView"
```

## Author

Daniel Mandea, daniel.mandea@mindmagnetsoftware.com

## License

CCTagsTextView is available under the MIT license. See the LICENSE file for more info.
