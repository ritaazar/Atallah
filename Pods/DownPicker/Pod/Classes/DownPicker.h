//
//   DownPicker.h
// --------------------------------------------------------
//      Lightweight DropDownList/ComboBox control for iOS
//
// by Darkseal, 2013-2015 - MIT License
//
// Website: http://www.ryadel.com/
// GitHub:  http://www.ryadel.com/
//

#import <UIKit/UIKit.h>

@protocol DownPickerParentDelegate <NSObject>

-(void) didSelectValue: (NSString *) selectedValue;

@end
@interface DownPicker : UIControl<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
{
    UIPickerView* pickerView;
    IBOutlet UITextField* textField;
    NSArray* dataArray;
    NSString* placeholder;
    NSString* placeholderWhileSelecting;
	NSString* toolbarDoneButtonText;
    NSString* toolbarCancelButtonText;
	UIBarStyle toolbarStyle;
}

@property (nonatomic, strong) UIViewController<DownPickerParentDelegate> *parentView;
@property (nonatomic) NSString* text;
@property (nonatomic) NSInteger selectedIndex;

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define BEIGE_COLOR UIColorFromRGB(0x00F5F1DE)

-(id)initWithTextField:(UITextField *)tf;
-(id)initWithTextField:(UITextField *)tf withData:(NSArray*) data withPlaceHolder:(NSString *) placeHolderVal;

@property (nonatomic) BOOL shouldDisplayCancelButton;

/**
 Sets an alternative image to be show to the right part of the textbox (assuming that showArrowImage is set to TRUE).
 @param image
 A valid UIImage
 */
-(void) setArrowImage:(UIImage*)image;

-(void) setData:(NSArray*) data;
-(void) setPlaceholder:(NSString*)str;
-(void) setPlaceholderWhileSelecting:(NSString*)str;
-(void) setAttributedPlaceholder:(NSAttributedString *)attributedString;
-(void) setToolbarDoneButtonText:(NSString*)str;
-(void) setToolbarCancelButtonText:(NSString*)str;
-(void) setToolbarStyle:(UIBarStyle)style;

/**
 TRUE to show the rightmost arrow image, FALSE to hide it.
 @param b
 TRUE to show the rightmost arrow image, FALSE to hide it.
 */
-(void) showArrowImage:(BOOL)b;

-(UIPickerView*) getPickerView;
-(UITextField*) getTextField;

/**
 Retrieves the string value at the specified index.
 @return
 The value at the given index or NIL if nothing has been selected yet.
 */
-(NSString*) getValueAtIndex:(NSInteger)index;

/**
 Sets the zero-based index of the selected item: -1 can be used to clear selection.
 @return
 The value at the given index or NIL if nothing has been selected yet.
 */
-(void) setValueAtIndex:(NSInteger)index;
@end
