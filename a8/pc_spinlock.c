#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "spinlock.h"
#include "uthread.h"

#define MAX_ITEMS 10

int items = 0;

const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

spinlock_t lock;

int producer_wait_count;     // # of times producer had to wait
int consumer_wait_count;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items


void produce() {
  // TODO ensure proper synchronization
  spinlock_lock (&lock);
  while(items >= MAX_ITEMS) {
      producer_wait_count++;
      spinlock_unlock(&lock);
      uthread_yield();
      spinlock_lock(&lock);
    }
  assert (items < MAX_ITEMS);
  items++;
  histogram [items] += 1;
  spinlock_unlock(&lock);
}

void consume() {
  // TODO ensure proper synchronization
  spinlock_lock (&lock);
  while(items == 0) {
      consumer_wait_count++;
      spinlock_unlock(&lock);
      uthread_yield();
      spinlock_lock(&lock);
    }
  assert (items > 0);
  items--;
  histogram [items] += 1;
  spinlock_unlock (&lock);
}

void *producer(void *nothing) {
  // TODO - You might have to change this procedure slightly
  for (int i=0; i < NUM_ITERATIONS; i++) {
      produce();
  }
  return NULL;
}

void *consumer(void *nothing) {
  // TODO - You might have to change this procedure slightly
  for (int i=0; i< NUM_ITERATIONS; i++) {
      consume();
  }
  return NULL;
}

int main (int argc, char** argv) {
  uthread_init(4);
  spinlock_create(&lock);
  uthread_t producer_threads[NUM_PRODUCERS];
  uthread_t consumer_threads[NUM_CONSUMERS];

  // TODO create threads to run the producers and consumers

  for (int i=0; i< NUM_PRODUCERS; i++) {
    producer_threads[i] = uthread_create(&producer, NULL);
  }
  for (int i=0; i< NUM_CONSUMERS; i++) {
    consumer_threads[i] = uthread_create(&consumer, NULL);
  }

  for (int i=0; i< NUM_PRODUCERS; i++) {
    uthread_join(producer_threads[i], NULL);
  }
  for (int i=0; i< NUM_CONSUMERS; i++) {
    uthread_join(consumer_threads[i], NULL);
  }

  printf("Producer wait: %d\nConsumer wait: %d\n",
         producer_wait_count, consumer_wait_count);
  for(int i=0;i<MAX_ITEMS+1;i++)
    printf("items %d count %d\n", i, histogram[i]);
}