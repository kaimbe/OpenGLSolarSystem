/*
 * CS 4768
 * Assignment #3
 * Matthew Newell
 * 201030699
 * 24 March 2014
 */

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "OpenGLSolarSystem.h" 
#import "OpenGLSolarSystemController.h"

@interface OpenGLSolarSystemViewController : GLKViewController
{
    OpenGLSolarSystemController *m_SolarSystem;
    
};

-(void)viewDidLoad;
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect;
-(void)setClipping;
-(void)initLighting;
@end
