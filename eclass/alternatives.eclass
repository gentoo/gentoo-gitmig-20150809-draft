# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/alternatives.eclass,v 1.1 2003/10/07 17:21:40 liquidx Exp $

# Author :     Alastair Tse <liquidx@gentoo.org> (03 Oct 2003)
# Short Desc:  Creates symlink to the latest version of multiple slotted
#              packages.
#
# Long Desc:
#
#  When a package is SLOT'ed, very often we need to have a symlink to the
#  latest version. However, depending on the order the user has merged them,
#  more often than not, the symlink maybe clobbered by the older versions.
#
#  This eclass provides a convenience function that needs to be given a 
#  list of alternatives (descending order of recent-ness) and the symlink.
#  It will choose the latest version if can find installed and create
#  the desired symlink. 
#
#  There are two ways to use this eclass. First is by declaring two variables 
#  $SOURCE and $ALTERNATIVES where $SOURCE is the symlink to be created and 
#  $ALTERNATIVES is a list of alternatives. Second way is the use the function
#  alternatives_makesym() like the example below.
#
# Example:
#  
#  pkg_postinst() {
#      alternatives_makesym "/usr/bin/python" "/usr/bin/python2.3" "/usr/bin/python2.2"
#  }
#
#  The above example will create a symlink at /usr/bin/python to either
#  /usr/bin/python2.3 or /usr/bin/python2.2. It will choose python2.3 over
#  python2.2 if both exist.
#
#  Alternatively, you can use this function:
#
#  pkg_postinst() {
#     alternatives_auto_makesym "/usr/bin/python" "/usr/bin/python[0-9].[0-9]"
#  }
# 
#  This will use bash pathname expansion to fill a list of alternatives it can
#  link to. It is probably more robust against version upgrades. You should
#  consider using this unless you are want to do something special.
# 
ECLASS="alternatives"
INHERITED="$INHERITED $ECLASS"

# automatic deduction based on a symlink and a regex mask
alternatives_auto_makesym() {
	local SOURCE REGEX ALT
	local unsorted
	SOURCE=$1
	REGEX=$2

	ALT="`ls -1 ${ROOT}${REGEX} | sort -r | xargs`"
	if [ -n "${ALT}" ]; then
		alternatives_makesym ${SOURCE} ${ALT}
	else
		eerror "regex ${REGEX} doesn't match any files."
	fi		
}

alternatives_makesym() {
	local ALTERNATIVES=""
	local SOURCE=""
	
	# usage: alternatives_makesym <resulting symlink> [alternative targets..]
	SOURCE=$1
	shift
	ALTERNATIVES=$@

	# step through given alternatives from first to last
	# and if one exists, link it and finish.
	
	for alt in ${ALTERNATIVES}; do
		if [ -f "${ROOT}${alt}" ]; then
			if [ -L "${ROOT}${SOURCE}" ]; then
				rm -f ${ROOT}${SOURCE}
			fi
			einfo "Linking ${alt} to ${SOURCE}"
			ln -s ${alt} ${ROOT}${SOURCE}
			break
		fi
	done
	
	# report any errors
	if [ ! -L ${ROOT}${SOURCE} ]; then
		ewarn "Unable to establish ${SOURCE} symlink"
	elif [ ! -f "`readlink ${ROOT}${SOURCE}`" -a ! -f "${ROOT}`readlink ${ROOT}${SOURE}`" ]; then
		ewarn "${SOURCE} is a dead symlink."
	fi		
}		

alternatives_pkg_postinst() {
	if [ -n "${ALTERNATIVES}" -a -n "${SOURCE}" ]; then
		alternatives_makesym ${SOURCE} ${ALTERNATIVES}
	fi		
}

alternatives_pkg_postrm() {
	if [ -n "${ALTERNATIVES}" -a -n "${SOURCE}" ]; then
		alternatives_makesym ${SOURCE} ${ALTERNATIVES}
	fi
}

EXPORT_FUNCTIONS pkg_postinst pkg_postrm

