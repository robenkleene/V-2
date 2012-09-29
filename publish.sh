#!/bin/bash

# Configuration #
## Standard Destinations ##
PRODUCT_TITLE=V-2
STYLESHEET_NAME=$PRODUCT_TITLE.css
IMAGE_NAME=$PRODUCT_TITLE.png
SOURCE_CSS_FILE=./css/$STYLESHEET_NAME
SOURCE_IMAGE_FILE=./css/$IMAGE_NAME
PRODUCTS_DESTINATION=./products/
PRODUCT_NNW_STYLE=$PRODUCTS_DESTINATION$PRODUCT_TITLE.nnwstyle
PRODUCT_STYLESHEET=$PRODUCTS_DESTINATION$STYLESHEET_NAME
PRODUCT_IMAGE=$PRODUCTS_DESTINATION$IMAGE_NAME
## Custom Application Installation ##
MARKED_DESTINATION=~/Library/Application\ Support/Marked/Custom\ CSS/
BBEDIT_DESTINATION=~/Library/Application\ Support/BBEdit/Preview\ CSS/
NNW_DESTINATION=~/Library/Application\ Support/NetNewsWire/StyleSheets/
## Messages
PRODUCTS_MESSAGE="$SOURCE_CSS_FILE & $SOURCE_IMAGE_FILE into $PRODUCTS_DESTINATION & $PRODUCT_NNW_STYLE"
MARKED_MESSAGE="$PRODUCT_STYLESHEET & $SOURCE_IMAGE_FILE into $MARKED_DESTINATION"
NNW_MESSAGE="$PRODUCT_NNW_STYLE into $NNW_DESTINATION"
BBEDIT_MESSAGE="$PRODUCT_STYLESHEET & $SOURCE_IMAGE_FILE into $BBEDIT_DESTINATION"
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


# Test All Conditions for the script to run #
## At Least 1 Argument ##
if [ $# -eq 0 ] ; then
	usage
    exit 0
fi
## We can find the SOURCE_CSS_FILE ##
if [ ! -f "$SOURCE_CSS_FILE" ]; then
	echo "Error: $SOURCE_CSS_FILE does not exist. This script should be run from the $PRODUCT_TITLE root."
	usage
	exit 1
fi
## We can find the SOURCE_IMAGE_FILE ##
if [ ! -f "$SOURCE_IMAGE_FILE" ]; then
	echo "Error: $SOURCE_IMAGE_FILE does not exist. This script should be run from the $PRODUCT_TITLE root."
	usage
	exit 1
fi
## We can find the PRODUCTS_DESTINATION ##
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

function copyStyleSheetProductsToDirectory {
	if [ -d "$1" ]; then
 		cp $SOURCE_CSS_FILE "$1"
 		cp $SOURCE_IMAGE_FILE "$1"
	else
		echo "Skipping $1 because it doesn't exist."
	fi
}

if $PRODUCTS_FLAG ; then
	# We already tested the existence of the PRODUCTS_DIRECTORY above
	echo "Copying $PRODUCTS_MESSAGE"
	copyStyleSheetProductsToDirectory "$PRODUCTS_DESTINATION"
	copyStyleSheetProductsToDirectory "$PRODUCT_NNW_STYLE"
fi

if $MARKED_FLAG ; then
	echo "Copying $MARKED_MESSAGE"
	copyStyleSheetProductsToDirectory "$MARKED_DESTINATION"
fi

if $NNW_FLAG ; then
	echo "Copying $NNW_MESSAGE"
	if [ -d "$NNW_DESTINATION" ]; then
		cp -R $PRODUCT_NNW_STYLE "$NNW_DESTINATION"
	else
		echo "Skipping $NNW_DESTINATION because it doesn't exist."
	fi
fi

if $BBEDIT_FLAG ; then
	echo "Copying $BBEDIT_MESSAGE"
	copyStyleSheetProductsToDirectory "$BBEDIT_DESTINATION"
fi