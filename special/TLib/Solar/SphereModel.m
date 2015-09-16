//
//  SphereModel.m
//  SolarSystem
//
//  Created by Ryan Martin on 2015-03-14.
//  Copyright (c) 2015 Ryan Martin. All rights reserved.
//

#import "SphereModel.h"

@interface SphereModel () {
    
	int _numSeg, _numIndex, _numVertex;

	GLfloat *_vertices;
	GLushort *_indices;

	GLuint _vertexBuff, _indexBuff, _tangetBuff;
}

@end

@implementation SphereModel

-(SphereModel*) init: (int) seg {
    
	self = [super init];

	if ( self ) {
		_vertexBuff = _indexBuff = _tangetBuff = 0;

		_numSeg = seg, _numVertex = (seg*2+1)*(seg+1), _numIndex = (seg*2+1)*seg*2;
		_vertices = (GLfloat *)malloc(_numVertex*5*sizeof(GLfloat));
		_indices = (GLushort *)malloc(_numIndex*sizeof(GLushort));

		for ( int j=0, c=0; j<=seg; j++ ) {
			float y = cos(M_PI*j/seg), xz = sin(M_PI*j/seg), v = (float)j/seg;
			for ( int i=0; i<=seg*2; i++, c+=5 )
				_vertices[c] = cos(M_PI*i/seg) * xz,
				_vertices[c+1] = y,
				_vertices[c+2] = - sin(M_PI*i/seg) * xz,
				_vertices[c+3] = (float)i/seg/2, _vertices[c+4] = v;
		}

		for ( int j=0, k=0, c=0; j<seg; j++ )
			for ( int i=0; i<=seg*2; i++, k++, c+=2 )
				_indices[c] = k, _indices[c+1] = k+seg*2+1;
	}

	return self;
}

- (void)dealloc {
    
	glDeleteBuffers(1, &_vertexBuff);
	glDeleteVertexArraysOES(1, &_indexBuff);
	free(_vertices);
	free(_indices);
}

- (void)createVertexBufferObject {
    
	glGenBuffers(1, &_vertexBuff);
	glBindBuffer(GL_ARRAY_BUFFER, _vertexBuff);
	glBufferData(GL_ARRAY_BUFFER, _numVertex*5*sizeof(GLfloat), _vertices, GL_STATIC_DRAW);
	glGenBuffers(1, &_indexBuff);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuff);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, _numIndex*sizeof(GLushort), _indices, GL_STATIC_DRAW);

	glEnableVertexAttribArray(ATTRIB_POSITION);
	glVertexAttribPointer(ATTRIB_POSITION, 3, GL_FLOAT, GL_FALSE, 5*sizeof(GLfloat), 0);
	glEnableVertexAttribArray(ATTRIB_NORMAL);
	glVertexAttribPointer(ATTRIB_NORMAL, 3, GL_FLOAT, GL_FALSE, 5*sizeof(GLfloat), 0);
	glEnableVertexAttribArray(ATTRIB_TEXCOORD);
	glVertexAttribPointer(ATTRIB_TEXCOORD, 2, GL_FLOAT, GL_FALSE, 5*sizeof(GLfloat), ((float*)0)+3);

	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}

- (void)createTangentVBO {
    
	GLfloat* tangets = (GLfloat *)malloc(_numVertex*6*sizeof(GLfloat));

	for ( int j=0, c=0; j<=_numSeg; j++ ) {
		float y = cos(M_PI*j/_numSeg), xz = sin(M_PI*j/_numSeg);
		for ( int i=0; i<=_numSeg*2; i++, c+=6 )
			tangets[c] = -sin(M_PI*i/_numSeg), tangets[c+1] = 0, tangets[c+2] = cos(M_PI*i/_numSeg),
			tangets[c+3] = cos(M_PI*i/_numSeg)*y, tangets[c+4] = -xz, tangets[c+5] = sin(M_PI*i/_numSeg)*y;
	}

	glGenBuffers(1, &_tangetBuff);
	glBindBuffer(GL_ARRAY_BUFFER, _tangetBuff);
	glBufferData(GL_ARRAY_BUFFER, _numVertex*6*sizeof(GLfloat), tangets, GL_STATIC_DRAW);

	glEnableVertexAttribArray(ATTRIB_TANGENT);
	glVertexAttribPointer(ATTRIB_TANGENT, 2, GL_FLOAT, GL_FALSE, 6*sizeof(GLfloat), 0);
	glEnableVertexAttribArray(ATTRIB_BITANGENT);
	glVertexAttribPointer(ATTRIB_BITANGENT, 2, GL_FLOAT, GL_FALSE, 6*sizeof(GLfloat), ((float*)0)+3);

	free(tangets);

	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}

- (void)drawOpenGLES1 {
    
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_NORMAL_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);

	glVertexPointer(3, GL_FLOAT, sizeof(GLfloat)*5, _vertices);
	glNormalPointer(GL_FLOAT, sizeof(GLfloat)*5, _vertices);
	glTexCoordPointer(2, GL_FLOAT, sizeof(GLfloat)*5, _vertices+3);

	for ( int j=0, c=0; j<_numSeg; j++, c+=(_numSeg*2+1)*2 )
		glDrawElements(GL_TRIANGLE_STRIP, (_numSeg*2+1)*2, GL_UNSIGNED_SHORT, _indices+c);

	glDisableClientState(GL_NORMAL_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
}

- (void)drawOpenGLES2 {
    
	glBindBuffer(GL_ARRAY_BUFFER, _vertexBuff);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuff);

	for ( int j=0, c=0; j<_numSeg; j++, c+=(_numSeg*2+1)*2 )
		glDrawElements(GL_TRIANGLE_STRIP, (_numSeg*2+1)*2, GL_UNSIGNED_SHORT, (short*)0+c);

	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}

@end
