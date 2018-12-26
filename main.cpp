#include "turing.h"


int main(int argc, char *args[]) {
	if (argc == 1)
		return 0;
	string dirStr(args[1]);
	string tmStr = dirStr + "/test.tm";
	string inStr = dirStr + "/input.txt";

	ifstream tm(tmStr, ios::in);
	ifstream in(inStr, ios::in);
	ofstream console(dirStr + "/console.txt", ios::out);
	ofstream result(dirStr + "/result.txt", ios::out);

	TuringMachine *turing = new TuringMachine(tm);
	turing->simulate(in, console, result);
	tm.close();
	in.close();
	console.close();
	result.close();
}
