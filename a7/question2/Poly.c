#include <stdlib.h>
#include <stdio.h>

struct Person_class {
	void* super;
	void (* toString) (void*);
};

struct Person {
	struct Person_class* class;
	char *name;
};

void Person_toString (void* this, char* buf, int bufSize) {
  snprintf (buf, bufSize, "Name: %s", ((struct Person*)this)->name);
}

struct Person_class Person_class_obj = { NULL, Person_toString };

struct Person* new_Person(char *name) {
	struct Person* obj = malloc (sizeof (struct Person));
	obj->class = &Person_class_obj;
	obj->name = name;
	return obj;	

}

/*
 * Class Student extends Person
 */

struct Student_class {
	struct Person_class* super;
	void (* toString);
};
struct Student {
	struct Student_class* class;
	char *name;
	int sid;
};

void Student_toString (void* this, char* buf, int bufSize) {
  snprintf (buf, bufSize, "Name: %s, SID: %d", ((struct Student*)this)->name, ((struct Student*)this)->sid);
 }

struct Student_class Student_class_obj = {
	&Person_class_obj, Student_toString
};

struct Student* new_Student(char *name, int sid) {
	struct Student* obj = malloc (sizeof (struct Student));
	obj->class = &Student_class_obj;
	obj->name = name;
	obj->sid = sid;
	return obj;	
}

/* 
Main
*/

void print (void* aVP) {
  struct Person* a = aVP;
  char *buf = malloc(sizeof(char)*1000);
  a->class->toString(a, buf, 1000);
  printf("%s\n", buf);
  free(buf);
}

int main (int argc, char** argv) {
  struct Person *people[2] = {new_Person("Alex"), (struct Person*)new_Student("Alice", 300)};
  int i = 0;
  for (i=0; i<2;i++) {
    print(people[i]);
  }
}

