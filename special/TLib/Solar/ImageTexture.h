//
//  ImageTexture.h
//  SolarSystem
//
//  Created by Ryan Martin on 2015-03-14.
//  Copyright (c) 2015 Ryan Martin. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>

@interface ImageTexture : NSObject

- (ImageTexture*) initFrom: (NSString *)file;
- (void)dealloc;
- (void)reloadFrom: (NSString *)file;
- (void)bind;
- (void)bindToUnit: (int)unit;

@end
