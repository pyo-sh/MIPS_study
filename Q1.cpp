#include <stdio.h>

void print(int a1, int a2, int a3) {
	printf("%d\t%d\t%d\t", a1, a2, a3);
}

void main() {
	int Array[3][3] = { {1,2,3}, 
						{4,5,6},
						{7,8,9} };
	int x[3] = {1,
				2,
				3};
	int result[3];

	for (int i = 0; i < 3; i++) {
		print(Array[i][0], Array[i][1], Array[i][2]);
		printf("%d\t", x[i]);
		result[i] = Array[i][0] * x[0] + Array[i][1] * x[1] + Array[i][2] * x[2];
		printf("%d\t\n", result[i]);
	}
}

