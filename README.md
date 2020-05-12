# Udemy Bash Course
## Notes and Scripts from Udemy Bash Scripting Course

#### Section 3: User and Account Creation - Project 1
````
to store a command in a variable use parenthesis 
$(id -un) or `id -un` (older style syntax)
root always has the UID of 0
-eq = equal
-ne = not equal
-lt = less than
-le = less than or equal to
-gt = greater than
-ge = greater than or equal to
exit status 0 means program executed successfully
${?} = stores the last executed command
````

#### Section 4: Password Generation and Shell Script Arguments - Project 2
````
$(( (RANDOM % 10) + 1 )) : generate random number between 1 - 10
echo $PATH : prints out what the PATH is
export PATH="$HOME/bin:$PATH" : add this line to the .bashrc or .zshrc to add directory to PATH
${?} : check to see the exit code for the last command
${0} : is the first argument on command line
${#} : is the number of parameters on the command line
${@} : expands the positional parameters (kind of like an array)
${*} : treats everything on the command line as 1 argument
shift: removes the top element of ${1}
````

#### Section 5: Linux Programming Conventions - Project 3