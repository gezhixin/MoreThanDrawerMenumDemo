//
//  SphereModel.h
//  SolarSystem
//
//  Created by Ryan Martin on 2015-03-14.
//  Copyright (c) 2015 Ryan Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES2/glext.h>

// VBO attribute index
enum
{
	ATTRIB_POSITION,
	ATTRIB_NORMAL,
	ATTRIB_COLOR,
	ATTRIB_TEXCOORD,
	ATTRIB_TANGENT,
	ATTRIB_BITANGENT,

	NUM_ATTRIB
};

@interface SphereModel : NSObject

- (SphereModel*) init: (int) seg;
- (void)dealloc;
- (void)drawOpenGLES1;
- (void)drawOpenGLES2;
- (void)createVertexBufferObject;
- (void)createTangentVBO;

@end
