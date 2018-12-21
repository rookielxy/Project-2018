#ifndef __TURING__
#define __TURING__

#include "common.h"

enum Direction {RIGHT, LEFT, STAY};

struct Action {
	string next;
	char symbol;
	char write;
	enum Direction direction;
};

struct Cell {
	int index;
	char content;
	int offset;
};

class State {
	friend class TuringMachine;
	string id;
	bool start;
	bool halt;
	map<char, Action> rule;
};

class TuringMachine {
private:
	istream &tm;

	map<string, State> states;
	string start;
	set<char> characters;
	set<char> validWrite;
	char blank;
public:
	TuringMachine(istream &tm);
	static void clearComment(string &line);
	void simulate(istream &in, ostream &console, ostream &result);
	void simulate(const string &line, ostream &console, ostream &result);
	bool legalInput(const string &line);
	void printStep(ostream &console, const State &state, int step, 
				list<Cell> &tape, const list<Cell>::iterator it);
};

#endif