#!/bin/bash
# Irongeek"s crappy change detection script. ver. 0.1
# The purpose of this script is to detect file changes. We will make an MD5 
# hash of all the files in a path and look for changes. In theory, the next 
# two lines should be all you have to change (except maybe the find command).
PathToCheck="/home/irongeek/irongeek.com"
SendReportsToThisEmailAddress="irongeek@irongeek.com"
# We will store the results of our recursive hashing so we can compare them
# to new results later. Add a line like this: 
# */10 * * * * /home/irongeek/t/t.sh>/dev/null 2>&1
# to your crontab to run the script every 10 min. "crontab -e" should be the 
# command to do that (and of course leave off the # comment, and chmod +x the 
# script so that it is executable). This next line sets a variable so we know 
# where the script is ran from, and CDs into that directory. You will need 
# write permissions in this directory.
ScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# These lines just print some running information
echo Working in directory $ScriptDir
echo Checking directory $PathToCheck
echo Reports will be sent to $SendReportsToThisEmailAddress
# The next line finds all the files in the path, but excludes some we don"t
# care to check. In my case, some .spc files used to cache some RSS feeds.
# Remove this exclusion, or add more exclusions, as you wish. After find finds
# a file, it runs md5sum on it, and stores the results by redirecting
# standard out into a file.
find $PathToCheck -type f \( -not -iname "*.spc" \) -exec md5sum "{}" \;>$ScriptDir/newout.txt
# Assuming this is not the first run, the output of the command above gets 
# compared to the old output of a previous run and the differences redirected 
# into a temp file.
diff -C 0 $ScriptDir/oldout.txt $ScriptDir/newout.txt > $ScriptDir/difftemp.txt
# Assuming the file is bigger than 0 bytes, we will go into this if statement.
if [ -s $ScriptDir/difftemp.txt ]
then
	# Yippy, we found some differences in the MD5 hashes, time to generate
	# some output we will eventually send as a warning.
	echo "Got differences, sending email"
	echo "Change Report" > $ScriptDir/tempoutput.txt
	echo >> $ScriptDir/tempoutput.txt
	# The weird awk and regex below is so we can work with file names with
	# spaces in them. We ls -al each changed file to get things like size,
	# timestamp and permissions, just so there is extra info in the report.
	awk '{fn=substr($0,length($1 $2) + 4);gsub(/ /,"\\ ", fn); print fn}' \
			  $ScriptDir/difftemp.txt | grep / | uniq | xargs ls -al \
			  >>$ScriptDir/tempoutput.txt
	# Lines like the one below are just to put in an extra linefeed.
	echo >> $ScriptDir/tempoutput.txt
	# Let"s put the hash differences into the report.
	cat $ScriptDir/difftemp.txt >> $ScriptDir/tempoutput.txt
	echo >> $ScriptDir/tempoutput.txt
	# Now we can pipe it into the mail utility and send it to whom we want.
	cat $ScriptDir/tempoutput.txt | mail -s "MD5 Diff `date`" $SendReportsToThisEmailAddress
	# We will also make a running log, >> means append but not over wight.
	date >> $ScriptDir/permlog.txt
	cat $ScriptDir/tempoutput.txt >> $ScriptDir/permlog.txt
	# We will also make an archived copy of the output, naming it by date.
	cp $ScriptDir/newout.txt $ScriptDir/oldout_`date +"%Y%m%d%H%M%S"`.txt
	# And now the new output becomes the old output for the next time we do
	# MD5 file hash comparisons.
	mv $ScriptDir/newout.txt $ScriptDir/oldout.txt
else
	# If the file in the if statement is 0 bytes, we end up here, and do 
	# nothing.
	echo "No differences"
fi
