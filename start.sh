#!/bin/sh

DIR=`pwd`
GITPULL="git pull"
REPLIST="apps cdk driver flash"

case "$1" in
	clone)
		for f in  $REPLIST ; do
			if [ -d "$f" ]; then
				echo "$f already cloned"
			else
				if [ "$2" = "dev" ]; then
					# dev
					git clone git@github.com:Audioniek/$f $f
				else
					# usr
					git clone git://github.com/Audioniek/$f $f
				fi
				echo "git clone" $f
			fi
		done
		sudo $DIR/prepare4cdk.sh
		;;
	pull)
		for f in  $REPLIST ; do
			cd $DIR/$f
			echo "git pull" $f
			$GITPULL
			cd ..
			done
			;;
	*)
		if [ -d cdk ]; then
			echo "Usage: {clone | pull}"
			exit 1
		else
			$0 clone
		fi
esac
