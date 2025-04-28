

# My Work for Fawry DevOps Internship

## Task 1: Building mygrep.sh Script

### What I Did
I created a script named `mygrep.sh` that acts like the `grep` command. It does these things:
- Searches for a word in a file (doesn’t care if letters are big or small).
- Uses `-n` to show line numbers with the results.
- Uses `-v` to show lines that don’t have the word.
- Uses `-vn` or `-nv` together to show line numbers for lines that don’t have the word.
- Shows an error if I don’t give a word or a file to search in.

I tested my script with a file called `testfile.txt` that has these lines:

Hello world
This is a test
another test line
HELLO AGAIN
Don't match this line
Testing one two three


### Files I Used
- `Q1 Custom Command (mygrep.sh)/mygrep.sh`: This is the script I wrote.
- `Q1 Custom Command (mygrep.sh)/testfile.txt`: This is the file I used for testing.

### Screenshots of My Tests
I ran these commands in the terminal and took one screenshot for all of them:
- `./mygrep.sh hello testfile.txt`
- `./mygrep.sh -n hello testfile.txt`
- `./mygrep.sh -vn hello testfile.txt` and `./mygrep.sh -nv hello testfile.txt` (to test both -vn and -nv, they give the same result)
- `./mygrep.sh -v testfile.txt` (shows error)

![All Commands](Q1 Custom Command (mygrep.sh)/screenshots/All Tests Command.png)

### Reflective Section
#### 1. How My Script Handles Arguments and Options
My script first checks if I gave it a word and a file to work with. If I didn’t, it shows an error message. Then it checks if I used options like `-n` or `-v` or both. It reads the file line by line and looks for the word. If I used `-n`, it shows the line number before the line. If I used `-v`, it shows the lines that don’t have the word.

#### 2. How My Structure Would Change to Support Regex or -i/-c/-l Options
To add regex, I can change `grep -qi` to `grep -E` so it can understand patterns. For `-i`, my script already does that because it ignores big or small letters. For `-c`, I can add a counter to count the lines that match and show the number at the end. For `-l`, I can make it work with many files and only show the names of files that have the word.

#### 3. What Part of the Script Was Hardest to Implement and Why
The first hard part was making `-vn` and `-nv` work the same way. I had to check each letter in the option to know if it’s `n` or `v`, and make sure they work together no matter the order. Another hard part was handling the error messages. I had to make sure the script shows the right error if I don’t give a word or a file, and it took me some time to get the checks in the right order.

