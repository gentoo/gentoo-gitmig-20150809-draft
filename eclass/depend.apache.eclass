# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/depend.apache.eclass,v 1.5 2004/07/24 08:50:23 robbat2 Exp $

ECLASS="depend.apache"
INHERITED="$INHERITED $ECLASS"
IUSE="apache apache2"

# remember to set MY_SLOT if you want to include something like ${PVR} in
# the slot information
# SLOT="apache? ( 1{$MY_SLOT} ) apache2? ( 2{$MY_SLOT} ) !apache1? ( !apache2? ( 2${MY_SLOT} ) )"

DEPEND="$DEPEND apache? ( =net-www/apache-1* ) apache2? ( =net-www/apache-2* )
	    !apache? ( !apache2? ( =net-www/apache-2* ) )"

# call this function to work out which version of the apache web server
# your ebuild should be installing itself to use

detect_apache_useflags() {
	USE_APACHE1=
	USE_APACHE2=
	USE_APACHE_MULTIPLE=

	useq apache2 && USE_APACHE2=1
	useq apache  && USE_APACHE1=1

	[ -n "$USE_APACHE1" ] && [ -n "$USE_APACHE2" ] && USE_APACHE_MULTIPLE=1
}

detect_apache_installed() {
	HAS_APACHE1=
	HAS_APACHE2=
	HAS_APACHE_MULTIPLE=
	HAS_APACHE_ANY=

	has_version '=net-www/apache-1*' && HAS_APACHE1=1 && HAS_APACHE_ANY=1
	has_version '=net-www/apache-2*' && HAS_APACHE2=1 && HAS_APACHE_ANY=1

	[ -n "${HAVE_APACHE1}" ] && [ -n "${HAVE_APACHE2}" ] && HAVE_APACHE_MULTIPLE=1
}

# call this function from your pkg_setup

depend_apache() {
	detect_apache_installed
	detect_apache_useflags

	# deal with the multiple cases first - much easier
	if [ -n "$USE_APACHE_MULTIPLE" ]; then
		echo
		eerror "You have both the apache and apache2 USE flags set"
		eerror
		eerror "Please set only ONE of these USE flags, and try again"
		echo
		die "Multiple Apache USE flags set - you can only have one set at a time"
	fi

	if [ -n "$USE_APACHE2" ] ; then
		if  [ -z "$HAS_APACHE2" -a -n "$HAS_APACHE_ANY" ] ; then
			echo
			eerror "You have the 'apache2' USE flag set, but only have Apache v1 installed"
			eerror "If you really meant to upgrade to Apache v2, please install Apache v2"
			eerror "before installing $CATEGORY/${PN}-${PVR}"
			echo
			die "Automatic upgrade of Apache would be forced; avoiding"
		else
			einfo "Apache 2 support enabled"
			DETECT_APACHE=2
			return
		fi
	fi

	if [ -n "$USE_APACHE1" ]; then
		if [ -z "$HAS_APACHE1" -a -n "$HAS_APACHE_ANY" ]; then
			echo
			eerror "You have the 'apache' USE flag set, but only have a later version of"
			eerror "Apache installed on your computer.  Please use the 'apache2' USE flag"
			eerror "or downgrade to Apache v1 before installing $CATEGORY/${PN}-${PVR}"
			echo
			die "Avoiding installing older version of Apache"
		else
			einfo "Apache 1 support enabled"
			DETECT_APACHE=1
			return
		fi
	fi

	[ -z "$DETECT_APACHE" ] && DETECT_APACHE=2
}

