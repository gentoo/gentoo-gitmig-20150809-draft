#!/bin/sh

# description:
#
# ROOT is the root all packages are installed to
#
# if CHECK=yes then skip an already installed package
# if CHECK=package then skip a package if its tbz2 already exists
#
# ERRQUIT=no causes the script to keep trying to build packages even
# when one has failed.
#

C_NORMAL=$'\033[0m'
C_HILITE=$'\e[36;01m'
C_END=$'\e[A\e[68G'
C_OK=$'\e[32m'
C_NO=$'\e[31m'
#eval `/usr/lib/portage/bin/import-settings PORTDIR PKGDIR`
PORTDIR=/usr/portage
LOGDIR=${ROOT}/tmp/portage-log
PKGDIR=/usr/portage/packages
[ -z "$CHECK" ] && CHECK="yes"
[ -z "$STEPS" ] && STEPS="check fetch clean compile install qmerge clean"
[ -z "$ERRQUIT" ] && ERRQUIT="no"

do_step() {

    local tmpd
    tmpd=`pwd`
    echo "$C_END $C_HILITE          "
    echo "$C_END $C_HILITE [$1]$C_NORMAL  "
    cd `dirname $myd`
    ebuild $myf $1 &> $myl/$1
    mye=$?
    cd $tmpd

    if [ -f $LOGDIR/$1 ]
    then
      cp $LOGDIR/$1 /tmp/failed
      grep -v "$i" /tmp/failed > $LOGDIR/$1
    fi

    if [ $mye -ne 0 ]
    then	
      echo "$C_END $C_HILITE          "
      echo "$C_END $C_NO [$1]$C_NORMAL  "
      echo $i >> $LOGDIR/$1
      [ "${ERRQUIT}" = "yes" ] && exit 1
    fi
    return $mye
}

if [ -z "${ROOT}" ]
then
	echo "ROOT not set !"
	exit 1
fi

mylist=${PORTDIR}/current-packages

if [ -f "${1}" ]
then
  mylist=${1}
fi

mypackages="`grep -v "\#.*" $mylist`"

install -m1777 -d $ROOT/tmp/portage-log

echo "$C_HILITE>>>$C_NORMAL Building from ${mylist}..."
for i in $mypackages
do
  source /etc/profile
  # full path
  myd=${i/.\//$PORTDIR\/}

  # file name
  myf="`basename $myd`"

  # category
  myc="`echo $i | sed -e "s:^\(.*\).*/.*/.*$:\1:"`"

  # package name
  myp=${myf%*.ebuild}

  # debugging
#  echo $myp

  if [ -f "$myd" ]
  then

    # Check if installed
    if [ "$CHECK" = "yes" ]
    then
        if [ -d ${ROOT}/var/db/pkg/$myc/$myp ]
        then
            continue
        fi
    else
        if [ "$CHECK" = "package" ]
        then
            if [ -f ${PKGDIR}/All/$myp.tbz2 ]
            then
                continue
            fi
        fi
    fi

    echo "$C_NORMAL$myp ($myc)"

    myl="$LOGDIR/$myc/$myp/"
    mkdir -p $myl

    for j in ${STEPS}
    do
      mye=0
      do_step $j
      if [ $mye -ne 0 ]
      then
	break
      fi
    done
    if [ $mye -eq 0 ]
    then
      echo "$C_END $C_OK [OK]$C_NORMAL     "
      echo $i >> ${LOGDIR}/ok
    fi

  else
    echo "!!! $myd does not exists !"
  fi
  env-update &>/dev/null

done
