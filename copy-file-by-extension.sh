#!/bin/sh
SCRIPT_NAME=$0
echo ""

# Check arguments
if [ ! $# -gt 2 ]
  then
    echo "Not enough arguments supplied"
    echo "Please run:" 
    echo "\t \$ sh $SCRIPT_NAME <source path> <destination path> <file extensions>"
    exit 1
fi


# Check source path
if [ ! -d "$1" ]
  then 
    echo "❗️ Invalid source path"
    exit 1
fi


# Check destination path
if [ ! -d "$2" ]
  then 
    echo "❗️ Invalid destination path"
    exit 1
fi


# Check file extensions
for ext in ${@:3}
do
  if [[ ! $ext =~ ^\.[a-zA-Z0-9]+$ ]] 
    then 
      echo "❗️ $ext is not a valid file extension"
      exit 1
  fi
done 

SOURCE_PATH=$1
DESTINAITON_PATH=$2
FILE_TYPES=${@:3}

echo ""
echo $SCRIPT_NAME
echo "SOURCE PATH: \t\t" $SOURCE_PATH
echo "DESTINATION PATH: \t" $DESTINAITON_PATH
echo "FILE TYPES: \t\t" $FILE_TYPES
echo ""

# find $SOURCE_PATH -name '$ext' -print | cpio -pvdumB $DESTINAITON_PATH

for ext in $FILE_TYPES
do
  echo "Looking for files with extension $ext";
  rsync -rv --include '*/' --include '*'$ext --exclude '*' --prune-empty-dirs $SOURCE_PATH/ $DESTINAITON_PATH/
done


exit 1