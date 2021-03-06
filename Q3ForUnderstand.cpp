#include <stdio.h>
typedef struct HeapTag {
	int data[1000];
	int point;
	int length;
} Heap;

void swap(int a[], int x, int y) {
	int temp = a[x];
	a[x] = a[y];
	a[y] = temp;
}

/*void heapify(int a[], int left, int right) {
	int parent, child;
	for (parent = left; parent <= (right / 2); parent *= child) {
		child = parent * 2;
		if (child < right && a[child] > a[child + 1])
			child++;
		if (a[parent] > a[child])
			swap(a, parent, child);
	}
}*/

void heapsort(int a[], int left, int right) {
	int child;
	for (int x = right / 2; x > left - 1/* 0 */; x--) {
		for (int parent = x; parent <= (right / 2); parent = child) {
			child = parent * 2;
			if (child < right && a[child] > a[child + 1])
				child++;
			if (a[parent] > a[child])
				swap(a, parent, child);
		}
	}
}


bool checksort(int a[], int left, int right) {
	for (int x = 1; x < right; x++) {
		for (int y = x + 1; y <= right; y++) {
			if (a[x] < a[y])
				return false;
		}
	}
	return true;
}

void main() {
	Heap h1;
	h1.point = 1;
	h1.length = 1000;
	while (h1.point != h1.length) {
		int right = h1.point;
		int *a = h1.data;

		// scanf
		scanf_s("%d", &a[right]);

		/* make minheap
		for (int i = right / 2; i > 0; i--) {
			heapify(a, i, right);
		}*/
		heapsort(a, 1, right);

		// heapsort
		for (int i = right; i > 0; i--) {
			swap(a, 1, i);
			heapsort(a, 1, i - 1);

			/* make others heapify
			for (int x = i / 2; x > 0; x--) {
				heapify(a, x, i - 1);
			}*/
		}

		printf("\n");
		for (int i = 1; i <= h1.point; i++) {
			printf("%d  ", h1.data[i]);
		}
		printf("\n");
		
		bool check = checksort(a, 1, right);
		if (check)
			printf("true\n\n");
		else
			printf("false\n\n");

		h1.point++;
	}
}