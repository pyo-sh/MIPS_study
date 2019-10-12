#include <stdio.h>
#include <stdlib.h>

void noInverse(float Det) {
	if (Det == 0.0) {
		printf("Inverse matrix doesn't exist.");
		exit(1);
	}
}

void main() {
	int Array[3][3] = { { 1, 0, 5 },
						{ 1, 1, 0 },
						{ 3, 2, 6 } };
	float transp[3][3];

	int evenIndex = 1;
	int t0 = 0, t1 = 1, t2 = 2;

	for (int i = 0; i != 3; i++) {
		transp[i][0] = (float)( evenIndex * (( Array[1][t1] * Array[2][t2] ) 
									- ( Array[2][t1] * Array[1][t2] )));
		evenIndex = evenIndex * -1;

		transp[i][1] = (float)( evenIndex * (( Array[0][t1] * Array[2][t2] )
									- ( Array[2][t1] * Array[0][t2] )));
		evenIndex = evenIndex * -1;

		transp[i][2] = (float)( evenIndex * (( Array[0][t1] * Array[1][t2] )
									- ( Array[1][t1] * Array[0][t2] )));
		evenIndex = evenIndex * -1;
		t2 = t1 + 1;
		t1 = t0;
	}

	float Det = (( (float)Array[0][0] * transp[0][0])
				+ ( (float)Array[0][1] * transp[1][0] )
				+ ( (float)Array[0][2] * transp[2][0] ));
	noInverse(Det);

	printf("InverseArray\n");
	for (int i = 0; i != 9; i++) {
		transp[0][i] = transp[0][i] / Det;
		printf("%.1f", transp[0][i]);
		if (i % 3 == 2)
			printf("\n");
		else
			printf("\t");
	}
}