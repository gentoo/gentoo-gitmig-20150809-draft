/**
 * This example taken from the tutorial at:
 * http://gnustep.made-it.com/GSPT/xml/Tutorial_en.html
 *
 <quote>
 A GNUstep Programming Tutorial
 Time is on our side...
 Yen-Ju Chen
 Dennis Leeuw

 Copyright © 2003 Yen-Ju Chen, Dennis Leeuw

 Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.2 or any later version published by the Free Software Foundation; with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
 </quote>
 */

#include <objc/Object.h>

@interface Greeter:Object
{
  /* This is left empty on purpose:
   ** Normally instance variables would be declared here,
   ** but these are not used in our example.
   */
}

- (void)greet;

@end

#include <stdio.h>

@implementation Greeter

- (void)greet
{
	printf("Hello, World!\n");
}

@end

#include <stdlib.h>

int main(void)
{
	id myGreeter;
	myGreeter=[Greeter new];

	[myGreeter greet];

	[myGreeter free];
	return EXIT_SUCCESS;
}

