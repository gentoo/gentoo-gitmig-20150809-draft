# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde.eclass,v 1.24 2001/12/24 20:54:31 danarmak Exp $
# The kde eclass is inherited by all kde-* eclasses. Few ebuilds inherit straight from here.
inherit autoconf base || die
ECLASS=kde

DESCRIPTION="Based on the $ECLASS eclass"

HOMEPAGE="http://www.kde.org/"

DEPEND="$DEPEND objprelink? ( >=dev-util/objprelink-0-r1 )"

# resolution function: kde version -> qt version
# wish we had something like python dictionaries here :-)
# gets kde version in $1 and returns matching qt version in $matching_qt_ver
# if none matches, returns -1
qtver-from-kdever() {

	debug-print-function $FUNCNAME $*

	case "$1" in
		2_* | 2 | 2.0*)		matching_qt_ver=2;;
		2.1*)			matching_qt_ver=2.1;;
		2.2*)			matching_qt_ver=2.3.1;;
		3_* | 3 | 3.0*)		matching_qt_ver=3.0.1;;
		*)				matching_qt_ver=-1
	esac

	debug-print "$FUNCNAME: resolved KDE version $1 to QT version $matching_qt_ver"

}

kde-objprelink-patch() {
	debug-print-function $FUNCNAME $*
	if [ "`use objprelink`" ]; then
	    cd ${S} || die
	    patch -p0 < /usr/share/objprelink/kde-admin-acinclude.patch || die
	    patched=false
	    
	    for x in Makefile.cvs admin/Makefile.common
	    do
		if ! $patched
		then
		    if [ -f $x ]
		    then
			echo "patching file $x (kde-objprelink-patch)" && make -f $x && patched=true || die
		    fi
		fi
	    done

	    $patched || echo "??? Warning: kde-objprelink-patch: patch not applied, makefile not found"
	
	fi

}

kde_src_compile() {

    debug-print-function $FUNCNAME $*
    [ -z "$1" ] && kde_src_compile all

    while [ "$1" ]; do

	case $1 in
		myconf)
			debug-print-section myconf
			if [ ! -d "$KDEDIR" ]; then
			    # possible if portage installed a version newer than the one requested
			    debug-print "$FUNCNAME::myconf: calling set-kdedir again"
			    set-kdedir
			fi
			myconf="$myconf --host=${CHOST} --with-x --enable-mitshm --with-xinerama --prefix=/usr --with-qt-dir=${QTDIR}"
			use qtmt 	&& myconf="$myconf --enable-mt"
			use objprelink	&& myconf="$myconf --enable-objprelink" || myconf="$myconf --disable-objprelink"
			debug-print "$FUNCNAME: myconf: set to ${myconf}"
			;;
		configure)
			debug-print-section configure
			debug-print "$FUNCNAME::configure: myconf=$myconf"
			./configure ${myconf} || die
			;;
		make)
			debug-print-section make
			LIBRARY_PATH=${LIBRARY_PATH}:${QTDIR}/lib make || die
			;;
		all)
			debug-print-section all
			kde_src_compile myconf configure make
			;;
	esac

    shift
    done

}

kde_src_install() {

	debug-print-function $FUNCNAME $*
    [ -z "$1" ] && kde_src_install all

    while [ "$1" ]; do

	case $1 in
	    make)
			debug-print-section make
			make install DESTDIR=${D} destdir=${D} || die
			;;
	    dodoc)
			debug-print-section dodoc
			dodoc AUTHORS ChangeLog README* COPYING NEWS TODO
			;;
	    all)
			debug-print-section all
			kde_src_install make dodoc
			;;
	esac

    shift
    done

}

EXPORT_FUNCTIONS src_compile src_install

# This used to be depend.eclass. At some point I realized it might as well be called kde-depend.eclass. And then
# because functions fom there needed functions from here and vice versa I merged them.

#---------------

# This provides the need-kde and need-qt functions, which handle setting KDEDIR
# and QTDIR for the multi-qt and multi-kdelibs schemes. The functions set-kdedir and
# set-qtdir are called from kde.eclass; the need-* functions from the ebuild.

# A helper function that takes a dot-separated string and builds an array from its parts.
# We need this for version comparisons becaus bash can't compare e.g. 2.2.2 and 2.12.3.
# array created is called version_parts
# 1st parameter: string to separate
# 2nd parameter: separator char(s) (optional, defaults to "._" dot and underscore)
# 3rd parameter: name of array to create (optional, defaults to "version")
# 4th parameter: minimal number of version parts (optional, defaults to 0). If after
# separation this number is not reached, the necessary amount of parts is added with value 0.
# This is a very ugly kludge as there is also a 0th element of the array which isn't counted on
# purpose, because that's how we want it to be. In short, you shouldn't use this outside depend.eclass :-)
separate-string() {

    debug-print-function $FUNCNAME $*

    [ -n "$3" ] && arr="$3" || arr="version"
    [ -n "$2" ] && sep="$2" || sep="._"
    [ -n "$4" ] && min="$4" || min=0
    IFSBACKUP=$IFS
    IFS=$sep

    local index
    index=0
    for x in $1
    do
	eval $arr[$index]=$x
	debug-print "$FUNCNAME: adding to array, index = $index, value = $x"
	let "index+=1"
    done

    while [ "$index" -le "$min" ] # <= not < because $index ends up being larger by 1 than the amount of elements in the array
    do
	eval $arr[$index]=0
	debug-print "$FUNCNAME: adding to array, index = $index, value = 0"
	let "index+=1"
    done

    debug-print

    IFS=$IFSBACKUP

}

# The version comparison/selection function. Uses separate-string() to break down
# version numbers into their components and selects the one to use. Assumes *some*
# good version is installed, as we add the requirment to DEPEND/RDEPEND. Is used for
# both qt and kdelibs.
# 1st parameter: required (minimal) version
# 2nd parameter: list of space-separated versions to choose from
select-version() {

    debug-print-function $FUNCNAME $*

    # 2d arrays in bash are troublesome, so we do this:
    # sanity check - make sure we've got all parameters
    if [ $# != 2 ]; then
	echo "!!! Error: $FUNCNAME did not get all required parameters.
!!! You can check what it did get with eclass debug output."
	exit 1
    fi

    # to facilitate handling of release types (alpha,beta,pre,rc) we replace them with numbers
    local needed list
    needed="`echo $1 | sed -e 's/alpha/-4./' \
		       -e 's/beta/-3./' \
		       -e 's/pre/-2./' \
		       -e 's/rc/-1./' `"
    list="`echo $2 | sed -e 's/alpha/-4./' \
		       -e 's/beta/-3./' \
		       -e 's/pre/-2./' \
		       -e 's/rc/-1./' `"

    # because we're going to separate each version number into its components,
    # once we've selected one it'll be difficult to "unseparate" it, recreatg e.g.
    # beta/alpha/underscores etc. So we prepend a ser. number to each. Since we
    # don't know the length/number of parts in a version number at this stage,
    # we can't append the index but must prepend it. Then it'll live as part 0
    # of the separated version number, while we'll deal with parts 1 through 5.
    local index templist
    index=1
    templist="$list"
    list=""
    for x in $templist; do
	list="${list} ${index}.${x}"
	let "index+=1"
    done

    debug-print "$FUNCNAME: after parsing, list = $list"

    # parse required version number $1 -> array "req"
    separate-string 0.$1 ._ req 5
    debug-print "$FUNCNAME: for \$1 = $1, we've got back a req with contents = ${req[*]}"

    # init array "best" to major,-1,-1 so that any alternative is better (major is
    # major version number of needed). give it a nonexistent index.
    declare -a best
    best=( 0 ${req[1]} -10 -10 -10 -10 -10 )

    # for each version number in $list:
    local x ver
    for ver in $list
    do
	# parse version number -> array "cur"
	separate-string $ver ._ cur 5
	debug-print "$FUNCNAME: for ver = $ver, we've got back a cur with contents = ${cur[*]}"

	# check if it satisfies the requirements. if not, pass to the next x.
	# 1. major version numer is = to that of req
	[ ${cur[1]} -eq ${req[1]} ] || continue

	# 2. check whether minor version and revision of cur are >= those of best
	# if = continue checking (lower levels), if > select right away, if < break
	# we typically have upto 5 levels: major, minor, revision,
	# release type (alpha, beta...), release type number (beta1, beta2...)
	for x in 2 3 4 5
	do
	    debug-print "$FUNCNAME: will compare place $x. in cur: ${cur[$x]}, in best: ${best[$x]}"
	    if [ "${cur[$x]}" -gt "${best[$x]}" ]; then
		debug-print "$FUNCNAME: comparison result is >"
		# set best to equal cur
		best=( "${cur[@]}" )
		continue 2 # next iteration of outer loop
	    elif [ "${cur[$x]}" -lt "${best[$x]}" ]; then
		debug-print "$FUNCNAME: comparison result is <"
		continue 2 # next iteration of outer loop
	    # this is all implicitly done
	    else # [ ${cur[2]} -eq ${best[2]} ]
		debug-print "$FUNCNAME: comparison result is ="
	    #	# see if we've reached the last iteration
	    #	if [ "$x" = "5" ]; then
	    #	# this is exactly the version we need, i.e. req = cur.
	    #	# so we don't have to do anything at all :-)
	    #	fi
	    # continue # next iteration of this loop
	    #fi
	fi
	done

    done

    # find the coresponding "unseparated" version number in the orig. $list using
    # the indexes we planted
    local result count
    index=${best[0]}
    debug-print "$FUNCNAME: best has index number $index \
compare with $list \
search for it in $2"
    count=1
    for x in $2; do
	if [ "$count" = "$index" ]; then
	    result=$x
	    break
	fi
	let "count+=1"
    done

    if [ -z "$result" ]; then
	# this is probably ok as it shuold mean portage will install the needed version
	# hadnling code in kde_src_compile
	debug-print "Warning: $FUNCNAME: could not find/select a satisfying version number!
this probably means that it hasn't yet been installed, but will be."
	result="$1"
    fi

    # strip all spaces
    result="${result// }"

    # return, tired but satisfied
    selected_version=$result
    debug-print "$FUNCNAME: final result: returning selected_version = $selected_version"

}

set-kdedir() {

	debug-print-function $FUNCNAME $*

	biglist="`ls -d1 /usr/lib/kdelibs-*`"
	debug-print "$FUNCNAME: \$biglist:
${biglist}"

	# filter $biglist to create $list
	list=""
	for x in $biglist; do
	    # strip path, leave version number
	    x="`echo $x | sed -e 's:/usr/lib/kdelibs-::'`"
	    list="$list $x"
	done

	debug-print "$FUNCNAME: filtered \$biglist and got this \$list:
$list"

	# select version
	select-version $KDEVER "$list"

	# check and set
	if [ -z "$selected_version" ]; then
	    echo "!!! $FUNCNAME: no match returned by select-version! Please report."
	else
	    export KDEDIR="/usr/lib/kdelibs-$selected_version"
	fi

}

need-kde() {

	KDEVER="$1"
	debug-print-function $FUNCNAME $*
	debug-print "$FUNCNAME: version number is $KDEVER"

	separate-string $KDEVER ._ KDEVER 5

	KDEMAJORVER=KDEVER[0]

	newdepend ">=kde-base/kdelibs-$KDEVER"

	set-kdedir

	qtver-from-kdever $KDEVER
	need-qt $matching_qt_ver

}

set-qtdir() {

	debug-print-function $FUNCNAME $*

	biglist="`ls -d1 /usr/lib/qt-x11-*`"
	debug-print "$FUNCNAME: \$biglist:
${biglist}"

	# filter $biglist to create $list
	list=""
	for x in $biglist; do
	    # strip path, leave version number
	    x="`echo $x | sed -e 's:/usr/lib/qt-x11-::'`"
	    list="$list $x"
	done

	debug-print "$FUNCNAME: filtered \$biglist and got this \$list:
$list"

	# select version
	select-version $QTVER "$list"

	# check and set
	if [ -z "$selected_version" ]; then
	    echo "!!! $FUNCNAME: no match returned by select-version! Please report."
	else
	    export QTDIR="/usr/lib/qt-x11-$selected_version"
	fi

}

need-qt() {

	QTVER="$1"
	debug-print-function $FUNCNAME $*
	debug-print "$FUNCNAME: version number is $QTVER"

	separate-string $QTVER ._ QTVER 5

	QTMAJORVER=QTVER[0]

	newdepend ">=x11-libs/qt-x11-$QTVER"

	set-qtdir

}












