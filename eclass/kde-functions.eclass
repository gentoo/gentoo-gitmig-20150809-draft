# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-functions.eclass,v 1.57 2003/06/10 15:12:02 danarmak Exp $
#
# Author Dan Armak <danarmak@gentoo.org>
#
# This contains everything except things that modify ebuild variables
# and functions (e.g. $P, src_compile() etc.)

ECLASS=kde-functions
INHERITED="$INHERITED $ECLASS"
# convinience functions for requesting autotools versions
need-automake() {

	debug-print-function $FUNCNAME $*

	unset WANT_AUTOMAKE_1_4
	unset WANT_AUTOMAKE_1_5
	unset WANT_AUTOMAKE_1_6
	unset WANT_AUTOMAKE

	case $1 in
		1.4)	export WANT_AUTOMAKE_1_4=1;;
		1.5)	export WANT_AUTOMAKE_1_5=1;;
		1.6)	export WANT_AUTOMAKE_1_6=1;;
		1.7)	export WANT_AUTOMAKE='1.7';;
		*)		echo "!!! $FUNCNAME: Error: unrecognized automake version $1 requested";;
	esac

}

need-autoconf() {

	debug-print-function $FUNCNAME $*

	unset WANT_AUTOCONF_2_1
	unset WANT_AUTOCONF_2_5

	case $1 in
		2.1)	export WANT_AUTOCONF_2_1=1;;
		2.5)	export WANT_AUTOCONF_2_5=1;;
		*)		echo "!!! $FUNCNAME: Error: unrecognized autoconf version $1 requested";;
	esac

}


# ---------------------------------------------------------------
# kde/qt directory management etc. functions, was kde-dirs.ebuild
# ---------------------------------------------------------------

need-kde() {

	debug-print-function $FUNCNAME $*
	KDEVER="$1"

	# determine install locations
	set-kdedir $KDEVER

	# ask for autotools
	case "$KDEVER" in
		2*)
			need-autoconf 2.1
			need-automake 1.4
			;;
		3.1*)	# actually, newer 3.0.x stuff uses this too, but i want to make a clean switch
			need-automake 1.6
			need-autoconf 2.5
			;;
		3*)	# a generic call for need-kde 3 - automake 1.4 works most often
			need-autoconf 2.5
			need-automake 1.4
			;;
		5*)
			need-autoconf 2.5
			need-automake 1.6
			;;
	esac

	# Things that need more special handling can just set NEED_KDE_DONT_ADD_KDELIBS_DEP
	# and add one of their own manually.
	if [ -n "$NEED_KDE_DONT_ADD_KDELIBS_DEP" ]; then
		# do nothing
		debug-print "$FUNCNAME: NEED_KDE_DONT_ADD_KDELIBS_DEP set, complying with request"
	elif [ "${INHERITED//kde-dist}" != "$INHERITED" ]; then
		# if we're a kde-base package, we need an exact version of kdelibs
		# to compile correctly.
		# all kinds of special cases live here.
		# goes to show this code is awfully inflexible, i guess.
		# maybe i should look at relocating it...
		if [ "$PV" == "3.0.3" ]; then
			newdepend "=kde-base/kdelibs-3.0.3*"
		elif [ "$PV" == "3.1.1" ]; then
			newdepend "=kde-base/kdelibs-3.1.1*"
		elif [ "$PV" == "2.2.2" ]; then
			newdepend "=kde-base/kdelibs-2.2.2*"
		else
			newdepend "~kde-base/kdelibs-${KDEVER}"
		fi
	else
		# everything else only needs a minimum version
		if [ "$KDEMAJORVER" == "2" ]; then
			newdepend "=kde-base/kdelibs-2.2*"
		else
			min-kde-ver $KDEVER
			newdepend ">=kde-base/kdelibs-${selected_version}"
		fi
	fi

	qtver-from-kdever $KDEVER
	need-qt $selected_version

	if [ -n "$KDEBASE" ]; then
		SLOT="$KDEMAJORVER.$KDEMINORVER"
	else
		SLOT="0"
	fi

}

set-kdedir() {

	debug-print-function $FUNCNAME $*


	# set install location:
	# - 3rd party apps go into /usr, and have SLOT="0".
	# - kde-base category ebuilds go into /usr/kde/$MAJORVER.$MINORVER,
	# and have SLOT="$MAJORVER.$MINORVER".
	# - kde-base category cvs ebuilds have major version 5 and go into
	# /usr/kde/cvs; they have SLOT="cvs".
	# - Backward-compatibility exceptions: all kde2 packages (kde-base or otherwise)
	# go into /usr/kde/2. kde 3.0.x goes into /usr/kde/3 (and not 3.0).
	# - kde-base category ebuilds always depend on their exact matching version of
	# kdelibs and link against it. Other ebuilds link aginst the latest one found.
	# - This function exports $PREFIX (location to install to) and $KDEDIR
	# (location of kdelibs to link against) for all ebuilds.
	#
	# -- Overrides - deprecated but working for now: --
	# - If $KDEPREFIX is defined (in the profile or env), it overrides everything
	# and both base and 3rd party kde stuff goes in there.
	# - If $KDELIBSDIR is defined, the kdelibs installed in that location will be
	# used, even by kde-base packages.

	# get version elements
	IFSBACKUP="$IFS"
	IFS=".-_"
	for x in $1; do
		if [ -z "$KDEMAJORVER" ]; then KDEMAJORVER=$x
		else if [ -z "$KDEMINORVER" ]; then KDEMINORVER=$x
		else if [ -z "$KDEREVISION" ]; then KDEREVISION=$x
		fi; fi; fi
	done
	[ -z "$KDEMINORVER" ] && KDEMINORVER="0"
	[ -z "$KDEREVISION" ] && KDEREVISION="0"
	IFS="$IFSBACKUP"
	debug-print "$FUNCNAME: version breakup: KDEMAJORVER=$KDEMAJORVER KDEMINORVER=$KDEMINORVER KDEREVISION=$KDEREVISION"

	# install prefix
	if [ -n "$KDEPREFIX" ]; then
		export PREFIX="$KDEPREFIX"
	elif [ "$KDEMAJORVER" == "2" ]; then
		export PREFIX="/usr/kde/2"
	else
		if [ -z "$KDEBASE" ]; then
			export PREFIX="/usr"
		else
			case $KDEMAJORVER.$KDEMINORVER in
				3.0) export PREFIX="/usr/kde/3";;
				3.1) export PREFIX="/usr/kde/3.1";;
				3.2) export PREFIX="/usr/kde/3.2";;
				5.0) export PREFIX="/usr/kde/cvs";;
			esac
		fi
	fi

	# kdelibs location
	if [ -n "$KDELIBSDIR" ]; then
		export KDEDIR="$KDELIBSDIR"
	elif [ "$KDEMAJORVER" == "2" ]; then
		export KDEDIR="/usr/kde/2"
	else
		if [ -z "$KDEBASE" ]; then
			# find the latest kdelibs installed
			for x in /usr/kde/{cvs,3.2,3.1,3.0,3} $PREFIX $KDE3LIBSDIR $KDELIBSDIR $KDE3DIR $KDEDIR /usr/kde/*; do
				if [ -f "${x}/include/kwin.h" ]; then
					debug-print found
					export KDEDIR="$x"
					break
				fi
			done
		else
			# kde-base ebuilds msut always use the exact version of kdelibs they came with
			case $KDEMAJORVER.$KDEMINORVER in
				3.0) export KDEDIR="/usr/kde/3";;
				3.1) export KDEDIR="/usr/kde/3.1";;
				3.2) export KDEDIR="/usr/kde/3.2";;
				5.0) export KDEDIR="/usr/kde/cvs";;
			esac
		fi
	fi


	# check that we've set everything
	[ -z "$PREFIX" ] && debug-print "$FUNCNAME: ERROR: could not set install prefix"
	[ -z "$KDEDIR" ] && debug-print "$FUNCNAME: ERROR: couldn't set kdelibs location"

	debug-print "$FUNCNAME: Will use the kdelibs installed in $KDEDIR, and install into $PREFIX."

}

need-qt() {

	debug-print-function $FUNCNAME $*
	QTVER="$1"

	QT=qt

	case $QTVER in
	    2*)	newdepend "=x11-libs/${QT}-2.3*" ;;
	    3*)	newdepend ">=x11-libs/${QT}-${QTVER}" ;;
	    *)	echo "!!! error: $FUNCNAME() called with invalid parameter: \"$QTVER\", please report bug" && exit 1;;
	esac

	set-qtdir $QTVER

}

set-qtdir() {

	debug-print-function $FUNCNAME $*


	# select 1st element in dot-separated string
	IFSBACKUP=$IFS
	IFS="."
	QTMAJORVER=""
	for x in $1; do
		[ -z "$QTMAJORVER" ] && QTMAJORVER=$x
	done
	IFS=$IFSBACKUP

	export QTDIR="/usr/qt/$QTMAJORVER"

	# i'm putting this here so that the maximum amount of qt/kde apps gets it -- danarmak
	# if $QTDIR/etc/settings/qtrc file exists, the qt build tools try to create
	# a .qtrc.lock file in that directory. It's easiest to allow them to do so.
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"

}

# returns minimal qt version needed for specified kde version
qtver-from-kdever() {

	debug-print-function $FUNCNAME $*

	local ver

	case $1 in
		2*)	ver=2.3.1;;
		3.1*)	ver=3.1;;
		3*)	ver=3.0.5;;
		5)	ver=3.1;; # cvs version
		*)	echo "!!! error: $FUNCNAME called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac

	selected_version="$ver"

}

# compat - not used anymore, but old ebuilds that once used this fail if it's not present
# when they are unmerged
need-kdelibs() {
	echo "WARNING: need-kdelibs() called, where need-kde() is correct.
If this happens at the unmerging of an old ebuild, disregard; otherwise report."
	need-kde $*
}

min-kde-ver() {

	debug-print-function $FUNCNAME $*

	case $1 in
		2*)				selected_version="2.2.2";;
		3.0_beta1)		selected_version="3.0_beta1";;
		3.0_beta2)		selected_version="3.0_beta2";;
		3.0_rc1)			selected_version="3.0_rc1";;
		3.0_rc2)			selected_version="3.0_rc2";;
		3.0_rc3)			selected_version="3.0_rc3";;
		3.0)				selected_version="3.0";;
		3.0.*)			selected_version="3.0";;
		3.1_alpha1)		selected_version="3.1_alpha1";;
		3.1_beta1)		selected_version="3.1_beta1";;
		3.1_beta2)		selected_version="3.1_beta2";;
		3.1_rc1)		selected_version="3.1_rc1";;
		3.1_rc2)		selected_version="3.1_rc2";;
		3.1_rc3)		selected_version="3.1_rc3";;
		3.1_rc5)		selected_version="3.1_rc5";;
		3.1_rc6)		selected_version="3.1_rc6";;
		3.1.*)			selected_version="3.1";;
		3*)				selected_version="3.0";;
		5)					selected_version="5";;
		*)					echo "!!! error: $FUNCNAME() called with invalid parameter: \"$1\", please report bug" && exit 1;;
	esac

}

# generic makefile sed for sandbox compatibility. for some reason when the kde makefiles (of many packages
# and versions) try to chown root and chmod 4755 some binaries (after installing, target isntall-exec-local),
# they do it to the files in $(bindir), not $(DESTDIR)/$(bindir). Most of these have been fixed in latest cvs
# but a few remain here and there.
# Pass a list of dirs to sed, Makefile.{am,in} in these dirs will be sed'ed.
# This should be harmless if the makefile doesn't need fixing.
kde_sandbox_patch() {

	debug-print-function $FUNCNAME $*

	while [ -n "$1" ]; do
	# can't use dosed, because it only works for things in ${D}, not ${S}
	cd $1
	for x in Makefile.am Makefile.in Makefile
	do
		if [ -f "$x" ]; then
			echo Running sed on $x
			cp $x ${x}.orig
			sed -e 's: $(bindir): $(DESTDIR)/$(bindir):g' -e 's: $(kde_datadir): $(DESTDIR)/$(kde_datadir):g' -e 's: $(TIMID_DIR): $(DESTDIR)/$(TIMID_DIR):g' ${x}.orig > ${x}
			rm ${x}.orig
		fi
	done
	shift
	done

}


# remove an optimization flag from a specific subdirectory's makefiles.
# currently kdebase and koffice use it to compile certain subdirs without
# -fomit-frame-pointer which breaks some things.
# Parameters:
# $1: subdirectory
# $2: flag to remove
kde_remove_flag() {

	debug-print-function $FUNCNAME $*

	cd ${S}/${1} || die
	[ -n "$2" ] || die

	cp Makefile Makefile.orig
	sed -e "/CFLAGS/ s/${2}//g
/CXXFLAGS/ s/${2}//g" Makefile.orig > Makefile

	cd $OLDPWD

}

# disable a subdir of a module from building.
# used by kdemultimedia et al
# autorun from kde_src_compile:configure if $KDE_REMOVE_DIR is set;
# $KDE_REMOVE_DIR is then passed as parameter
kde_remove_dir(){

	debug-print-function $FUNCNAME $*

	cd ${S}

	while [ -n "$1" ]; do
		for dir in $1; do

			debug-print "$FUNCNAME: removing subdirectory $dir"

			rm -rf $dir

			if [ -f subdirs ]; then
				mv subdirs subdirs.orig
				grep -v $dir subdirs.orig > subdirs
			fi

			rm -f configure configure.in

			export DO_NOT_COMPILE="$DO_NOT_COMPILE $dir"

		done
	shift
	done

}

# new convinience patch wapper function to eventually replace epatch(), $PATCHES, $PATCHES1, src_unpack:patch, src_unpack:autopatch and /usr/bin/patch
# Features:
# - bulk patch handling similar to epatch()'s
# - automatic patch level detection like epatch()'s
# - semiautomatic patch uncompression like epatch()'s (may switch to using /usr/bin/file for extra power, instead of just looking at the filename)
# - doesn't have the --dry-run overhead of epatch() - inspects patchfiles manually instead
# - is called from base_src_unpack to handle $PATCHES to avoid defining src_unpack(-) just to use xpatch
# - generally configurable - accepts parameters for patch, complex specifications of patchfiles, etc like epatch() does

# accepts zero or more parameters specifying patchfiles and/or patchdirs

# known issues:
# - only supports unified style patches (does anyone _really_ use anything else?)
# - first file addressed in a patch can't have spaces in its name or in the path mentioned in the patchfile
# (can be easily fixed to be: at least one file addressed in the patch must have no spaces...)
xpatch() {

	debug-print-function $FUNCNAME $*

	local list=""
	local list2=""
	declare -i plevel

	# parse patch sources
	for x in $*; do
		debug-print "$FUNCNAME: parsing parameter $x"
		if [ -f "$x" ]; then
			list="$list $x"
		elif [ -d "$x" ]; then
			# handles patchdirs like epatch() for now: no recursion.
			# patches are sorted by filename, so with an xy_foo naming scheme you'll get the right order.
			# only patches with _$ARCH_ or _all_ in their filenames are applied.
			for file in `ls -A $x`; do
				debug-print "$FUNCNAME:  parsing in subdir: file $file"
				if [ -f "$x/$file" ] && [ "${file}" != "${file/_all_}" -o "${file}" != "${file/_$ARCH_}" ]; then
					list2="$list2 $x/$file"
				fi
			done
			list="`echo $list2 | sort` $list"
		else
			die "Couldn't find $x"
		fi
	done

	debug-print "$FUNCNAME: final list of patches: $list"

	for x in $list; do
		debug-print "$FUNCNAME: processing $x"
		# deal with compressed files. /usr/bin/file is in the system profile, or should be.
		case "`/usr/bin/file -b $x`" in
			*gzip*) patchfile="${T}/current.patch"; ungzip -c "$x" > "${patchfile}";;
			*bzip2*) patchfile="${T}/current.patch"; bunzip2 -c "$x" > "${patchfile}";;
			*text*) patchfile="$x";;
			*) die "Could not determine filetype of patch $x";;
		esac
		debug-print "$FUNCNAME: patchfile=$patchfile"

		# determine patchlevel. supports p0 and higher with either $S or $WORKDIR as base.
		target="`/bin/grep '+++' $patchfile | /usr/bin/tail -1`"
		debug-print "$FUNCNAME: raw target=$target"
		# strip target down to the path/filename. NOTE doesn't support filenames/paths with spaces in them :-(
		# remove leading +++
		target="${target/+++ }"
		# ugly, yes. i dunno why doesn't this work instead: target=${target%% *}
		for foo in $target; do target="$foo"; break; done
		# duplicate slashes are discarded by patch wrt the patchlevel. therefore we need to discard them as well
		# to calculate the correct patchlevel.
		while [ "$target" != "${target/\/\/}" ]; do
			target="${target/\/\//\/}"
		done
		debug-print "$FUNCNAME: stripped target=$target"

		# look for target
		for basedir in "$S" "$WORKDIR" "`pwd`"; do
			debug-print "$FUNCNAME: looking in basedir=$basedir"
			cd "$basedir"

			# try stripping leading directories
			target2="$target"
			plevel=0
			debug-print "$FUNCNAME: trying target2=$target2, plevel=$plevel"
			while [ ! -f "$target2" ]; do
				target2="${target2#*/}" # removes piece of target2 upto the first occurence of /
				plevel=plevel+1
				debug-print "$FUNCNAME: trying target2=$target2, plevel=$plevel"
				[ "$target2" == "${target2/\/}" ] && break
			done
			test -f "$target2" && break

			# try stripping filename - needed to support patches creating new files
			target2="${target%/*}"
			plevel=0
			debug-print "$FUNCNAME: trying target2=$target2, plevel=$plevel"
			while [ ! -d "$target2" ]; do
				target2="${target2#*/}" # removes piece of target2 upto the first occurence of /
				plevel=plevel+1
				debug-print "$FUNCNAME: trying target2=$target2, plevel=$plevel"
				[ "$target2" == "${target2/\/}" ] && break
			done
			test -d "$target2" && break

		done

		test -f "${basedir}/${target2}" || test -d "${basedir}/${target2}" || die "Could not determine patchlevel for $x"
		debug-print "$FUNCNAME: determined plevel=$plevel"
		# do the patching
		ebegin "Applying patch ${x##*/}..."
		/usr/bin/patch -p$plevel < "$patchfile" > /dev/null || die "Failed to apply patch $x"
		eend $?

	done

}

# is this a kde-base ebuid?
case $PN in kde-i18n*|arts|kdeaddons|kdeadmin|kdeartwork|kdebase|kdebindings|kdeedu|kdegames|kdegraphics|kdelibs|kdemultimedia|kdenetwork|kdepim|kdesdk|kdetoys|kdeutils|kdelibs-apidocs)
		debug-print "$ECLASS: KDEBASE ebuild recognized"
		export KDEBASE="true"
		;;
esac

