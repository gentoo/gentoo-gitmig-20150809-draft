#!/bin/sh
# run like this: ocaml-rebuild.sh [emerge_options]

emerge=/usr/bin/emerge
qpkg=/usr/bin/qpkg

if [ ! -x $qpkg ]
then
	echo "You need to emerge gentoolkit for this script to work"
	exit 1
fi

deps=`$qpkg -nc -n -q -I dev-lang/ocaml-3.06 | grep -v -e "\(DEPEND.*\)\|\(dev-lang.*\)" | sort | uniq`
toclean=""

for dep in $deps
  do
	dirs=`find /var/db/pkg/ -name ${dep}`
	
	for dir in $dirs
	  do
	  if [ -d $dir ]
	  then
		  ocamldep=`grep dev-lang/ocaml $dir/DEPEND > /dev/null`
		  if [[ $ocamldep -eq 0 ]]
		  then
			  SLOT=`cat $dir/SLOT`
			  if [[ "$SLOT" = "" || "$SLOT" = "0" ]]
				  then
				  category=`cat $dir/CATEGORY`
				  toclean="=$category/$dep $toclean"
			  fi
		  fi
	  fi
	done	
done

if [ "$toclean" != "" ]
then
	cmd="$emerge $@ $toclean"
	#echo "Debug:" $cmd
	$cmd
else
	echo "Nothing to update"
fi
