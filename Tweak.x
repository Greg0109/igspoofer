#import <UIKit/UIKit.h>

@interface IGStyledString : NSMutableString
- (void)appendString:(id)arg1;
- (void)appendLinkedString:(id)arg1;
@end

@interface IGCoreTextView
@property(copy, nonatomic) IGStyledString *styledString; // @synthesize styledString=_styledString;
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
NSString *likesString = @"likes";
NSString *fakeLikes;
NSString *commentsString = @"comments";
NSString *fakeComments;

static NSString *replaceUserForText(NSString *text) {
	NSString *modified = [[text lowercaseString] stringByReplacingOccurrencesOfString:[realUser lowercaseString] withString:fakeUser];
	return modified;
}

%hook UILabel
-(NSString *)text {
	NSString *origtext = %orig;
	return replaceUserForText(origtext);
}

-(void)_setText:(NSString *)arg1 {
	NSString *textReplaced = replaceUserForText(arg1);
	%orig(textReplaced);
}
%end

%hook IGStyledString // This is for likes and comments and user in comments?
- (void)appendString:(id)arg1 {
	NSString *origString = [arg1 lowercaseString];
	if ([origString containsString:realUser]) {
		NSString *modifiedString = [origString stringByReplacingOccurrencesOfString:realUser withString:fakeUser];
		%orig(modifiedString);
	} else if ([origString containsString:likesString] && ([[origString componentsSeparatedByString:@" "] count] == 2)) {
		%orig([NSString stringWithFormat:@"%@ Likes", fakeLikes]);
	} else if ([origString containsString:commentsString] && ([[origString componentsSeparatedByString:@" "] count] == 4)) {
		%orig([NSString stringWithFormat:@"View all %@ comments", fakeComments]);
	} else {
		%orig;
	}
}

- (void)appendLinkedString:(id)arg1 {
	NSString *origString = [arg1 lowercaseString];
	if ([origString containsString:realUser]) {
		NSString *modifiedString = [origString stringByReplacingOccurrencesOfString:realUser withString:fakeUser];
		%orig(modifiedString);
	} else if ([origString containsString:likesString] && ([[origString componentsSeparatedByString:@" "] count] == 2)) {
		%orig([NSString stringWithFormat:@"%@ Likes", fakeLikes]);
	} else if ([origString containsString:commentsString] && ([[origString componentsSeparatedByString:@" "] count] == 4)) {
		%orig([NSString stringWithFormat:@"View all %@ comments", fakeComments]);
	} else {
		%orig;
	}
}
%end

%ctor {
	NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:@"/User/Library/Preferences/com.greg0109.igspooferprefs.plist"];
	BOOL enabled = prefs[@"enabled"] ? [prefs[@"enabled"] boolValue] : YES;
	realUser = prefs[@"realUser"] && !([prefs[@"realUser"] isEqualToString:@""]) ? [prefs[@"realUser"] stringValue] : @"User";
	fakeUser = prefs[@"fakeUser"] && !([prefs[@"fakeUser"] isEqualToString:@""]) ? [prefs[@"fakeUser"] stringValue] : @"fakeUser";
	fakeLikes = prefs[@"fakeLikes"] && !([prefs[@"fakeLikes"] isEqualToString:@""]) ? [prefs[@"fakeLikes"] stringValue] : @"fakeLikes";
	fakeComments = prefs[@"fakeComments"] && !([prefs[@"fakeComments"] isEqualToString:@""]) ? [prefs[@"fakeComments"] stringValue] : @"fakeComments";

	if (enabled) {
		%init();
	}
}