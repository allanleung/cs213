#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "uthread.h"
#include "uthread_sem.h"

#define MAX_ITEMS 10
const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int producer_wait_count;     // # of times producer had to wait
int consumer_wait_count;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

struct Pool {
  // TODO
  uthread_sem_t lock;
  uthread_sem_t notFull;
  uthread_sem_t notEmpty;
  int           items;
};

struct Pool* createPool() {
  struct Pool* pool = malloc (sizeof (struct Pool));
  // TODO
  pool->lock = uthread_sem_create(1);            // this is a mutex
  pool->notEmpty = uthread_sem_create(0);        // this is not a mutx, because it go pass 1
  pool->notFull = uthread_sem_create(MAX_ITEMS); // this is not a mutx, because it go pass 1
  pool->items     = 0;
  return pool;
}

void* producer (void* pv) {
  struct Pool* p = pv;

  // TODO
  for (int i=0; i<NUM_ITERATIONS; i++) {
    uthread_sem_wait(p->notFull);     // tell me when i have space, wait until its not full

    uthread_sem_wait(p->lock);        // the one way for it to run when its not FULL
    p->items++;                       // i have space, add some stuff
    histogram [p->items] += 1;
    assert(p->items <= MAX_ITEMS);
    uthread_sem_signal(p->lock);      // this signal the lock

    uthread_sem_signal(p->notEmpty);  // telling consumer there is space
  }

  return NULL;
}

void* consumer (void* pv) {
  struct Pool* p = pv;
  
  // TODO
  for (int i=0; i<NUM_ITERATIONS; i++) {
    uthread_sem_wait(p->notEmpty);      // tell me when i have item to eat

    uthread_sem_wait(p->lock);          // 
    p->items--;                         // i have space, add some stuff
    histogram [p->items] += 1;
    assert(p->items <= MAX_ITEMS);      //
    uthread_sem_signal(p->lock);        // signal add 1 to lock, so it locks the damn thing

    uthread_sem_signal(p->notFull);     // tell producer there is space, make some stuff
  }
  return NULL;
}

int main (int argc, char** argv) {
  uthread_t t[4];

  uthread_init (4);
  struct Pool* p = createPool();
  
  // TODO
  uthread_t producer_threads[NUM_PRODUCERS];
  uthread_t consumer_threads[NUM_CONSUMERS];

  for (int i=0; i< NUM_PRODUCERS; i++) {
    producer_threads[i] = uthread_create(&producer, p);
  }

  for (int i=0; i< NUM_CONSUMERS; i++) {
    consumer_threads[i] = uthread_create(&consumer, p);
  }

  for (int i=0; i< NUM_PRODUCERS; i++) {
    uthread_join(producer_threads[i], NULL);
  }
  for (int i=0; i< NUM_CONSUMERS; i++) {
    uthread_join(consumer_threads[i], NULL);
  }
  
  printf ("producer_wait_count=%d, consumer_wait_count=%d\n", producer_wait_count, consumer_wait_count);
  printf ("items value histogram:\n");
  int sum=0;
  for (int i = 0; i <= MAX_ITEMS; i++) {
    printf ("  items=%d, %d times\n", i, histogram [i]);
    sum += histogram [i];
  }
  assert (sum == sizeof (t) / sizeof (uthread_t) * NUM_ITERATIONS);
}