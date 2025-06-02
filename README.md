# Sudoku Solver
I wanted to play with code (it's been a while), so I wrote this [Sudoku](https://en.wikipedia.org/wiki/Sudoku) solver in Ruby.

## Algorithm
I recently started playing the Sudoku puzzles that come with my Apple News subscription. In their game's implementation, there's a hint feature that does a nice job of explaining why you should make the decision it's trying to get you to make. So I genericized and then codified those hints into different solvers.

Before any real solving can be done, we run through a `NoteGenerator` that crudely fills in all possible notes for each cell (based purely on row/column/block exclusion). Once that's done, the subsequent steps either use notes to determine values, or use other notes to narrow their own notes (until a value can be determined somewhere). The notes get generated only once, but the subsequent steps are iterated repeatedly until either the puzzle is solved, or no progress is being made. The latter would be indicative of either a poorly-formed puzzle, or a bug in this program.

_Note that "group" refers to either a row, column, or block._

### `HiddenSingle`
A cell has a note that is not present in any other one of its group members' notes, so it should be taken as the value for that cell.
![Hidden Single](.readme/HiddenSingle.png)

### `HiddenPair`
Two cells within a group are the only ones containing a pair of numbers, so other numbers can be removed from those cells' notes.
![Hidden Pair](.readme/HiddenPair.png)

### `NakedPair`
Two squares contain exactly 2 identical numbers within a group, so those numbers can be removed from other groupmates' notes.
![Naked Pair](.readme/NakedPair.png)

### `PointingPair`
2 (or more) squares contained in a single row/column within a block have an exclusive note, so all other squares within that row/column (outside that block) should remove the note.
![Pointing Pair](.readme/PointingPair.png)

### `HiddenTriplet`
Three cells within a group are the only ones containing a trio of numbers, where each cell contains at least 2 of those 3 numbers. When this occurs, those numbers can be removed from groupmates' notes.
![Hidden Triplet](.readme/HiddenTriplet.png)

### `ClaimingTriplet` (rare)
3 cells within a block row contain a singular value not found in that row outside the block, so that singular value can be removed from the remainder of the block.
![Claiming Triplet](.readme/ClaimingTriplet.png)

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
Your solved puzzle will be displayed. Note that when running via a terminal, the initial "seed" values will be bolded.

```
┌───┬───┬───┐
│  3│  6│8  │
│9  │  3│   │
│ 8 │ 45│6  │
├───┼───┼───┤
│   │   │4  │
│6 5│   │   │
│3 1│   │ 5 │
├───┼───┼───┤
│   │ 8 │  4│
│8  │ 6 │9  │
│  4│79 │  5│
└───┴───┴───┘

INFO: HiddenSingle: exclusive assignment within row for C[4,2] -> 8
INFO: HiddenSingle: exclusive assignment within row for C[8,9] -> 8
INFO: HiddenSingle: exclusive assignment within column for C[1,1] -> 4
INFO: HiddenSingle: exclusive assignment within column for C[3,4] -> 8
INFO: HiddenSingle: exclusive assignment within column for C[5,4] -> 5
INFO: HiddenSingle: exclusive assignment within column for C[7,2] -> 5
INFO: HiddenSingle: exclusive assignment within column for C[8,2] -> 4
INFO: HiddenSingle: exclusive assignment within block for C[2,1] -> 5
INFO: HiddenSingle: exclusive assignment within block for C[1,7] -> 5
INFO: HiddenSingle: exclusive assignment within block for C[4,8] -> 5
INFO: HiddenSingle: exclusive assignment within block for C[8,7] -> 6
INFO: PointingPair: reducing notes within column from [1, 2, 3, 7] for C[5,5] -> [1, 2, 3]
INFO: PointingPair: reducing notes within column from [2, 7] for C[5,6] -> [2]
INFO: PointingPair: reducing notes within column from [1, 2, 3, 6, 9] for C[4,4] -> [1, 2, 3, 6]
INFO: PointingPair: reducing notes within column from [1, 2, 3, 4, 9] for C[4,5] -> [1, 2, 3, 4]
INFO: PointingPair: reducing notes within column from [2, 4, 6, 9] for C[4,6] -> [2, 4, 6]
INFO: PointingPair: reducing notes within column from [1, 2, 3, 7, 9] for C[2,7] -> [1, 2, 3, 7]
INFO: HiddenSingle: exclusive assignment within row for C[3,7] -> 9
INFO: HiddenSingle: exclusive assignment within row for C[6,8] -> 4
INFO: HiddenSingle: exclusive assignment within row for C[2,9] -> 6
INFO: HiddenSingle: exclusive assignment within column for C[3,2] -> 6
INFO: HiddenSingle: exclusive assignment within column for C[5,5] -> 3
INFO: HiddenSingle: exclusive assignment within block for C[4,7] -> 3
INFO: HiddenPair: reducing notes within column from [1, 2, 7] for C[5,1] -> [1, 7]
INFO: HiddenPair: reducing notes within column from [1, 2, 7] for C[5,2] -> [1, 7]
INFO: HiddenPair: reducing notes within block from [1, 2, 9] for C[4,1] -> [2, 9]
INFO: HiddenPair: reducing notes within block from [1, 2, 9] for C[4,3] -> [2, 9]
INFO: NakedPair: reducing notes within column from [1, 2, 6] for C[4,4] -> [1, 6]
INFO: NakedPair: reducing notes within column from [1, 2, 4] for C[4,5] -> [1, 4]
INFO: NakedPair: reducing notes within column from [2, 4, 6] for C[4,6] -> [4, 6]
INFO: PointingPair: reducing notes within column from [1, 2, 7, 9] for C[6,4] -> [2, 7, 9]
INFO: PointingPair: reducing notes within column from [1, 2, 7, 8, 9] for C[6,5] -> [2, 7, 8, 9]
INFO: PointingPair: reducing notes within column from [2, 7, 9] for C[6,4] -> [7, 9]
INFO: PointingPair: reducing notes within column from [2, 7, 8, 9] for C[6,5] -> [7, 8, 9]
INFO: PointingPair: reducing notes within column from [2, 7, 8, 9] for C[6,6] -> [7, 8, 9]
INFO: HiddenSingle: exclusive assignment within row for C[7,9] -> 3
INFO: HiddenSingle: exclusive assignment within column for C[2,8] -> 3
INFO: HiddenSingle: exclusive assignment within column for C[5,6] -> 2
INFO: HiddenPair: reducing notes within column from [1, 2, 7] for C[7,5] -> [1, 2]
INFO: HiddenPair: reducing notes within column from [1, 2, 7] for C[7,7] -> [1, 2]
INFO: PointingPair: reducing notes within row from [2, 7] for C[3,8] -> [2]
INFO: HiddenSingle: exclusive assignment within row for C[2,7] -> 7
INFO: HiddenSingle: exclusive assignment within column for C[2,2] -> 1
INFO: HiddenSingle: exclusive assignment within column for C[3,3] -> 7
INFO: HiddenSingle: exclusive assignment within column for C[5,1] -> 1
INFO: HiddenSingle: exclusive assignment within column for C[7,6] -> 7
INFO: HiddenSingle: exclusive assignment within block for C[1,3] -> 2
INFO: HiddenSingle: exclusive assignment within block for C[4,1] -> 2
INFO: HiddenSingle: exclusive assignment within block for C[5,2] -> 7
INFO: HiddenSingle: exclusive assignment within block for C[9,2] -> 2
INFO: HiddenSingle: exclusive assignment within block for C[1,4] -> 7
INFO: HiddenSingle: exclusive assignment within block for C[6,5] -> 7
INFO: HiddenSingle: exclusive assignment within block for C[1,9] -> 1
INFO: HiddenSingle: exclusive assignment within block for C[3,8] -> 2
INFO: HiddenSingle: exclusive assignment within block for C[6,7] -> 1
INFO: HiddenSingle: exclusive assignment within block for C[7,7] -> 2
INFO: HiddenPair: reducing notes within row from [1, 3, 9] for C[8,3] -> [1, 3]
INFO: HiddenPair: reducing notes within row from [1, 3, 9] for C[9,3] -> [1, 3]
INFO: HiddenSingle: exclusive assignment within row for C[4,3] -> 9
INFO: HiddenSingle: exclusive assignment within row for C[9,5] -> 8
INFO: HiddenSingle: exclusive assignment within row for C[6,6] -> 8
INFO: HiddenSingle: exclusive assignment within row for C[6,9] -> 2
INFO: HiddenSingle: exclusive assignment within column for C[6,4] -> 9
INFO: HiddenSingle: exclusive assignment within column for C[7,5] -> 1
INFO: HiddenSingle: exclusive assignment within block for C[4,4] -> 1
INFO: HiddenPair: reducing notes within row from [2, 4, 9] for C[2,5] -> [2, 9]
INFO: HiddenSingle: exclusive assignment within row for C[9,4] -> 6
INFO: HiddenSingle: exclusive assignment within row for C[4,5] -> 4
INFO: HiddenSingle: exclusive assignment within row for C[2,6] -> 4
INFO: HiddenSingle: exclusive assignment within row for C[4,6] -> 6
INFO: HiddenSingle: exclusive assignment within column for C[2,5] -> 9
INFO: HiddenSingle: exclusive assignment within column for C[8,1] -> 9
INFO: HiddenSingle: exclusive assignment within column for C[9,3] -> 3
INFO: HiddenSingle: exclusive assignment within column for C[9,6] -> 9
INFO: HiddenSingle: exclusive assignment within block for C[8,3] -> 1
INFO: HiddenSingle: exclusive assignment within block for C[9,1] -> 7
INFO: HiddenSingle: exclusive assignment within block for C[2,4] -> 2
INFO: HiddenSingle: exclusive assignment within block for C[8,5] -> 2
INFO: HiddenSingle: exclusive assignment within block for C[8,4] -> 3
INFO: HiddenSingle: exclusive assignment within block for C[9,8] -> 1
INFO: HiddenSingle: exclusive assignment within block for C[8,8] -> 7

┌───┬───┬───┐
│453│216│897│
│916│873│542│
│287│945│613│
├───┼───┼───┤
│728│159│436│
│695│437│128│
│341│628│759│
├───┼───┼───┤
│579│381│264│
│832│564│971│
│164│792│385│
└───┴───┴───┘
INFO: Solver spent 0.010876s
```

_If the output is too verbose for your tastes, set `LOG_LEVEL=warn`._