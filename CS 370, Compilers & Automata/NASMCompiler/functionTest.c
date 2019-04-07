int foo(void){
	return 1;
}

void main(void){
	int a[5];
	a[1]=0;
	a[foo()] = 3;
	write a[1];
}
