# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/webapp.eclass,v 1.4 2004/03/03 18:44:34 stuart Exp $
#
# eclass/webapp.eclass
#				Eclass for installing applications to run under a web server
#
#				Part of the implementation of GLEP #11
#
# Author(s)		Stuart Herbert <stuart@gentoo.org>
#
# ------------------------------------------------------------------------
#
# Please do not make modifications to this file without checking with a
# member of the web-apps herd first!
#
# ------------------------------------------------------------------------

ECLASS=webapp
INHERITED="$INHERITED $ECLASS"
SLOT="${PVR}"
IUSE="$IUSE vhosts"
G_HASCONFIG=1

if [ -f /etc/conf.d/webapp-config ] ; then
	. /etc/conf.d/webapp-config
else
	G_HASCONFIG=0
fi

EXPORT_FUNCTIONS pkg_config pkg_setup src_install

# ------------------------------------------------------------------------
# INTERNAL FUNCTION - USED BY THIS ECLASS ONLY
#
# Check whether a specified file exists within the image/ directory
# or not.
#
# @param 	$1 - file to look for
# @param	$2 - prefix directory to use
# @return	0 on success, never returns on an error
# ------------------------------------------------------------------------

function webapp_checkfileexists ()
{
	if [ ! -e $1 ]; then
		msg="ebuild fault: file $1 not found"
		eerror "$msg"
		eerror "Please report this as a bug at http://bugs.gentoo.org/"
		die "$msg"
	fi
}

# ------------------------------------------------------------------------
# INTERNAL FUNCTION - USED BY THIS ECLASS ONLY
# ------------------------------------------------------------------------

function webapp_import_config ()
{
	if [ -z "${MY_HTDOCSDIR}" ]; then
		. /etc/conf.d/webapp-config
	fi

	if [ -z "${MY_HTDOCSDIR}" ]; then
		libsh_edie "/etc/conf.d/webapp-config not imported"
	fi
}

# ------------------------------------------------------------------------
# INTERNAL FUNCTION - USED BY THIS ECLASS ONLY
#
# ------------------------------------------------------------------------

function webapp_strip_appdir ()
{
	echo "$1" | sed -e "s|${MY_APPDIR}/||g;"
}

function webapp_strip_d ()
{
	echo "$1" | sed -e "s|${D}||g;"
}

function webapp_strip_cwd ()
{
	echo "$1" | sed -e 's|/./|/|g;'
}

# ------------------------------------------------------------------------
# EXPORTED FUNCTION - FOR USE IN EBUILDS
#
# Identify a config file for a web-based application.
#
# @param	$1 - config file
# ------------------------------------------------------------------------

function webapp_configfile ()
{
	webapp_checkfileexists "$1" "$D"
	local MY_FILE="`webapp_strip_appdir $1`"

	einfo "(config) $MY_FILE"
	echo "$MY_FILE" >> $WA_CONFIGLIST
}

# ------------------------------------------------------------------------
# EXPORTED FUNCTION - FOR USE IN EBUILDS
#
# Identify a script file (usually, but not always PHP or Perl) which is
#
# Files in this list may be modified to #! the required CGI engine when
# installed by webapp-config tool in the future.
#
# @param	$1 - the cgi engine to use
# @param	$2 - the script file that could run under a cgi-bin
#
# ------------------------------------------------------------------------

function webapp_runbycgibin ()
{
	webapp_checkfileexists "$2" "$D"
	local MY_FILE="`webapp_strip_appdir $2`"
	MY_FILE="`webapp_strip_cwd $MY_FILE`"

	einfo "(cgi-bin) $1 - $MY_FILE"
	echo "$1 $MY_FILE" >> $WA_RUNBYCGIBINLIST
}

# ------------------------------------------------------------------------
# EXPORTED FUNCTION - FOR USE IN EBUILDS
#
# Identify a file which must be owned by the webserver's user:group
# settings.
#
# The ownership of the file is NOT set until the application is installed
# using the webapp-config tool.
# 
# @param	$1 - file to be owned by the webserver user:group combo
#
# ------------------------------------------------------------------------

function webapp_serverowned ()
{
	webapp_checkfileexists "$1" "$D"
	local MY_FILE="`webapp_strip_appdir $1`" 
	
	einfo "(server owned) $MY_FILE"
	echo "$MY_FILE" >> $WA_SOLIST
}

# ------------------------------------------------------------------------
# EXPORTED FUNCTION - FOR USE IN EBUILDS
#
#
# @param	$1 - the db engine that the script is for
#				 (one of: mysql|postgres)
# @param	$2 - the sql script to be installed
# @param	$3 - the older version of the app that this db script
#				 will upgrade from
#				 (do not pass this option if your SQL script only creates
#				  a new db from scratch)
# ------------------------------------------------------------------------

function webapp_sqlscript ()
{
	webapp_checkfileexists "$2"

	# create the directory where this script will go
	#
	# scripts for specific database engines go into their own subdirectory
	# just to keep things readable on the filesystem

	if [ ! -d "${MY_SQLSCRIPTSDIR}/$1" ]; then
		mkdir -p "${MY_SQLSCRIPTSDIR}/$1" || libsh_die "unable to create directory ${MY_SQLSCRIPTSDIR}/$1"
	fi

	# warning:
	#
	# do NOT change the naming convention used here without changing all
	# the other scripts that also rely upon these names
 
	# are we dealing with an 'upgrade'-type script?
	if [ -n "$3" ]; then
		# yes we are
		einfo "($1) upgrade script from ${PN}-${PVR} to $3"
		cp $2 ${MY_SQLSCRIPTSDIR}/$1/${3}_to_${PVR}.sql
	else
		# no, we are not
		einfo "($1) create script for ${PN}-${PVR}"
		cp $2 ${MY_SQLSCRIPTSDIR}/$1/${PVR}_create.sql
	fi
}

# ------------------------------------------------------------------------
# EXPORTED FUNCTION - call from inside your ebuild's src_install AFTER
# everything else has run
#
# For now, we just make sure that root owns everything, and that there
# are no setuid files.  I'm sure this will change significantly before
# the final version!
# ------------------------------------------------------------------------

function webapp_src_install ()
{
	chown -R root:root ${D}/
	chmod -R u-s ${D}/
	chmod -R g-s ${D}/
}

# ------------------------------------------------------------------------
# EXPORTED FUNCTION - call from inside your ebuild's pkg_config AFTER
# everything else has run
#
# If 'vhosts' USE flag is not set, auto-install this app
#
# ------------------------------------------------------------------------

function webapp_pkg_setup ()
{
	# we do have the config file, right?

	if [ "$G_HASCONFIG" = "0" ]; then
		die "/etc/conf.d/webapp-config missing"
	fi

	# are we emerging something that is already installed?

	if [ -d "${MY_APPROOT}/${MY_APPSUFFIX}" ]; then
		# yes we are
		ewarn "Removing existing copy of ${PN}-${PVR}"
		rm -rf "${MY_APPROOT}/${MY_APPSUFFIX}"
	fi

	# create the directories that we need

	mkdir -p ${MY_HTDOCSDIR}
	mkdir -p ${MY_HOSTROOTDIR}
	mkdir -p ${MY_CGIBINDIR}
	mkdir -p ${MY_ICONSDIR}
	mkdir -p ${MY_ERRORSDIR}
	mkdir -p ${MY_SQLSCRIPTSDIR}
}

function webapp_pkg_config ()
{
	use vhosts || webapp-config -u root -d /var/www/localhost/htdocs/${PN}/ ${PN}
}
