# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnuconfig.eclass,v 1.22 2004/07/09 19:22:40 agriffis Exp $
#
# Author: Will Woods <wwoods@gentoo.org>
#
# This eclass is used to automatically update files that typically come with
# automake to the newest version available on the system. The most common use
# of this is to update config.guess and config.sub when configure dies from
# misguessing your canonical system name (CHOST). It can also be used to update
# other files that come with automake, e.g. depcomp, mkinstalldirs, etc.
#
# usage: gnuconfig_update [file1 file2 ...]
# if called without arguments, config.guess and config.sub will be updated.
# All files in the source tree ($S) with the given name(s) will be replaced
# with the newest available versions chosen from the list of locations in
# gnuconfig_findnewest(), below.

ECLASS=gnuconfig
INHERITED="$INHERITED $ECLASS"

DEPEND="sys-devel/gnuconfig"

DESCRIPTION="Based on the ${ECLASS} eclass"

# Wrapper function for gnuconfig_do_update. If no arguments are given, update
# config.sub and config.guess (old default behavior), otherwise update the
# named files.
gnuconfig_update() {
	if [ $# -gt 0 ] ; then
		gnuconfig_do_update "$@"
	else
		gnuconfig_do_update config.sub config.guess
	fi

	return $?
}

# Copy the newest available version of specified files over any old ones in the
# source dir. This function shouldn't be called directly - use gnuconfig_update
gnuconfig_do_update() {
	local startdir configsubs_dir target targetlist file

	if [[ ${1} == /* ]]; then
		startdir=${1%/}		# remove possible trailing slash
		shift
	else
		startdir=${S}
	fi

	[ $# -eq 0 ] && die "do not call gnuconfig_do_update; use gnuconfig_update"

	configsubs_dir="$(gnuconfig_findnewest)"
	einfo "Using GNU config files from ${configsubs_dir}"
	for file in "$@" ; do
		if [ ! -r ${configsubs_dir}/${file} ] ; then
			eerror "Can't read ${configsubs_dir}/${file}, skipping.."
			continue
		fi
		targetlist=`find "${startdir}" -name "${file}"`
		if [ -n "$targetlist" ] ; then
			for target in $targetlist; do
				einfo " Updating ${target/$startdir\//}"
				cp -f ${configsubs_dir}/${file} "${target}"
				eend $?
			done
		else
			ewarn " No ${file} found in ${startdir}, skipping.."
		fi
	done

	return 0
}

# this searches the standard locations for the newest config.{sub|guess}, and
# returns the directory where they can be found.
gnuconfig_findnewest() {
	local locations="/usr/share/gnuconfig/config.sub \
	                 /usr/share/automake-1.8/config.sub \
	                 /usr/share/automake-1.7/config.sub \
	                 /usr/share/automake-1.6/config.sub \
	                 /usr/share/automake-1.5/config.sub \
	                 /usr/share/automake-1.4/config.sub"
	local lt_location="/usr/share/libtool/config.sub"

	[ -f "${lt_location}" ] && locations="${locations} ${lt_location}"
	
	grep -s '^timestamp' ${locations} | sort -n -t\' -k2 | tail -n 1 | sed 's,/config.sub:.*$,,'
}
