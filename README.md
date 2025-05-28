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

Save this file somewhere conveniently accessed. For our purposes, the file will be called "/Users/kevin/Desktop/unsolved-puzzle.txt"

### Run the solver rake task
From your command line, run the `sudoku:solve` rake task with your file name as its sole parameter:

```bash
$ rake "sudoku:solve[/Users/kevin/Desktop/unsolved-puzzle.txt]"
```

The code will run through a series of solution strategies until the puzzle is solved.

### Examine your output
Your solved puzzle will be displayed. Note that when running via a terminal, the initial "seed" values will be bolded. Additionally, alternating blocks will be colored slightly differently for ease of reading.
