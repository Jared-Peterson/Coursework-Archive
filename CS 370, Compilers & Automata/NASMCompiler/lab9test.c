int a;
int b;
int c;
int x[4];
void main(void){
	int d;
	int e;
	
	write "testing read";
	read e;
	write "you entered";
	write e;
	
	write "testing write";
	a=1;
	b=2;
	c=3;
	write "a:";
	write a;
	write "b:";
	write b;
	write "c:";
	write c;

	write "testing expressions";
	write "a + b = ";
	write a + b;
	write "c - b = ";
	write c - b;
	write "b * c = ";
	write b * c;
	write "c / a = ";
	write c / a;

	write "testing while";
	d = 0;
	while(d<3){
		write "d:";
		write d;
		d = d + 1;
	}
	
	write "testing operators with if";
	if(a < b){
		write "a is less than b";
	}
	if(b < a){
		write "b is less than a";
	}
	if(a > b){
		write "a is greater than b";
	}
	if(b > a){
		write "b is greater than a";
	}
	if(a <= b){
		write "a is less than or equal to b";
	}
	if(b <= a){
		write "b is less than or equal to a";
	}
	if(a >= b){
		write "a is greater than or equal to b";
	}
	if(b >= a){
		write "b is greater than or equal to a";
	}
	if(a == b){
		write "a is equal to b";
	}
	if(a != b){
		write "a is not equal to b";
	}

	write "testing else";
	if(a == b){
		write "a is equal to b";
	}
	else{
		write "a is not equal to b";
	}
	if(a == 1){
		if(b==2){
			write "in nested if";
		}
	}

	write "testing arrays";
	x[0] = 1;
	x[1] = 2;
	x[2] = 3;
	x[3] = 0;
	write "should print 1";
	write x[x[x[x[1]]]];
	write x[1] * x[2];

}
