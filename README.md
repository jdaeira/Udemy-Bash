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
cut -c 1 /etc/passwd : will cut the first character
cut -c 1-5 /etc/passwd : will cut characters 1-5
cut -c -4 /etc/passwd : will display the first four characters
cut -c 4- /etc/passwd : will display everything from the fourth character onward
cut -c 1,3,5 /etc/passwd : prints first, third, and fifth character
echo -e 'one\ttwo\tthree' | cut -f 1 : will print the first field of one from tab seperated data
echo 'one,two,three' | cut -d ',' -f 1,3 : -d to cut at the commas
cut -d ':' -f 1,3 /etc/passwd : prints username and UID that is the first and third field
cut -d ':' -f 1,3 --output-delimiter=',' /etc/passwd : changes the out put delimiter from : to ,
grep '^first' people.csv : will print out the lines that starts with "first"
grep 't$' people.csv : this will print the lines that end with the letter "t"
grep '^first,last$' people.csv : this will print anything that starts with first and ends with last
grep -v '^first,last$' people.csv : -v will print anything that doesn't start with first or end with last
awk -F ':' '{print $1, $3}' /etc/passwd : prints the first and third field seperated by ':'
the comma in the command above is a space in the output
awk -F ':' -v OFS=',' '{print $1, $3}' /etc/passwd : adds a comma to seperate the output
awk -F ':' '{print $1 "," $3}' /etc/passwd : does the same thing as the command above
awk -F ':' '{print $NF}' /etc/passwd : the $NF option prints the last field
awk -F ':' '{print $(NF - 1)}' /etc/passwd : will print out the field before the last one
netstat -nutl | grep -v '^Active' | grep -v '^Proto' : won't print the first two lines 
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' : prints out only the port numbers
sort /etc/passwd : sorts in alphabetical order
sort -r /etc/passwd : sorts in reverse
cut -d ':' -f 3 /etc/passwd | sort -nr : sorts numbers numerically in reverse
sudo du -h /var | sort -n : sorts the sizes of directory by size
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -nu : sorts unique ports
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq -c : use uniq -c when you want to know how many times each line was used
wc /etc/passwd : first comes the number of lines in the file. Second is the number of words, third is the number of characters
grep bash /etc/passwd | wc -l : prints number of accounts using bash
cat /etc/passwd | sort -t ':' -k 3 -n : sorts the third field separated by ':' in numberical order

````