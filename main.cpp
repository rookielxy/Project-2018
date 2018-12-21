#include "turing.h"


int main(int argc, char *args[]) {
	if (argc == 1)
		return 0;
	string tmStr(args[1]);
	string inStr(args[2]);

	ifstream tm(tmStr, ios::in);
	ifstream in(inStr, ios::in);
	ofstream console("console.txt", ios::out);
	ofstream result("result.txt", ios::out);

	TuringMachine *turing = new TuringMachine(tm);
	turing->simulate(in, console, result);
	tm.close();
	in.close();
	console.close();
	result.close();
}