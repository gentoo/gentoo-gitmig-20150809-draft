# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-child.eclass,v 1.2 2002/07/12 15:24:36 danarmak Exp $
# Inherited by children ebuilds, which must specify their $PARENT ebuild before inheriting.
ECLASS=kde-child
INHERITED="$INHERITED $ECLASS"
#TODO: prevent $S/README, etc. from being dodoc'd

# determine settings
# Rename to $SIBLINGS? :-)
[ -z "$SUBDIRS" ] && SUBDIRS="$PN doc"

if [ -z "$PARENT" ]; then
	einfo "!!! $ECLASS: error: kde-child sourced, but \$PARENT not defined. Please report this bug."
	exit 1
fi

debug-print "$ECLASS: beginning, PARENT=$PARENT, SUBDIRS=$SUBDIRS"

# source parent ebuild
debug-print "$ECLASS: sourcing ${PORTDIR}/${PARENT}"
source "/usr/portage/${PARENT}"

ECLASS=kde-child
DESCRIPTION="Based on the $ECLASS eclass"

# no master-side src_unpack mods allowed atm
kde-child_src_unpack () {

	base_src_unpack

	cd ${S}
	# convert spaces to newlines
	mv subdirs subdirs.orig
	for x in $SUBDIRS; do
		debug-print "$FUNCNAME: parsing \$SUBDIRS: adding $x to subdirs"
		echo $x >> subdirs
	done
	rm subdirs.orig

	# we always do this, but it won't take effect unless doc is in $SUBDIRS!
	if [ -d doc ]; then
		cd doc
		DOCSUBDIRS=""
		for x in $SUBDIRS; do
			[ -d "$x" ] && DOCSUBDIRS="$DOCSUBDIRS $x"
		done
		debug-print "$FUNCNAME: doc subdir detected, found DOCSUBDIRS=$DOCSUBDIRS"
		mv Makefile.am Makefile.am.orig
		sed -e "s:SUBDIRS = \$(AUTOSUBDIRS):SUBDIRS = $DOCSUBDIRS:" Makefile.am.orig > Makefile.am
		mv Makefile.in Makefile.in.orig
		sed -e "s:SUBDIRS =. :SUBDIRS =. $DOCSUBDIRS \#:" Makefile.in.orig > Makefile.in
		rm Makefile.in.orig Makefile.am.orig
	fi

	# if asked, enable non-default packages
	if [ -n "$FORCE" ]; then
		cd ${S}
		for x in $FORCE; do
			for y in configure configure.in; do
				mv $y $y.orig
				sed -e "s:DO_NOT_COMPILE=\"\$DO_NOT_COMPILE ${x}\":\#:" $y.orig > $y
				rm $y.orig
			done
		done
		chmod +x configure
	fi

	# Finally, delete all top-level subdirs except for those in $SUBDIRS
	# and admin and doc. This way we both save space and locate any
	# subdir interdependencies.
	cd ${S}
	for x in *
	do
		# process all directories
		if [ -d "$x" ]; then

			KEEP=false

			# check if $x is in $SUBDIRS, if it is we should keep it
			case "$SUBDIRS admin" in
				*$x*) KEEP=true;;
			esac

			# remove it if we decided not to keep it
			if [ "$KEEP" == "false" ]; then

				debug-print "$FUNCNAME: removing subdir $x"

				# make sure configure doesn't try to create makefiles in the 
				# directories we're removing
				echo "./admin/configure.in.min
configure.in.in" > configure.files
				find $x -iname configure.in.in >> configure.files

				# finally, remove it
				rm -rf $x
				rm -rf doc/$x

			else
				debug-print "$FUNCNAE: keeping subdir $x"
			fi

		fi
	done

}

EXPORT_FUNCTIONS src_unpack


