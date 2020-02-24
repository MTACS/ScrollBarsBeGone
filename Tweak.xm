@interface _UIScrollViewScrollIndicator : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

%group Tweak

%hook _UIScrollViewScrollIndicator

- (void)setForegroundColor:(UIColor *)arg1 {

    %orig([UIColor clearColor]);

}

%end

%end

%ctor {

    if (![NSProcessInfo processInfo]) return;

	NSString *processName = [NSProcessInfo processInfo].processName;

	bool isSpringBoard = [@"SpringBoard" isEqualToString:processName];

	bool shouldLoad = NO;

	NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];

	NSUInteger count = args.count;

	if (count != 0) {

		NSString *executablePath = args[0];

		if (executablePath) {

            NSString *processName = [executablePath lastPathComponent];

            BOOL isApplication = [executablePath rangeOfString:@"/Application/"].location != NSNotFound || [executablePath rangeOfString:@"/Applications/"].location != NSNotFound;

            BOOL isFileProvider = [[processName lowercaseString] rangeOfString:@"fileprovider"].location != NSNotFound;

            BOOL skip = [processName isEqualToString:@"AdSheet"]
                        || [processName isEqualToString:@"CoreAuthUI"]
                        || [processName isEqualToString:@"InCallService"]
                        || [processName isEqualToString:@"MessagesNotificationViewService"]
                        || [executablePath rangeOfString:@".appex/"].location != NSNotFound;

            if ((!isFileProvider && isApplication && !skip) || isSpringBoard) {

                shouldLoad = YES;

            }
        }

	}

	if (!shouldLoad) return;

    if (shouldLoad) {

        %init(Tweak);

        return;

    }

}
