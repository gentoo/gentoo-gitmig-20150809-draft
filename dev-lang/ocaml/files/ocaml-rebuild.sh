#!/bin/sh
# run like this: ocaml-rebuild.sh [-h | -f] [emerge_options]

emerge=/usr/bin/emerge
qpkg=/usr/bin/qpkg

if [ ! -x $qpkg ]
then
	echo "You need to emerge gentoolkit for this script to work"
	exit 1
fi

if [ "$1" = "-h" ]
then
	echo "usage: ocaml-rebuild.sh [-h | -f(orce)] [emerge_options]"
	echo "With -f, 	the packages will first be unmerged and then emerged"
	echo "with the given options to ensuree correct dependancy analysis."
	echo "Otherwise emerge is run with the --pretend flag and the given"
	echo "options."
	exit 1
fi

if [ "$1" = "-f" ]
then
	pretend=0
	shift
else
	pretend=1
fi

deps=`$qpkg -nc -q -I dev-lang/ocaml | grep -v -e "\(DEPEND.*\)\|\(dev-lang.*\)" | sort | uniq`
toclean=""

for dep in $deps
  do
  	dep=`basename ${dep}`
	dirs=`find /var/db/pkg/ -name ${dep}`
	
	for dir in $dirs
	  do
	  if [ -d $dir ]
	  then
		  ocamldep=`grep dev-lang/ocaml $dir/DEPEND > /dev/null`
		  if [[ $ocamldep -eq 0 ]]
		  then
			category=`cat $dir/CATEGORY`
			toclean="=$category/$dep $toclean"
		  fi
	  fi
	done	
done

if [ "$toclean" != "" ]
then
	if [ $pretend -eq 1 ]
	then
		$emerge --pretend $@ $toclean		
	else
		$emerge unmerge $toclean
		$emerge $@ $toclean
	fi
else
	echo "Nothing to update"
fi
