#!/bin/bash

# Configuration #
## Standard Destinations ##
PRODUCT_TITLE=Pynchon
STYLESHEET_NAME=$PRODUCT_TITLE.css
SOURCE_CSS_FILE=./css/$STYLESHEET_NAME
PRODUCTS_DESTINATION=./products/
PRODUCT_NNW_STYLE=$PRODUCTS_DESTINATION$PRODUCT_TITLE.nnwstyle
PRODUCT_STYLESHEET=$PRODUCTS_DESTINATION$STYLESHEET_NAME
## Custom Application Installation ##
MARKED_DESTINATION=~/Library/Application\ Support/Marked/Custom\ CSS/
BBEDIT_DESTINATION=~/Library/Application\ Support/BBEdit/Preview\ CSS/
NNW_DESTINATION=~/Library/Application\ Support/NetNewsWire/StyleSheets/
## Messages
PRODUCTS_MESSAGE="$SOURCE_CSS_FILE into $PRODUCTS_DESTINATION and $PRODUCT_NNW_STYLE"
MARKED_MESSAGE="$PRODUCT_STYLESHEET into $MARKED_DESTINATION"
NNW_MESSAGE="$PRODUCT_NNW_STYLE into $NNW_DESTINATION"
BBEDIT_MESSAGE="$PRODUCT_STYLESHEET into $BBEDIT_DESTINATION"
## Flags
PRODUCTS_FLAG=false
MARKED_FLAG=false
NNW_FLAG=false
BBEDIT_FLAG=false

usage () {
	echo "usage: $0 [-pmnb] [-a]"
	echo
	echo "Files will be copied only if the destination directory already exists."
	echo
	echo "-p : Publish to Products"
	echo "     Copies $PRODUCTS_MESSAGE"
	echo
	echo "-m : Publish to Marked Custom CSS"
	echo "     Copies $MARKED_MESSAGE"
	echo
	echo "-n : Publish to NetNewsWire StyleSheets"
	echo "     Copies $NNW_MESSAGE"
	echo
	echo "-b : Publish to BBEdit"
	echo "     Copies $BBEDIT_MESSAGE"
	echo
	echo "-a : Publish to All"
	echo "     Do all of the above"
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

# Test if we can find the PRODUCTS_DESTINATION
if [ ! -d "$PRODUCTS_DESTINATION" ]; then
	echo "Error: $PRODUCTS_DESTINATION does not exist. This script should be run from the $PRODUCT_TITLE root."
	usage
	exit 1
fi



while getopts ":pmnba" option; do
	case $option in
		p)	PRODUCTS_FLAG=true
			;;
		m)	MARKED_FLAG=true
			;;
		n)	NNW_FLAG=true
			;;
		b)	BBEDIT_FLAG=true
			;;
		a)	PRODUCTS_FLAG=true
			MARKED_FLAG=true
			NNW_FLAG=true
			BBEDIT_FLAG=true
			;;
		?) 	echo "Error: unknown option -$option" 
			usage
			exit 1
			;;
	esac
done

if $PRODUCTS_FLAG ; then
	# We already tested the existence of the PRODUCTS_DIRECTORY above
	echo "Copying $PRODUCTS_MESSAGE"
fi

if $MARKED_FLAG ; then
	echo "Copying $MARKED_MESSAGE"
fi

if $NNW_FLAG ; then
	echo "Copying $NNW_MESSAGE"
fi

if $BBEDIT_FLAG ; then
	echo "Copying $BBEDIT_MESSAGE"
fi





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