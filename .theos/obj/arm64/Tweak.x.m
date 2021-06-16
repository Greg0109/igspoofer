#line 1 "Tweak.x"
#import <UIKit/UIKit.h>

@interface IGStyledString : NSMutableString
- (void)appendString:(id)arg1;
- (void)appendLinkedString:(id)arg1;
@end

@interface IGCoreTextView
@property(copy, nonatomic) IGStyledString *styledString; 
@property(readonly, nonatomic) NSString *text;
- (void)_handleLongTap;
- (long long)lineForString:(id)arg1;
@end

@interface UILabel (IGSpoofer)
-(id)initWithFrame:(CGRect)arg1;
-(NSString *)text;
-(void)_setText:(id)arg1;
@end

@interface IGFeedItemTextCell : UICollectionViewCell
@property (nonatomic, retain) NSString *_accessibilityLabelForStyledString;
-(id)initWithFrame:(CGRect)arg1;
-(void)usertapped:(UIGestureRecognizer*)gestureRecognizer;
@end


NSString *realUser;
NSString *fakeUser;
NSString *likesString = @"gusta";
NSString *fakeLikes;
NSString *commentsString = @"comentario";
NSString *fakeComments;

static NSString *replaceUserForText(NSString *text) {
	NSString *modified = [text stringByReplacingOccurrencesOfString:realUser withString:fakeUser];
	return modified;
}


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class IGStyledString; @class UILabel; 
static NSString * (*_logos_orig$_ungrouped$UILabel$text)(_LOGOS_SELF_TYPE_NORMAL UILabel* _LOGOS_SELF_CONST, SEL); static NSString * _logos_method$_ungrouped$UILabel$text(_LOGOS_SELF_TYPE_NORMAL UILabel* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$UILabel$_setText$)(_LOGOS_SELF_TYPE_NORMAL UILabel* _LOGOS_SELF_CONST, SEL, NSString *); static void _logos_method$_ungrouped$UILabel$_setText$(_LOGOS_SELF_TYPE_NORMAL UILabel* _LOGOS_SELF_CONST, SEL, NSString *); static void (*_logos_orig$_ungrouped$IGStyledString$appendString$)(_LOGOS_SELF_TYPE_NORMAL IGStyledString* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$IGStyledString$appendString$(_LOGOS_SELF_TYPE_NORMAL IGStyledString* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$IGStyledString$appendLinkedString$)(_LOGOS_SELF_TYPE_NORMAL IGStyledString* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$IGStyledString$appendLinkedString$(_LOGOS_SELF_TYPE_NORMAL IGStyledString* _LOGOS_SELF_CONST, SEL, id); 

#line 40 "Tweak.x"

static NSString * _logos_method$_ungrouped$UILabel$text(_LOGOS_SELF_TYPE_NORMAL UILabel* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	NSString *origtext = _logos_orig$_ungrouped$UILabel$text(self, _cmd);
	return replaceUserForText(origtext);
}

static void _logos_method$_ungrouped$UILabel$_setText$(_LOGOS_SELF_TYPE_NORMAL UILabel* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * arg1) {
	NSString *textReplaced = replaceUserForText([arg1 lowercaseString]);
	_logos_orig$_ungrouped$UILabel$_setText$(self, _cmd, textReplaced);
}


 
static void _logos_method$_ungrouped$IGStyledString$appendString$(_LOGOS_SELF_TYPE_NORMAL IGStyledString* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
	if ([arg1 containsString:realUser]) {
		NSString *modifiedString = [arg1 stringByReplacingOccurrencesOfString:realUser withString:fakeUser];
		_logos_orig$_ungrouped$IGStyledString$appendString$(self, _cmd, modifiedString);
	} else if ([arg1 containsString:likesString]) {
		_logos_orig$_ungrouped$IGStyledString$appendString$(self, _cmd, [NSString stringWithFormat:@"%@ Likes", fakeLikes]);
	} else if ([arg1 containsString:commentsString]) {
		_logos_orig$_ungrouped$IGStyledString$appendString$(self, _cmd, [NSString stringWithFormat:@"View all %@ comments", fakeComments]);
	} else {
		_logos_orig$_ungrouped$IGStyledString$appendString$(self, _cmd, arg1);
	}
}

static void _logos_method$_ungrouped$IGStyledString$appendLinkedString$(_LOGOS_SELF_TYPE_NORMAL IGStyledString* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
	if ([arg1 containsString:realUser]) {
		NSString *modifiedString = [arg1 stringByReplacingOccurrencesOfString:realUser withString:fakeUser];
		_logos_orig$_ungrouped$IGStyledString$appendLinkedString$(self, _cmd, modifiedString);
	} else if ([arg1 containsString:likesString]) {
		_logos_orig$_ungrouped$IGStyledString$appendLinkedString$(self, _cmd, [NSString stringWithFormat:@"%@ Likes", fakeLikes]);
	} else if ([arg1 containsString:commentsString]) {
		_logos_orig$_ungrouped$IGStyledString$appendLinkedString$(self, _cmd, [NSString stringWithFormat:@"View all %@ comments", fakeComments]);
	} else {
		_logos_orig$_ungrouped$IGStyledString$appendLinkedString$(self, _cmd, arg1);
	}
}


static __attribute__((constructor)) void _logosLocalCtor_d89c9af8(int __unused argc, char __unused **argv, char __unused **envp) {
	NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:@"/User/Library/Preferences/com.greg0109.igspooferprefs.plist"];
	BOOL enabled = prefs[@"enabled"] ? [prefs[@"enabled"] boolValue] : YES;
	realUser = prefs[@"realUser"] && !([prefs[@"realUser"] isEqualToString:@""]) ? [prefs[@"realUser"] stringValue] : @"User";
	fakeUser = prefs[@"fakeUser"] && !([prefs[@"fakeUser"] isEqualToString:@""]) ? [prefs[@"fakeUser"] stringValue] : @"fakeUser";
	fakeLikes = prefs[@"fakeLikes"] && !([prefs[@"fakeLikes"] isEqualToString:@""]) ? [prefs[@"fakeLikes"] stringValue] : @"fakeLikes";
	fakeComments = prefs[@"fakeComments"] && !([prefs[@"fakeComments"] isEqualToString:@""]) ? [prefs[@"fakeComments"] stringValue] : @"fakeComments";

	if (enabled) {
		{Class _logos_class$_ungrouped$UILabel = objc_getClass("UILabel"); { MSHookMessageEx(_logos_class$_ungrouped$UILabel, @selector(text), (IMP)&_logos_method$_ungrouped$UILabel$text, (IMP*)&_logos_orig$_ungrouped$UILabel$text);}{ MSHookMessageEx(_logos_class$_ungrouped$UILabel, @selector(_setText:), (IMP)&_logos_method$_ungrouped$UILabel$_setText$, (IMP*)&_logos_orig$_ungrouped$UILabel$_setText$);}Class _logos_class$_ungrouped$IGStyledString = objc_getClass("IGStyledString"); { MSHookMessageEx(_logos_class$_ungrouped$IGStyledString, @selector(appendString:), (IMP)&_logos_method$_ungrouped$IGStyledString$appendString$, (IMP*)&_logos_orig$_ungrouped$IGStyledString$appendString$);}{ MSHookMessageEx(_logos_class$_ungrouped$IGStyledString, @selector(appendLinkedString:), (IMP)&_logos_method$_ungrouped$IGStyledString$appendLinkedString$, (IMP*)&_logos_orig$_ungrouped$IGStyledString$appendLinkedString$);}}
	}
}
