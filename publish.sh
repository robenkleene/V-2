#!/bin/bash

# Configuration #
## Standard Destinations ##
PRODUCT_TITLE=Pynchon
STYLESHEET_NAME=$PRODUCT_TITLE.css
SOURCE_CSS_FILE=./css/$STYLESHEET_NAME
OUTPUT_DESTINATION=./products/
PRODUCT_NNW_STYLE=$OUTPUT_DESTINATION$PRODUCT_TITLE.nnwstyle
PRODUCT_STYLESHEET=$OUTPUT_DESTINATION$STYLESHEET_NAME
## Custom Application Installation ##
MARKED_DESTINATION=~/Library/Application\ Support/Marked/Custom\ CSS/
BBEDIT_DESTINATION=~/Library/Application\ Support/BBEdit/Preview\ CSS/
NNW_DESTINATION=~/Library/Application\ Support/NetNewsWire/StyleSheets/
## Messages
P_MESSAGE="$SOURCE_CSS_FILE into $OUTPUT_DESTINATION and $PRODUCT_NNW_STYLE"
M_MESSAGE="$PRODUCT_STYLESHEET into $MARKED_DESTINATION"
N_MESSAGE="$PRODUCT_NNW_STYLE into $NNW_DESTINATION"
B_MESSAGE="$PRODUCT_STYLESHEET into $BBEDIT_DESTINATION"

usage () {
	echo "usage: $0 ..."
	echo -e "\n"
	echo "-p : Publish to Products"
	echo "     $P_MESSAGE"
	echo "-m : Publish to Marked Custom CSS -- "
	echo "-n : Publish to NetNewsWire StyleSheets -- Copies "
	echo "-b : Publish to BBEdit -- Copies $PRODUCT_STYLESHEET into $BBEDIT_DESTINATION"
	echo "-a : Publish to All -- Performs all of the above"
}

if [ $# -eq 0 ] ; then
	usage
    exit 0
fi

# Test we can find the SOURCE_CSS_FILE
if [ ! -f "$SOURCE_CSS_FILE" ]; then
	echo "Error: $SOURCE_CSS_FILE does not exist. This script should be run from the $PRODUCT_TITLE root."
	usage
	exit 1
fi

while getopts ":pmnba" option; do
	case $option in
	   ?)  echo "Error: unknown option -$option" 
			usage
			exit 1
			;;
# 	   *)  usage
# 			exit 1
# 			;;

	esac
done

# Copy the SOURCE_CSS_FILE into the OUTPUT_DESTINATION
# if [ -d "$OUTPUT_DESTINATION" ]; then
# 	echo "Copying $SOURCE_CSS_FILE into $OUTPUT_DESTINATION"
# 	cp $SOURCE_CSS_FILE $OUTPUT_DESTINATION
# else
# 	echo "$OUTPUT_DESTINATION directory does not exist. Aborting"
# fi





# cp ./css/Pynchon.css ~/Library/Application\ Support/Marked/Custom\ CSS/
# cp ./css/Pynchon.css ~/Library/Application\ Support/BBEdit/Preview\ CSS/
# cp ./css/Pynchon.css ./Pynchon.nnwstyle/
# cp -R ./Pynchon.nnwstyle ~/Library/Application\ Support/NetNewsWire/StyleSheets/