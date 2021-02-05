void keyPressed() {
  if (key == 'r') {
    setup();
  }
}

void handleInput() {
  if (mousePressed) {
    camPitch += map(mouseY-pmouseY, -height, height, 1, -1) * 1;
    camYaw   += map(mouseX-pmouseX, -width,  width,  1, -1) * 1;
  }
  
  if (keyPressed) {
    float speed = 0.1;
    float angleOffset = 0;
    switch (key) {
      case 'r':
        setup();
        break;
      case 'w':
        camPos.x += sin(camYaw) * speed;
        camPos.z += cos(camYaw) * speed;
        break;
      case 'a':
        camPos.x += sin(camYaw + angleOffset + PI / 2) * speed;
        camPos.z += cos(camYaw + angleOffset + PI / 2) * speed;
        break;
      case 'd':
        camPos.x += sin(camYaw + angleOffset - PI / 2) * speed;
        camPos.z += cos(camYaw + angleOffset - PI / 2) * speed;
        break;
      case 's':
        camPos.x += sin(camYaw + angleOffset + PI) * speed;
        camPos.z += cos(camYaw + angleOffset + PI) * speed;
        break;
      case ' ':
        camPos.y -= speed;
        break;
    }
    switch (keyCode) {
      case SHIFT:
        camPos.y += speed;
        break;
    }
  }
}
