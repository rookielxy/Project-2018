# PTC (Fall 2018) — Project

## 1. 任务描述
### 基本要求
1. 参考 *Section 2* 中的图灵机语法描述，实现一个标准图灵机（确定性、双向无限纸带）程序解析器。该解析器能够读入并解析符合语法描述的图灵机程序。
2. 经过解析器解析后的图灵机程序，能够读入一段字符串作为图灵机的输入，运行后给出相应的输出。
3. 使用 *Section 2* 中的图灵机语法，实现 *Assignment 3* 中的图灵机，使用你实现的图灵机程序解析器进行解析并运行。
4. 按以下格式给出图灵机的每一次移动时，纸带上的状态以及相应的读写头的位置。
    ```
    Step  : 0
    Index : 0 1 2 3 4 5 6
    Tape  : 1 0 0 1 0 0 1
    Head  : ^
    State : 0

    Step  : 1
    Index : 0 1 2 3 4 5 6
    Tape  : _ 0 0 1 0 0 1
    Head  :   ^
    State : li

    Step  : 2
    Index : 0 1 2 3 4 5 6
    Tape  : _ 0 0 1 0 0 1
    Head  :     ^
    State : li

    ......
    ```
    > 注：1. Index中的0表示初始时纸带上包含输入的最左单元的索引位置；2. 若需要向0索引左边的纸带单元中读写字符，请在Index中按照“... 3 2 1 0 1 2 3 ...”的格式（也即省略了-3 -2 -1等负索引的负号）来进行描述。 
5. 编程语言：Java 8

### 选做要求
1. 实现更多图灵机程序。

2. 实现多道、多带、非确定性等变体图灵机程序解析器。

## 2. 语法描述
### 基本语法
- Each line should contain one tuple of the form '< current state > < current symbol > < new symbol > < direction > < new state >'.
- You can use any number or word for < current state > and < new state >, eg. 10, a, state1. State labels are case-sensitive.
- You can use any character for < current symbol > and < new symbol >, or '_' to represent blank (space). Symbols are case-sensitive.
- < direction > should be 'l', 'r' or '*', denoting 'move left', 'move right' or 'do not move', respectively.
- Anything after a ';' is a comment and is ignored.
- The machine halts when it reaches any state starting with 'halt', eg. halt, halt-accept.

### 进阶语法
- '*' can be used as a wildcard in < current symbol > or < current state > to match any character or state.
- '*' can be used in < new symbol > or < new state > to mean 'no change'.
- You can specify the starting position for the head using '*' in the initial input.

## 图灵机示例 
参见 [`palindrome_detector.tm`](./examples/palindrome_detector.tm)