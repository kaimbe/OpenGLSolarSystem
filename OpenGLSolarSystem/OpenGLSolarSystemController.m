/*
 * CS 4768
 * Assignment #3
 * Matthew Newell
 * 201030699
 * 24 March 2014
 */

#import "OpenGLSolarSystem.h" 
#import "OpenGLSolarSystemController.h"

@implementation OpenGLSolarSystemController

-(id)init
{
	[self initGeometry];					
	
	return self;
}

-(void)initGeometry
{
    // camera position. When testing, you can change the z value to zoom in or out
	m_Eyeposition[X_VALUE]=0.0;
	m_Eyeposition[Y_VALUE]=0.0;
	m_Eyeposition[Z_VALUE]=28.0;
    
    // radius of each planet. All radiui are to scale, except the sun.
    float earth_radius = 1.0;
    float sun_radius = 2.0;
    float mercury_radius = earth_radius*0.383;
    float venus_radius = earth_radius*0.950;
    float moon_radius = earth_radius*0.273;
    float mars_radius = earth_radius*0.532;
    
    // AU definition. The given value scales things way to much for this animation. I approximated a value that makes the distances look realistic.
    float au = earth_radius * 7;
    
    // planet distances. Distance from sun to planet, except for moon. (earth to moon)
    float mercury_distance = 0.387*au;
    float venus_distance = 0.723*au;
    float earth_distance = au;
    float moon_distance = 0.00257*au;
    float mars_distance = 1.524*au;
    
    // initialize planets
    m_Sun=[[Planet alloc] init:50 slices:50 radius:sun_radius squash:1.0 textureFile:@"sun.png"];
	[m_Sun setPositionX:0.0 Y:0.0 Z:0.0];
    
    m_Mercury=[[Planet alloc] init:50 slices:50 radius:mercury_radius squash:1.0 textureFile:@"mercury.png"];
    [m_Mercury setPositionX:0.0 Y:0.0 Z:-(mercury_distance+sun_radius+mercury_radius)];
    
    m_Venus=[[Planet alloc] init:50 slices:50 radius:venus_radius squash:1.0 textureFile:@"venus.png"];
    [m_Venus setPositionX:0.0 Y:0.0 Z:-(venus_distance+sun_radius+venus_radius)];
    
    m_Earth=[[Planet alloc] init:50 slices:50 radius:earth_radius squash:1.0 textureFile:@"earth.png"];
	[m_Earth setPositionX:0.0 Y:0.0 Z:-(earth_distance+sun_radius+earth_radius)];
    
    m_Moon=[[Planet alloc] init:50 slices:50 radius:moon_radius squash:1.0 textureFile:@"moon.png"];
    [m_Moon setPositionX:0.0 Y:0.0 Z:-(moon_distance+earth_radius+moon_radius)];
    
    m_Mars = [[Planet alloc] init:50 slices:50 radius:mars_radius squash:1.0 textureFile:@"mars.png"];
	[m_Mars setPositionX:0.0 Y:0.0 Z:-(mars_distance+sun_radius+mars_radius)];
    
}
-(void)execute
{
    // colors
	GLfloat paleYellow[]={1.0,1.0,0.3,1.0};
	GLfloat white[]={1.0,1.0,1.0,1.0};			
	GLfloat cyan[]={0.0,1.0,1.0,1.0};	
	GLfloat black[]={0.0,0.0,0.0,0.0};
    
    GLfloat marsColor[]={143.0/255.0,89.0/255.0,79.0/255.0};
    GLfloat moonColor[]={143.0/255.0,143.0/255.0,143.0/255.0};
    GLfloat earthColor[]={28.0/255.0,84.0/255.0,111.0/255.0};
    GLfloat venusColor[]={185.0/255.0,115.0/255.0,29.0/255.0};
    GLfloat mercuryColor[]={102.0/255.0,43.0/255.0,1.0/255.0};
    
    // used to store the current angle of each planet
    static GLfloat marsAngle = 0.0;
    static GLfloat moonAngle = 0.0;
    static GLfloat earthAngle = 0.0;
    static GLfloat venusAngle = 0.0;
    static GLfloat mercuryAngle = 0.0;
    
    // sets the rate at which a planet orbits
    GLfloat marsOrbitalIncrement = 1.881;
    GLfloat moonOrbitalIncrement = 0.0748;
    GLfloat earthOrbitalIncrement = 1.0;
    GLfloat venusOrbitalIncrement = 0.615;
    GLfloat mercuryOrbitalIncrement = 0.240;
    
	GLfloat sunPos[3]={0.0,0.0,0.0};

	glPushMatrix();
    
	glTranslatef(-m_Eyeposition[X_VALUE],-m_Eyeposition[Y_VALUE],-m_Eyeposition[Z_VALUE]);
    
    // light from sun
	glLightfv(SS_SUNLIGHT,GL_POSITION,sunPos);
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, cyan);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, white);
    
    // mars
    glPushMatrix();
    marsAngle+=marsOrbitalIncrement;
	glRotatef(marsAngle,0.0,1.0,0.0);
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, marsColor);
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, black);
    [self executePlanet:m_Mars];
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, black);
	glPopMatrix();
    
    // earth
    glPushMatrix();
	earthAngle+=earthOrbitalIncrement;
	glRotatef(earthAngle,0.0,1.0,0.0);
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, earthColor);
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, black);
	[self executePlanet:m_Earth];
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, black);
    
    // moon. putting this here will make the moon rotate around the earth instead of the sun.
    glPushMatrix();
	moonAngle+=moonOrbitalIncrement;
    GLfloat x,y,z;
    [m_Earth getPositionX:&x Y:&y Z:&z];
    glTranslatef(x, y, z);
    glRotatef(moonAngle,0.0,1.0,0.0);
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, moonColor);
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, black);
    [self executePlanet:m_Moon];
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, black);
    // end moon
    glPopMatrix();
    
    // end earth
    glPopMatrix();
    
    // venus
    glPushMatrix();
	venusAngle+=venusOrbitalIncrement;
	glRotatef(venusAngle,0.0,1.0,0.0);
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, venusColor);
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, black);
	[self executePlanet:m_Venus];
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, black);
    glPopMatrix();
    
    // mercury
    glPushMatrix();
	mercuryAngle+=mercuryOrbitalIncrement;
	glRotatef(mercuryAngle,0.0,1.0,0.0);
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, mercuryColor);
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, black);
	[self executePlanet:m_Mercury];
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, black);
    glPopMatrix();
    
    // sun
	glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, paleYellow);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, black);
    [self executePlanet:m_Sun];
	glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, black);
	glPopMatrix();
     }

-(void)executePlanet:(Planet *)planet
{
	GLfloat posX, posY, posZ;
	glPushMatrix();
	[planet getPositionX:&posX Y:&posY Z:&posZ];
	glTranslatef(posX,posY,posZ);
	[planet execute];
	glPopMatrix();
}

-(GLKTextureInfo *)loadTexture:(NSString *)filename
{
    NSError *error;
    GLKTextureInfo *info;
    
    NSString *path=[[NSBundle mainBundle]pathForResource:filename ofType:NULL];
    
    info=[GLKTextureLoader textureWithContentsOfFile:path options:NULL error:&error];
    
    glBindTexture(GL_TEXTURE_2D, info.name);
    
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_REPEAT); 	
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_REPEAT);	
    
    return info;
}

@end
