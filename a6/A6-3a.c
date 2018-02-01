#include <stdio.h>

int c[] = {0,0,0,0,0,0,0,0,0,0};
int *d = c;

void MemoryX200(int a, int b) {
  d[b] += a;
}
void main() {
  int a = 1;
  int b = 2;
  MemoryX200(3, 4);
  MemoryX200(a,b);

  for (int i=0; i<10;i++) {
    printf("%d\n", c[i]);
  }
}
