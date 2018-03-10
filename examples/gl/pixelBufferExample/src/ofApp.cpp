#include "ofApp.h"
#include "ofConstants.h"

// this example will probably only work in real time in release mode

//--------------------------------------------------------------
void ofApp::setup() {
	fbo.allocate(ofGetWidth(), ofGetHeight(), GL_RGB);
	pixelBufferBack.allocate(ofGetWidth() * ofGetHeight() * 3, GL_DYNAMIC_READ);
	pixelBufferFront.allocate(ofGetWidth() * ofGetHeight() * 3, GL_DYNAMIC_READ);
	box.set(400);
	box.setResolution(1);
	box.setPosition(ofVec3f(ofGetWidth() * 0.5, ofGetHeight() * 0.5));
	record = false;
}

//--------------------------------------------------------------
void ofApp::update() {
	box.setOrientation(
	    ofQuaternion(45, ofVec3f(1, 0, 0), 45, ofVec3f(0, 0, 1), ofGetElapsedTimef() * 10, ofVec3f(0, 1, 0)));

	ofEnableDepthTest();
	fbo.begin();
	ofClear(0, 255);
	ofSetColor(100);
	box.setScale(1);
	box.draw();
	ofSetColor(255);
	box.setScale(1.001);
	box.drawWireframe();
	fbo.end();
	ofDisableDepthTest();

	if(record) {
		// copy the fbo texture to a buffer
		fbo.getTexture().copyTo(pixelBufferBack);

		// map the buffer so we can access it from the cpu
		// and wrap the memory in an ofPixels to save it
		// easily. Finally unmap it.
		pixelBufferFront.bind(GL_PIXEL_UNPACK_BUFFER);
		unsigned char *p = pixelBufferFront.map<unsigned char>(GL_READ_ONLY);
		pixels.setFromExternalPixels(p, fbo.getWidth(), fbo.getHeight(), OF_PIXELS_RGB);
		ofSaveImage(pixels, ofToString(ofGetFrameNum()) + ".jpg");
		pixelBufferFront.unmap();

		// swap the front and back buffer so we are always
		// copying the texture to one buffer and reading
		// back from another to avoid stalls
		swap(pixelBufferBack, pixelBufferFront);
	}
}

//--------------------------------------------------------------
void ofApp::draw() {
	ofSetColor(255);
	fbo.draw(0, 0);
	ofDrawBitmapString(ofGetFrameRate(), 20, 20);
	if(record) {
		ofDrawBitmapString("'r' toggles recording (on)", 20, 40);
	} else {
		ofDrawBitmapString("'r' toggles recording (off)", 20, 40);
	}
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
	if(key == 'r') {
		record = !record;
	}
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key) {}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) {}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button) {}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button) {}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y) {}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y) {}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h) {}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg) {}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo) {}
