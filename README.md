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
````
> : STDOUT
< : STDIN
>> : Append to a file
0 : STDIN
1 : STDOUT
2 : STDERR
& : contains both STDOUT and STDERR
&> /dev/null : Disregards both STDOUT and STDERR
>&2 : redirects STDOUT and STDERR
````

#### Section 6: Parsing Command Line Options - Project 4
````
*) : is a catch all that catches anything else not entered
local command can only be used inside a function
readonly : makes the variable unchangeable or unmodifiable
logger : /var/log/syslog for Ubuntu
OPTARG : contains the vatiable for the argument
userdel -r : removes user and files in the home directory
id -u : gets the USERID of the user. Be careful removing a USERID lower than 1000
tar -cvf catvideos.tar catvideos : creates and archive of the catvidoes directory
tar -tf catvideos.tar : can see what's inside the archive
tar -xvf catvideos.tar : to extract the contents of catvideos.tar
gzip catvideo.tar : to gzip a folder
gunzip catvideo.tar.gz : to unzip the folder
tar -zcvf catvideos.tar catvideos : creates and compresses a archive of the catvidoes directory
tar -zxvf catvideos.tar : need the -z to see the contents of compressed catvideos.tar
sudo chage -E 0 woz : expire the "woz" account
sudo chage -E -1 woz : to re-enable the account
````

#### Section 7: Transforming Data / Data Processing / Reporting - Project 5
````

````