#!/bin/sh

if [ $# != 2 ] ; then
  echo "Usage: $0 [input file] [config file]"
  exit 0
fi

if [ ! -f $1 ] ; then
  echo "$1 does not exist!"
  exit 0
fi

xmlfile=`incl -x $1`
text=""

xml2config() {
  echo $xmlfile | extract -x $1 - | pipe | sed -e "s:^-::" | awk -f awk/$2.awk
}

xmlexists() {
  text=$xmlfile
  for i in $1
  do
    text=`echo $text | extract -x $i -`
  done
}

case $2 in

   fstab)
	xml2config mount fstab
	;;
   basic)
	xml2config machine basic
	;;
esac