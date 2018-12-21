#include "turing.h"

TuringMachine::TuringMachine(istream &tm):tm(tm) {
	string line;
	while(getline(tm, line)) {
		clearComment(line);
		if (line.empty())
			continue;
		if (line[0] == '#') {
			switch (line[1]) {
				case 'Q': {
					assert(line[5] == '{' and line.back() == '}');
					int pos = 6, len = 0;
					while (pos < line.size()) {
						while (pos + len < line.size() and line[pos + len] != ',' and line[pos + len] != '}')
							++len;
						
						State newState;
						newState.id = line.substr(pos, len);
						states.emplace(newState.id, newState);

						pos += len + 1;
						len = 0;
					}
					break;
				}
				case 'S': {
					assert(line[5] == '{' and line.back() == '}');
					int pos = 6;
					while (pos < line.size()) {
						char ch = line[pos];
						characters.emplace(ch);
						pos += 2;
					}
					break;
				}
				case 'T': {
					assert(line[5] == '{' and line.back() == '}');
					int pos = 6;
					while (pos < line.size()) {
						char ch = line[pos];
						validWrite.emplace(ch);
						pos += 2;
					}
					break;
				}
				case 'q': {
					start = line.substr(6, string::npos);
					map<string, State>::iterator it = states.find(start);
					it->second.start = true;
					break;
				}
				case 'F': {
					assert(line[5] == '{' and line.back() == '}');
					int pos = 6, len = 0;
					while (pos < line.size()) {
						while (pos + len < line.size() and line[pos + len] != ',' and line[pos + len] != '}')
							++len;
						
						string id = line.substr(pos, len);
						map<string, State>::iterator it = states.find(id);
						it->second.halt = true;

						pos += len + 1;
						len = 0;
					}
					break;
				}
				case 'B': blank = line[5]; break;
				default: assert(false);
			}
		} else {
			stringstream ss;
			ss << line;
			Action action;
			string old;
			char dir;
			ss >> old >> action.symbol >> action.write >> dir >> action.next;
			assert(validWrite.find(action.write) != validWrite.end() or action.write == '*');
			switch (dir) {
				case 'r': action.direction = RIGHT; break;
				case 'l': action.direction = LEFT; break;
				case '*': action.direction = STAY; break;
				default: assert(false);
			}
			map<string, State>::iterator it = states.find(old);
			assert(it != states.end());
			it->second.rule.emplace(action.symbol, action);
		}
	}
}

void TuringMachine::clearComment(string &line) {
	auto it = line.begin();
	for (; it != line.end(); ++it) {
		if (*it == ';')
			break;
	}
	if (it == line.end())
		return;
	line.erase(it, line.end());
}

void TuringMachine::simulate(istream &in, ostream &console, ostream &result) {
	string line;
	while (getline(in, line))
		simulate(line, console, result);
}

void TuringMachine::simulate(const string &line, ostream &console, ostream &result) {
	console << "Input: " << line << endl;
	if (not legalInput(line)) {
		console << "==================== ERR ====================" << endl;
		console << "The input \"" << line << "\" is illegal" << endl;
		result << "Error" << endl;
	} else {
		list<Cell> tape;
		if (line.empty()) {
			Cell cell;
			cell.index = 0;
			cell.content = blank;
			tape.push_back(cell);
		} else {
			for (int i = 0; i < line.size(); ++i) {
				Cell cell;
				cell.index = i;
				cell.content = line[i];
				tape.push_back(cell);
			}
		}

		int step = 0;
		map<string, State>::iterator it = states.find(start);
		list<Cell>::iterator head = tape.begin();

		while (true) {
			printStep(console, it->second, step, tape, head);

			char content = head->content;
			if (it->second.halt) {
				result << "True" << endl;
				break;
			}
			map<char, Action>::iterator actionIt = it->second.rule.find(content);
			if (actionIt == it->second.rule.end()) {
				actionIt = it->second.rule.find('*');
				if (actionIt == it->second.rule.end()) {
					result << "False" << endl;
					break;
				}
			}
			if (actionIt->second.write != '*')
				head->content = actionIt->second.write;
			switch (actionIt->second.direction) {
				case RIGHT: {
					if (head == --tape.end() and head == tape.begin() and head->content == blank) {
						Cell cell;
						cell.index = tape.back().index + 1;
						cell.content = blank;
						tape.push_back(cell);
						++head;
						tape.pop_front();
					} else if (head == --tape.end() ) {
						Cell cell;
						cell.index = tape.back().index + 1;
						cell.content = blank;
						tape.push_back(cell);
						++head;
					} else if (head == tape.begin() and head->content == blank) {
						++head;
						tape.pop_front();
					} else {
						++head;
					}
					break;
				}
				case LEFT: {
					if (head == tape.begin() and head == --tape.end() and head->content == blank) {
						Cell cell;
						cell.index = tape.front().index - 1;
						cell.content = blank;
						tape.push_front(cell);
						--head;
						tape.pop_back();
					} else if (head == tape.begin()) {
						Cell cell;
						cell.index = tape.front().index - 1;
						cell.content = blank;
						tape.push_front(cell);
						--head;
					} else if (head == --tape.end() and head->content == blank) {
						--head;
						tape.pop_back();
					} else {
						--head;
					}
					break;
				}
				case STAY: break;
				default: assert(false);
			}
			it = states.find(actionIt->second.next);
			assert(it != states.end());
			++step;
		}
		console << "Result: ";
		for (list<Cell>::iterator it = tape.begin(); it != tape.end(); ++it)
			console << it->content;
		console << endl;
	}
	console << "==================== END ====================" << endl;
}

bool TuringMachine::legalInput(const string &line) {
	for (auto ch : line) {
		if (characters.find(ch) == characters.end())
			return false;
	}
	return true;
}


void TuringMachine::printStep(ostream &console, const State &state, int step, 
			list<Cell> &tape, const list<Cell>::iterator it) {
	int offset = 0;
	console << "Step  : " << step << endl
			<< "Index : ";
	for (list<Cell>::iterator it = tape.begin(); it != tape.end(); ++it) {
		it->offset = offset;
		offset += to_string(abs(it->index)).size() + 1;
		console << abs(it->index) << " ";
	}
	console << endl;
	offset = 0;
	console << "Tape  : ";
	for (list<Cell>::iterator it = tape.begin(); it != tape.end();) {
		console << it->content;
		++offset;
		++it;
		if (it == tape.end()) {
			console << endl;
			break;
		}
		while (offset < it->offset) {
			console << " ";
			++offset;
		}
	}
	console << "Head  : ";
	for (int i = 0; i < it->offset; ++i)
		console << " ";
	console << "^" << endl;
	console << "State : " << state.id << endl;
	console << "---------------------------------------------" << endl;
}