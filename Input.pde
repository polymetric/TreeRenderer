void handleInput() {
  camPitch = map(mouseY, 0, height, 4, -4);
  camYaw = map(mouseX,   0, width,  4, -4);
  
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
