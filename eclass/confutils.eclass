# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/confutils.eclass,v 1.5 2004/07/21 16:25:34 stuart Exp $
#
# eclass/confutils.eclass
#		Utility functions to help with configuring a package
#
#		Based on Stuart's work for the PHP 5 eclass
#
# Author(s)		Stuart Herbert
#				<stuart@gentoo.org>
#
# ========================================================================

IUSE="$IUSE shared"

# ========================================================================

# list of USE flags that need deps that aren't yet in Portage
# this list was originally added for PHP

CONFUTILS_MISSING_DEPS="adabas birdstep cpdflib qdbm db2 dbmaker empress empress-bcs esoob filepro frontbase hyperwave-api informix ingres interbase mcve mnogosearch msession msql oci8 oracle7 ovirmos pfpro sapdb solid sybase sybase-ct"

# ========================================================================
# confutils_init ()
#
# Call this function from your src_compile() function to initialise
# this eclass first

confutils_init () {
	if useq shared ; then
		shared="=shared"
	else
		shared=
	fi
}

# ========================================================================
# confutils_use_conflict ()
#
# Use this function to automatically complain to the user if conflicting
# USE flags have been enabled
#
# $1	- flag that depends on other flags
# $2 .. - flags that conflict

confutils_use_conflict () {
	if ! useq $1 ; then
		return
	fi

	local my_flag="$1"
	shift

	local my_present=
	local my_remove=

	while [ "$1+" != "+" ]; do
		if useq $1 ; then
			my_present="${my_present} $1"
			my_remove="${my_remove} -$1"
		fi
		shift
	done

	if [ -n "$my_present" ]; then
		echo
		eerror "USE flag '$my_flag' conflicts with these USE flag(s):"
		eerror "  $my_present"
		eerror
		eerror "You must disable these conflicting flags before you can emerge this package."
		eerror "You can do this by disabling these flags in /etc/portage/package.use:"
		eerror "    =$CATEGORY/$PN-$PVR: $my_remove"
		eerror
		die "Conflicting USE flags"
	fi
}

# ========================================================================
# confutils_use_depend_all ()
#
# Use this function to automatically complain to the user if a USE flag
# depends on another USE flag that hasn't been enabled
#
# $1	- flag that depends on other flags
# $2 .. - the flags that must be set for $1 to be valid

confutils_use_depend_all () {
	if ! useq $1 ; then
		return
	fi

	local my_flag="$1"
	shift

	local my_missing=

	while [ "$1+" != "+" ]; do
		if ! useq $1 ; then
			my_missing="${my_missing} $1"
		fi
		shift
	done

	if [ -n "$my_missing" ]; then
		echo
		eerror "USE flag '$my_flag' needs these additional flag(s) set:"
		eerror "  $my_missing"
		eerror
		eerror "You can do this by enabling these flags in /etc/portage/package.use:"
		eerror "    =$CATEGORY/$PN-$PVR: $my_missing"
		eerror
		eerror "You could disable this flag instead in /etc/portage/package.use:"
		eerror "	=$CATEGORY/$PN-$PVR: -$my_flag"
		echo

		die "Need missing USE flags"
	fi
}

# ========================================================================
# confutils_use_depend_any ()
#
# Use this function to automatically complain to the user if a USE flag
# depends on another USE flag that hasn't been enabled
#
# $1	- flag that depends on other flags
# $2 .. - flags that must be set for $1 to be valid

confutils_use_depend_any () {
	if ! useq $1 ; then
		return
	fi

	local my_flag="$1"
	shift

	local my_found=
	local my_missing=

	while [ "$1+" != "+" ]; do
		if useq $1 ; then
			my_found="${my_found} $1"
		else
			my_missing="${my_missing} $1"
		fi
		shift
	done

	if [ -z "$my_found" ]; then
		echo
		eerror "USE flag '$my_flag' needs one of these additional flag(s) set:"
		eerror "  $my_missing"
		eerror
		eerror "You can do this by enabling one of these flags in /etc/portage/package.use"
		eerror
		die "Need missing USE flag"
	fi
}

# ========================================================================
# enable_extension_disable ()
#
# Use this function to disable an extension that is enabled by default.
# This is provided for those rare configure scripts that don't support
# a --enable for the corresponding --disable
#
# $1	- extension name
# $2	- USE flag

enable_extension_disable () {
	if ! useq "$2" ; then
		my_conf="${my_conf} --disable-$1"
	fi
}

# ========================================================================
# enable_extension_enable () 
#
# This function is like use_enable(), except that it knows about
# enabling modules as shared libraries, and it supports passing
# additional data with the switch
#
# $1	- extension name
# $2	- USE flag
# $3	- 1 = support shared, 0 = never support shared
# $4	- additional setting for configure

enable_extension_enable () {
	local my_shared

	if [ "$3" == "1" ]; then
		if [ "$shared+" != "+" ]; then
			my_shared="${shared}"
			if [ "$4+" != "+" ]; then
				my_shared="${my_shared},$4"
			fi
		fi
	else
		if [ "$4+" != "+" ]; then
			my_shared="=$4"
		fi
	fi

	if useq $2 ; then
		my_conf="${my_conf} --enable-$1$my_shared"
	else
		my_conf="${my_conf} --disable-$1"
	fi
}

# ========================================================================
# enable_extension_without ()
#
# Use this function to disable an extension that is enabled by default
# This function is provided for those rare configure scripts that support
# --without but not the corresponding --with
#
# $1	- extension name
# $2	- USE flag

enable_extension_without () {
	if ! useq "$2" ; then
		my_conf="${my_conf} --without-$1"
	fi
}

# ========================================================================
# enable_extension_with ()
#
# This function is a replacement for use_with.  It supports building
# extensions as shared libraries,

# $1	- extension name
# $2	- USE flag
# $3	- 1 = support shared, 0 = never support shared
# $4	- additional setting for configure

enable_extension_with () {
	local my_shared

	if [ "$3" == "1" ]; then
		if [ "$shared+" != "+" ]; then
			my_shared="${shared}"
			if [ "$4+" != "+" ]; then
				my_shared="${my_shared},$4"
			fi
		fi
	else
		if [ "$4+" != "+" ]; then
			my_shared="=$4"
		fi
	fi

	if useq $2 ; then
		my_conf="${my_conf} --with-$1$my_shared"
	else
		my_conf="${my_conf} --without-$1"
	fi
}

# ========================================================================
# confutils_warn_about_external_deps

confutils_warn_about_missing_deps ()
{
	local x
	local my_found=0

	for x in $CONFUTILS_MISSING_DEPS ; do
		if useq $x ; then
			ewarn "USE flag $x enables support for software not in Portage"
			my_found=1
		fi
	done

	if [ "$my_found" = "1" ]; then
		ewarn
		ewarn "This ebuild will continue, but if you haven't already installed the"
		ewarn "software required to satisfy the list above, this package will probably"
		ewarn "fail to compile."
		ewarn
		sleep 5
	fi
}
