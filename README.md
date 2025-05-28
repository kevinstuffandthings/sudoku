# Sudoku Solver

I wanted to play with code (it's been a while), so I wrote this [Sudoku](https://en.wikipedia.org/wiki/Sudoku) solver in Ruby.

## Usage

### Set up the puzzle to be solved
First, create a text file that represents the unsolved puzzle. It should be a nine-by-nine grid of numbers, with a `.` (or blank) in place of each unknown number:

```text
...5.1...
.....2..1
95.......
1...2.98.
..4.7.1..
8......4.
5....48..
39....5..
...3...27
```

Save this file somewhere conveniently accessed. For our purposes, the file will be called "`/Users/kevin/Desktop/unsolved-puzzle.txt`"

### Run the solver rake task
From your command line, run the `sudoku:solve` rake task with your file name as its sole parameter:

```bash
$ rake "sudoku:solve[/Users/kevin/Desktop/unsolved-puzzle.txt]"
```

The code will run through a series of solution strategies until the puzzle is solved.

### Examine your output
Your solved puzzle will be displayed. Note that when running via a terminal, the initial "seed" values will be highlighted.

```
┌───┬───┬───┐
│   │5 1│   │
│   │  2│  1│
│95 │   │   │
├───┼───┼───┤
│1  │ 2 │98 │
│  4│ 7 │1  │
│8  │   │ 4 │
├───┼───┼───┤
│5  │  4│8  │
│39 │   │5  │
│   │3  │ 27│
└───┴───┴───┘

HiddenSingle: exclusive assignment within row for [8,2 (B3,1)] -> 5
HiddenSingle: exclusive assignment within row for [3,3 (B1,1)] -> 1
HiddenSingle: exclusive assignment within row for [4,4 (B2,2)] -> 4
HiddenSingle: exclusive assignment within row for [9,8 (B3,3)] -> 4
HiddenSingle: exclusive assignment within column for [3,6 (B1,2)] -> 9
HiddenSingle: exclusive assignment within block for [3,4 (B1,2)] -> 5
HiddenSingle: exclusive assignment within block for [7,6 (B3,2)] -> 7
HiddenPair: reducing notes within row from [6, 8, 9] for [4,5 (B2,2)] -> [8, 9]
HiddenPair: reducing notes within row from [3, 5, 6, 8, 9] for [6,5 (B2,2)] -> [8, 9]
HiddenPair: reducing notes within row from [1, 5, 6, 8, 9] for [5,9 (B2,3)] -> [5, 9]
HiddenPair: reducing notes within row from [5, 6, 8, 9] for [6,9 (B2,3)] -> [5, 9]
HiddenPair: reducing notes within block from [2, 3, 5, 6] for [9,5 (B3,2)] -> [2, 5]
HiddenPair: reducing notes within block from [2, 3, 5, 6] for [9,6 (B3,2)] -> [2, 5]
HiddenPair: reducing notes within block from [1, 3, 6, 9] for [8,7 (B3,3)] -> [3, 9]
HiddenPair: reducing notes within block from [3, 6, 9] for [9,7 (B3,3)] -> [3, 9]
NakedPair: reducing notes within row from [1, 2, 6, 7, 9] for [4,7 (B2,3)] -> [1, 2, 6, 7]
NakedPair: reducing notes within row from [1, 6, 9] for [5,7 (B2,3)] -> [1, 6]
NakedPair: reducing notes within column from [2, 3, 6, 8, 9] for [9,1 (B3,1)] -> [3, 6, 8, 9]
NakedPair: reducing notes within column from [2, 3, 6, 8] for [9,3 (B3,1)] -> [3, 6, 8]
PointingPair: reducing notes within row from [2, 3, 4, 6] for [7,1 (B3,1)] -> [3, 4, 6]
PointingPair: reducing notes within row from [3, 4, 6, 8, 9] for [5,1 (B2,1)] -> [3, 4, 6, 8]
PointingPair: reducing notes within column from [2, 3, 4, 6, 7, 8] for [2,1 (B1,1)] -> [2, 4, 6, 7, 8]
PointingPair: reducing notes within column from [3, 4, 6, 7, 8] for [2,2 (B1,1)] -> [4, 6, 7, 8]
PointingPair: reducing notes within row from [2, 5] for [9,6 (B3,2)] -> [2]
PointingPair: reducing notes within row from [2, 6, 7, 8] for [3,8 (B1,3)] -> [2, 6, 7]
HiddenSingle: exclusive assignment within row for [7,3 (B3,1)] -> 2
HiddenSingle: exclusive assignment within row for [2,4 (B1,2)] -> 7
HiddenSingle: exclusive assignment within row for [9,5 (B3,2)] -> 5
HiddenSingle: exclusive assignment within row for [2,9 (B1,3)] -> 1
HiddenSingle: exclusive assignment within column for [8,8 (B3,3)] -> 1
HiddenSingle: exclusive assignment within column for [9,6 (B3,2)] -> 2
HiddenSingle: exclusive assignment within block for [1,9 (B1,3)] -> 4
HiddenSingle: exclusive assignment within block for [3,9 (B1,3)] -> 8
HiddenSingle: exclusive assignment within block for [7,9 (B3,3)] -> 6
HiddenPair: reducing notes within column from [2, 4, 6, 8] for [2,1 (B1,1)] -> [4, 8]
HiddenPair: reducing notes within column from [4, 6, 8] for [2,2 (B1,1)] -> [4, 8]
NakedPair: reducing notes within block from [3, 6, 7, 9] for [8,1 (B3,1)] -> [6, 7, 9]
NakedPair: reducing notes within block from [3, 6, 8, 9] for [9,1 (B3,1)] -> [6, 8, 9]
NakedPair: reducing notes within block from [3, 6, 7] for [8,3 (B3,1)] -> [6, 7]
NakedPair: reducing notes within block from [3, 6, 8] for [9,3 (B3,1)] -> [6, 8]
PointingPair: reducing notes within column from [2, 3, 6, 7] for [3,1 (B1,1)] -> [2, 3, 6]
PointingPair: reducing notes within column from [3, 6, 7] for [3,2 (B1,1)] -> [3, 6]
HiddenSingle: exclusive assignment within row for [5,3 (B2,1)] -> 4
HiddenSingle: exclusive assignment within row for [6,3 (B2,1)] -> 3
HiddenSingle: exclusive assignment within row for [9,4 (B3,2)] -> 3
HiddenSingle: exclusive assignment within row for [2,5 (B1,2)] -> 3
HiddenSingle: exclusive assignment within row for [5,6 (B2,2)] -> 3
HiddenSingle: exclusive assignment within row for [8,7 (B3,3)] -> 3
HiddenSingle: exclusive assignment within column for [2,7 (B1,3)] -> 2
HiddenSingle: exclusive assignment within column for [3,1 (B1,1)] -> 2
HiddenSingle: exclusive assignment within column for [4,8 (B2,3)] -> 2
HiddenSingle: exclusive assignment within column for [5,7 (B2,3)] -> 1
HiddenSingle: exclusive assignment within column for [5,9 (B2,3)] -> 5
HiddenSingle: exclusive assignment within column for [6,6 (B2,2)] -> 5
HiddenSingle: exclusive assignment within column for [6,8 (B2,3)] -> 7
HiddenSingle: exclusive assignment within column for [8,1 (B3,1)] -> 9
HiddenSingle: exclusive assignment within column for [9,7 (B3,3)] -> 9
HiddenSingle: exclusive assignment within block for [3,2 (B1,1)] -> 3
HiddenSingle: exclusive assignment within block for [7,1 (B3,1)] -> 3
HiddenSingle: exclusive assignment within block for [8,3 (B3,1)] -> 7
HiddenSingle: exclusive assignment within block for [1,5 (B1,2)] -> 2
HiddenSingle: exclusive assignment within block for [4,6 (B2,2)] -> 1
HiddenSingle: exclusive assignment within block for [8,5 (B3,2)] -> 6
HiddenSingle: exclusive assignment within block for [3,7 (B1,3)] -> 7
HiddenSingle: exclusive assignment within block for [5,8 (B2,3)] -> 8
HiddenSingle: exclusive assignment within block for [6,9 (B2,3)] -> 9
PointingPair: reducing notes within column from [8, 9] for [4,5 (B2,2)] -> [9]
HiddenSingle: exclusive assignment within row for [2,1 (B1,1)] -> 4
HiddenSingle: exclusive assignment within row for [1,1 (B1,1)] -> 7
HiddenSingle: exclusive assignment within row for [7,2 (B3,1)] -> 4
HiddenSingle: exclusive assignment within row for [4,2 (B2,1)] -> 7
HiddenSingle: exclusive assignment within row for [6,4 (B2,2)] -> 6
HiddenSingle: exclusive assignment within row for [6,5 (B2,2)] -> 8
HiddenSingle: exclusive assignment within row for [4,5 (B2,2)] -> 9
HiddenSingle: exclusive assignment within row for [2,6 (B1,2)] -> 6
HiddenSingle: exclusive assignment within row for [4,7 (B2,3)] -> 6
HiddenSingle: exclusive assignment within row for [3,8 (B1,3)] -> 6
HiddenSingle: exclusive assignment within column for [1,2 (B1,1)] -> 6
HiddenSingle: exclusive assignment within column for [2,2 (B1,1)] -> 8
HiddenSingle: exclusive assignment within column for [4,3 (B2,1)] -> 8
HiddenSingle: exclusive assignment within column for [5,1 (B2,1)] -> 6
HiddenSingle: exclusive assignment within column for [5,2 (B2,1)] -> 9
HiddenSingle: exclusive assignment within column for [9,3 (B3,1)] -> 6
HiddenSingle: exclusive assignment within column for [9,1 (B3,1)] -> 8

┌───┬───┬───┐
│742│561│398│
│683│792│451│
│951│843│276│
├───┼───┼───┤
│175│426│983│
│234│978│165│
│869│135│742│
├───┼───┼───┤
│527│614│839│
│396│287│514│
│418│359│627│
└───┴───┴───┘
Solver spent 0.011739s
```