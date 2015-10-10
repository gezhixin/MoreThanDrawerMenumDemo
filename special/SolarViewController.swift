//
//  SolarViewController.swift
//  special
//
//  Created by 葛枝鑫 on 15/5/4.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

//用作homePageView的背景之一， 模拟太阳系


import Foundation
import UIKit
import GLKit
import OpenGLES

class SolarViewController: GLKViewController {

    
    var _sphereModel: SphereModel?
    var _sun: SphereModel?
    var _moon: SphereModel?
    var _venus = SphereModel(16)  // earth
    var _mars = SphereModel(16)  // sun
    var _mercury = SphereModel(16)
    
    var _earthTexture = ImageTexture(from:"earth.png")
    var _sunTexture = ImageTexture(from:"Sun.png")
    var _moontexture = ImageTexture(from: "moon.png")
    var _venusTexture = ImageTexture(from:"Venus.png")
    var _marsTexture = ImageTexture(from:"Mars.png")
    var _mercuryTexture = ImageTexture(from: "Mercury.png")
    
    var _moveDist: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0)]
    
    var context: EAGLContext!
    
    let earthRadius: CGFloat! = 1.0
    let distanceAU: CGFloat! = 12.0
    let whScale: CGFloat! = 15.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.context = EAGLContext(API: EAGLRenderingAPI.OpenGLES1)
        let view = self.view as! GLKView
        view.context = self.context
        view.drawableDepthFormat = GLKViewDrawableDepthFormat.Format24
        view.delegate = self
        
        self.setupGL()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupGL() {
        
        EAGLContext.setCurrentContext(self.context)
        
        _earthTexture = ImageTexture(from:"earth.png")
        _sunTexture = ImageTexture(from:"Sun.png")
        _moontexture = ImageTexture(from: "moon.png")
        
        _venusTexture = ImageTexture(from:"Venus.png")
        _marsTexture = ImageTexture(from:"Mars.png")
        _mercuryTexture = ImageTexture(from: "Mercury.png")
        
        _sphereModel = SphereModel(16)  // earth
        _sun = SphereModel(16)  // sun
        _moon = SphereModel(16)
        _venus = SphereModel(16)  // earth
        _mars = SphereModel(16)  // sun
        _mercury = SphereModel(16)
        
        glEnable(GLenum(GL_CULL_FACE))
        glCullFace(GLenum(GL_BACK))
        
        glEnable(GLenum(GL_DEPTH_TEST))
        glDepthFunc(GLenum(GL_LEQUAL))
        
        /* Lighting code here below */
        glEnable(GLenum(GL_LIGHTING))
        glEnable(GLenum(GL_LIGHT0))
        
        let light0ambient: [GLfloat] = [1, 1, 1, 1.0]  // white
        let light0diffuse: [GLfloat] = [0.7, 0.7, 0.7, 1.0];
        let light0specular: [GLfloat] = [0.7, 0.7, 0.7, 1.0];
        let light0pos: [GLfloat] = [0, 0, 7, 1];  // 7 on the z axis
        
        glLightfv(GLenum(GL_LIGHT0), GLenum(GL_DIFFUSE), light0diffuse);
        glLightfv(GLenum(GL_LIGHT0), GLenum(GL_SPECULAR), light0specular);
        glLightfv(GLenum(GL_LIGHT0), GLenum(GL_POSITION), light0pos);
        glLightfv(GLenum(GL_LIGHT0), GLenum(GL_AMBIENT), light0ambient);
        
        _moveDist[0].x = 40
        _moveDist[0].y = 0
        _moveDist[1].x = 60
        _moveDist[1].y = 30
    
        glClearColor(0, 0, 0, 0)
        glClearDepthf(1)
        glClearColor(0.0, 0.0, 0.0, 0.0);
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    
    func setupOrthographicView(size:CGSize) {
    
        glViewport(0, 0, GLsizei(size.width), GLsizei(size.height))
        let Min = min(size.width, size.height)
        let width = whScale * size.width / Min
        let height = whScale * size.height / Min
        
        glMatrixMode(GLenum(GL_PROJECTION))
        glLoadIdentity()
        glOrthof(GLfloat(-width), GLfloat(width), GLfloat(-height), GLfloat(height), GLfloat(-2), GLfloat(2))
    }
    
    func update() {
        
        self.setupOrthographicView(self.view.bounds.size)
        _moveDist[0].x += CGFloat(self.timeSinceLastUpdate * 25)
        _moveDist[0].y += CGFloat(self.timeSinceLastUpdate * 25)
        
        _moveDist[1].x += CGFloat(self.timeSinceLastUpdate * 1)  // earth rotation speed
        _moveDist[1].y += CGFloat(self.timeSinceLastUpdate * 1)
        
        _moveDist[2].x += CGFloat( (1/0.0748) - self.timeSinceLastUpdate )// moon rotation speed
        _moveDist[2].y += CGFloat( (1/0.0748) - self.timeSinceLastUpdate )
        
        
        _moveDist[3].x +=  CGFloat( self.timeSinceLastUpdate * 25 * (1/0.615) ) // venus rotation speed
        _moveDist[3].y +=  CGFloat( self.timeSinceLastUpdate * 25 * (1/0.615) )
        
        _moveDist[4].x +=  CGFloat( self.timeSinceLastUpdate * 25 * (1/0.240) )  // mercury rotation speed
        _moveDist[4].y +=  CGFloat( self.timeSinceLastUpdate * 25 * (1/0.240) )
        
        _moveDist[5].x +=  CGFloat( self.timeSinceLastUpdate * 25 * (1/1.881) )   // mars rotation speed
        _moveDist[5].y +=  CGFloat( self.timeSinceLastUpdate * 25 * (1/1.881) )
    }
    
    override func glkView(view: GLKView, drawInRect rect: CGRect) {
    
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
        
        glMatrixMode(GLenum(GL_MODELVIEW))
        glLoadIdentity()
        
        glEnableClientState(GLenum(GL_VERTEX_ARRAY))
        glPushMatrix()
        
        glRotatef(GLfloat(_moveDist[0].y), 0, 0, 1);  // rotates an angle about the z axis
        glTranslatef(0, 0, 0);
        glRotatef(GLfloat(_moveDist[0].x), 0, 0, 1);
        glScalef(2, 2, 2);  // scaled by 2.0 (sun is not proportionately to scale with other planets)
        
        _sunTexture.bind()
        _sun?.drawOpenGLES1()
        glPopMatrix()
        
        glPushMatrix()
        glRotatef(GLfloat(_moveDist[1].y), 0.0, 0.0, 1.0);
        glTranslatef(0, GLfloat(distanceAU), 0);
        glRotatef(GLfloat(_moveDist[1].x), 0.0, 0.0, 1.0);
        glScalef(1, 1, 1); /* 1.2, 1.2 1.2 */
        
        glPushMatrix()   // moon drawing
        glRotatef(GLfloat(_moveDist[2].y), 0, 0, 1);
        glTranslatef(0,GLfloat(0.15 * distanceAU), 0);
        glRotatef(GLfloat(_moveDist[2].x), 0, 0, 1);
        glScalef(0.273, 0.273, 0.273);
        _moontexture.bind()
        _moon?.drawOpenGLES1()
        
        glPopMatrix();
        
        _earthTexture.bind()
        _sphereModel?.drawOpenGLES1()
        
        glPopMatrix();
        glPushMatrix();
        glRotatef(GLfloat(_moveDist[4].y), 0, 0, 1);
        glTranslatef(0, GLfloat(0.387 * distanceAU), 0);
        glRotatef(GLfloat(_moveDist[4].x), 0, 0, 1);
        glScalef(0.383, 0.383, 0.383);
        _mercuryTexture.bind();
        _mercury.drawOpenGLES1();
        
        glPopMatrix();
        glPushMatrix();   // venus drawing
        glRotatef(GLfloat(_moveDist[3].y), 0, 0, 1);
        glTranslatef(0, GLfloat(0.723 * distanceAU), 0);
        glRotatef(GLfloat(_moveDist[3].x), 0, 0, 1);
        glScalef(0.950, 0.950, 0.950);
        _venusTexture.bind();
        _venus.drawOpenGLES1();
        glPopMatrix();
    
        glPushMatrix();   // mars drawing
        glRotatef(GLfloat(_moveDist[5].y), 0, 0, 1);
        glTranslatef(0, GLfloat(1.524 * distanceAU), 0);
        glRotatef(GLfloat(_moveDist[5].x), 0, 0, 1);
        glScalef(0.532, 0.532, 0.532);
        _marsTexture.bind();
        _mars.drawOpenGLES1();
        glPopMatrix();
    }
    
}
