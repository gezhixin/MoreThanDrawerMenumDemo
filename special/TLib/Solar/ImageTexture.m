//
//  ImageTexture.m
//  SolarSystem
//
//  Created by Ryan Martin on 2015-03-14.
//  Copyright (c) 2015 Ryan Martin. All rights reserved.
//

#import "ImageTexture.h"
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface ImageTexture () {
	GLuint _textureID;
}

@end

@implementation ImageTexture

-(ImageTexture*) initFrom:(NSString *)file {
    
	self = [super init];

	if ( self ) {
		glGenTextures(1, &_textureID);
		[self reloadFrom:file];
	}

	return self;
}

- (void)dealloc {
    
	glDeleteTextures(1, &_textureID);
}

- (void)reloadFrom:(NSString *)file {
    
	CGImageRef texImage = [UIImage imageNamed:file].CGImage;
	if ( ! texImage ) {
		NSLog(@"Texture file not found!");
		return;
	}

	int texWidth = (int)CGImageGetWidth(texImage);
	int texHeight = (int)CGImageGetHeight(texImage);
	CGColorSpaceRef colorspace = CGImageGetColorSpace(texImage);

	if ( CGColorSpaceGetModel(colorspace) == kCGColorSpaceModelRGB ) {
		GLubyte *texData = (GLubyte*)malloc(texWidth * texHeight * 4);

		CGContextRef texContext = CGBitmapContextCreate(texData, texWidth, texHeight, 8, texWidth*4, colorspace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
		CGContextDrawImage(texContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), texImage);
		CGContextRelease(texContext);

		glBindTexture(GL_TEXTURE_2D, _textureID);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, texData);

		free(texData);
	}
	else if ( CGColorSpaceGetModel(colorspace) == kCGColorSpaceModelMonochrome ) {
		GLubyte *texData = (GLubyte*)malloc(texWidth * texHeight);

		CGContextRef texContext = CGBitmapContextCreate(texData, texWidth, texHeight, 8, texWidth, colorspace, kCGImageAlphaNone & kCGImageAlphaPremultipliedLast);
		CGContextDrawImage(texContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), texImage);
		CGContextRelease(texContext);
		
		glBindTexture(GL_TEXTURE_2D, _textureID);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE, texWidth, texHeight, 0, GL_LUMINANCE, GL_UNSIGNED_BYTE, texData);

		free(texData);
	}
}

- (void)bind {
    
	glEnable(GL_TEXTURE_2D);

	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	glBindTexture(GL_TEXTURE_2D, _textureID);
};

- (void)bindToUnit: (int)unit {
    
	glEnable(GL_TEXTURE_2D);

	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

	glActiveTexture(GL_TEXTURE0+unit);
	glBindTexture(GL_TEXTURE_2D, _textureID);
};

@end
