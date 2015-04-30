#!/bin/bash

BIN="./pdscli "		# Specify binary
TCDIR="./testcases"	# Directory with test files
TCFILE="test"		# Test-case file with command to binary

# Enable debug
#set -x

for file in `find ./testcases -type f -iname "$TCFILE*"`; do

	# Check for test-case file structure
	if [ `wc -l $file | cut -d ' ' -f1` != 4 ]; then
		echo "File $file has wrong structure"
		continue
	fi

	# Parse file
	NAME=`sed '1q;d' $file`
	COMMAND=`sed '2q;d' $file`
	EXECUTE=`sed '3q;d' $file`
	RESULT=`sed '4q;d' $file | tr '[:upper:]' '[:lower:]'`
	CLEANUP=`sed '5q;d' $file`

	echo -n "Test: $NAME..."

	# Prepare kernel module
	$BIN$COMMAND > /dev/null 2>&1
	R="$?"
	if [ $R != "0" ] && [ "$RESULT" == "invalid" ]; then
		echo "OK"
		continue
	elif [ $R != "0" ]; then
		echo "Command returned $R"
		echo "Cannot execute $BIN$COMMAND"
		exit -1
	fi

	# Execute command
	$EXECUTE > /dev/null 2>&1
	R="$?"

	# Check the result
	if [ "$RESULT" == "pass" ] && [ "$?" == $R ]; then
		echo "OK"
	elif [ "$RESULT" == "fail" ] && [ "$?" != $R ]; then
		echo "OK"
	else
		echo "FAILED"
	fi

	# Clean rules for other tests
	$BIN$CLEANUP
	if [ "$?" != "0" ]; then
		echo "Celanup failed, tests will crash"
		echo "Exiting..."
		exit -1
	fi

done 