#!/bin/bash

PROGNAME=$(basename $0)

function usage {
    # Display usage message on standard error
    echo
    echo "Usage: ./$PROGNAME <glyphish_home> <output_dir>" 1>&2
    echo
}

function error_exit {
    # Display error message and exit
    echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
    echo
    exit 1
}

if [ $# != "2" ]; then
    usage
    error_exit "You must specify both a path where Gliphish icons live as well as an output directory for the archive to be placed."
fi

GLYPHISH_HOME=$1
ICONS_WHITE_HOME=$GLYPHISH_HOME/icons/icons-white
ICONS_GRAY_HOME=$GLYPHISH_HOME/icons/icons-gray

DST_DIR=$2
STANDARD_DIR=$2/standard
TWOX_DIR=$2/2x

if [ ! -d $STANDARD_DIR ]
then
    mkdir $STANDARD_DIR
fi

if [ ! -d $TWOX_DIR ]
then
    mkdir $TWOX_DIR
fi

# Get all white icons requested

for i in $ICONS_WHITE_HOME/{06,07,44,46,53,73,133,193,211,243,259,264,275,286}*.png
do
    dst=`echo $(basename $i) | awk '{ sub(/[0-9\-@]+/, ""); print}' | awk '{ sub("@2x", ""); print}' | awk {' sub(".png", "-white.png"); print}'`
    if [[ $i =~ "2x.png" ]]
    then
        echo "copying $i to $TWOX_DIR/$dst"
        cp $i $TWOX_DIR/$dst
    else
        echo "copying $i to $STANDARD_DIR/$dst"
        cp $i $STANDARD_DIR/$dst
    fi
done


for i in $ICONS_GRAY_HOME/{06,07,44,46,53,73,133,193,211,243,259,264,275,286}*.png
do
    dst=`echo $(basename $i) | awk '{ sub(/[0-9\-@]+/, ""); print}' | awk '{ sub("@2x", ""); print}' | awk {' sub(".png", "-gray.png"); print}'`
    if [[ $i =~ "2x.png" ]]
    then
        echo "copying $i to $TWOX_DIR/$dst"
        cp $i $TWOX_DIR/$dst
    else
        echo "copying $i to $STANDARD_DIR/$dst"
        cp $i $STANDARD_DIR/$dst
    fi
done


