int w[] = {0,0,0,0};

int foo(int x, int y, int z) {
  void *jumps[] = {
    &&CASE10, 
    &&DEFAULT, 
    &&CASE12, 
    &&DEFAULT, 
    &&CASE14, 
    &&DEFAULT, 
    &&CASE16, 
    &&DEFAULT, 
    &&CASE18};
  if (x < 10 || x > 18) {
    goto DEFAULT;
  }
  goto *jumps[x-10];

CASE10:
  z += y;
  goto L7;

CASE12:
  z = -z+y;
  goto L7;

CASE14:
  if (y-z <= 0) { // 
    z = 0;
  } else {
    z = 1;
  }
  goto L7;

CASE16:
  if (z-y <= 0) {
    z = 0;
  } else {
    z = 1;
  }
  goto L7;

CASE18:
  if (z == y) {
    z = 1;
  } else {
    z = 0;
  }
  goto L7;

DEFAULT:
  z = 0;
  goto L7;

L7:
  return z;
}
void main() {
  w[3] = foo(w[0], w[1], w[2]);
}