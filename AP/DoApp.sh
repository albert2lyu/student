#!/bin/sh

SCRIPT_FILE="DoIT.sh"

if [ $# = 1 ]; then
	case "$1" in
		"clean")
			MAKECLEAR=1
			MAKEIMG=0
			;;
		"image")
			export MAKECLEAR=0
			export MAKEIMG=1
			;;
	esac
else
	echo ""
	echo "******************** No argument ********************"
	echo ""
	exit 1
fi

for DIR in $(ls); do
    if [ -d $DIR ]; then
		cd $DIR
		if [ -f $SCRIPT_FILE ]; then
		    echo ""
			echo "******************** Compiling $DIR ********************"
			echo ""
			echo "******************** $DIR $1 ********************"
			./$SCRIPT_FILE $1
			if [ $? = 0 ]; then
				echo ""
				echo "******************** End compile $DIR ********************"
				echo ""
			else
                echo ""
		        echo "******************** compile ERROR in $DIR !! ********************"
                echo ""
				exit 1
			fi
		fi
		cd ..
	fi
done

if [ "$MAKEIMG" = "1" ]; then
	echo ""
	echo "******************** Copy app to rootfs start ********************"
	echo ""
	cd mkimg
        ./app_transfer.sh
        echo ""
        echo "******************** Copy app to rootfs done *********************"
        echo ""
fi

echo ""
echo "******************** Script finished !! ********************"
echo ""
