#include <stdio.h>

#define DATA_SIZE 5
int Heap[DATA_SIZE];

void heapsort(int first, int last) {
	int t0 = first + 1;
	int t1 = last + 1;
	int child;
	for (int t3 = ( t1 / 2 ); 0 < t3 ; t3--) {
		for (int parent = t3; parent <= (t1 / 2); parent = child) {
			child = parent * 2;
			if (child < t1 && Heap[child - 1] > Heap[child])
				child++;
			if (Heap[parent - 1] > Heap[child - 1]) {
				int t7 = Heap[parent - 1];
				int t8 = Heap[child - 1];
				Heap[parent - 1] = t8;
				Heap[child - 1] = t7;
			}
		}
	}
}

void printArray(int last) {
	for (int i = 0; i != last + 1; i++) {
		printf("\t%d", Heap[i]);
	}
}

void main() {
	int point = 0;
	while (point != DATA_SIZE) {
		printf("Type the Number : ");
		scanf_s("%d", &Heap[point]);

		heapsort(0, point);

		for (int i = point; i != 0; i--) {
			int s4 = Heap[0];
			int s5 = Heap[i];
			Heap[0] = s5;
			Heap[i] = s4;
			heapsort(0, i - 1);
		}
		printf("sorted Array : ");
		printArray(point);
		point++;
		printf("\n");
	}
	printf("Array is full.\n ----- finished ----- \n");
}