/*
 * CS 4768
 * Assignment #3
 * Matthew Newell
 * 201030699
 * 24 March 2014
 */

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <GLKit/GLKit.h>

@interface Planet : NSObject 
{
	
@private
	GLfloat			*m_VertexData;
	GLubyte			*m_ColorData;
	GLfloat			*m_NormalData;
    GLfloat         *m_TexCoordsData;
	GLint			m_Stacks, m_Slices;
	GLfloat			m_Scale;						
	GLfloat			m_Squash;
	GLfloat			m_Angle;
	GLfloat			m_Pos[3];
	GLfloat			m_RotationalIncrement;
    
    GLKTextureInfo  *m_TextureInfo;
}

-(bool)execute;
-(id)init:(GLint)stacks slices:(GLint)slices radius:(GLfloat)radius squash:(GLfloat)squash textureFile:(NSString *)textureFile;
-(void)getPositionX:(GLfloat *)x Y:(GLfloat *)y Z:(GLfloat *)z;
-(void)setPositionX:(GLfloat)x Y:(GLfloat)y Z:(GLfloat)z;
-(GLfloat)getRotation;
-(void)setRotation:(GLfloat)angle;
-(GLfloat)getRotationalIncrement;
-(void)setRotationalIncrement:(GLfloat)inc;
-(void)incrementRotation;
-(GLKTextureInfo *)loadTexture:(NSString *)filename;
@end
