# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/webapp.eclass,v 1.14 2004/05/01 00:45:45 stuart Exp $
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
DEPEND="$DEPEND >=net-www/webapp-config-1.7"

EXPORT_FUNCTIONS pkg_postinst pkg_setup src_install

INSTALL_DIR="/$PN"
IS_UPGRADE=0
IS_REPLACE=0

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
	local my_prefix

	[ -n "$2" ] && my_prefix="$2/" || my_prefix=

	if [ ! -e ${my_prefix}$1 ]; then
		msg="ebuild fault: file $1 not found"
		eerror "$msg"
		eerror "Please report this as a bug at http://bugs.gentoo.org/"
		die "$msg"
	fi
}

# ------------------------------------------------------------------------
# INTERNAL FUNCTION - USED BY THIS ECLASS ONLY
# ------------------------------------------------------------------------

function webapp_check_installedat
{
	local my_output

	/usr/sbin/webapp-config --show-installed -h localhost -d $INSTALL_DIR 2> /dev/null
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
	local my_stripped="$1"
	echo "$1" | sed -e "s|${MY_APPDIR}/||g;"
}

function webapp_strip_d ()
{
	echo "$1" | sed -e "s|${D}||g;"
}

function webapp_strip_cwd ()
{
	local my_stripped="$1"
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
	echo $1
	local MY_FILE="`webapp_strip_appdir $1`"
	echo $MY_FILE

	einfo "(config) $MY_FILE"
	echo "$MY_FILE" >> ${D}${WA_CONFIGLIST}
}

# ------------------------------------------------------------------------
# EXPORTED FUNCTION - FOR USE IN EBUILDS
#
# Install a text file containing post-installation instructions.
#
# @param	$1 - language code (use 'en' for now)
# @param	$2 - the file to install
# ------------------------------------------------------------------------

function webapp_postinst_txt
{
	webapp_checkfileexists "$2"

	einfo "(rtfm) $2 (lang: $1)"
	cp "$2" "${D}${MY_APPDIR}/postinst-$1.txt"
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
	echo "$1 $MY_FILE" >> ${D}${WA_RUNBYCGIBINLIST}
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
	echo "$MY_FILE" >> ${D}${WA_SOLIST}
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

	if [ ! -d "${D}${MY_SQLSCRIPTSDIR}/$1" ]; then
		mkdir -p "${D}${MY_SQLSCRIPTSDIR}/$1" || libsh_die "unable to create directory ${D}${MY_SQLSCRIPTSDIR}/$1"
	fi

	# warning:
	#
	# do NOT change the naming convention used here without changing all
	# the other scripts that also rely upon these names
 
	# are we dealing with an 'upgrade'-type script?
	if [ -n "$3" ]; then
		# yes we are
		einfo "($1) upgrade script from ${PN}-${PVR} to $3"
		cp $2 ${D}${MY_SQLSCRIPTSDIR}/$1/${3}_to_${PVR}.sql
	else
		# no, we are not
		einfo "($1) create script for ${PN}-${PVR}"
		cp $2 ${D}${MY_SQLSCRIPTSDIR}/$1/${PVR}_create.sql
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

	keepdir ${MY_PERSISTDIR}
	fowners root:root ${MY_PERSISTDIR}
	fperms 755 ${MY_PERSISTDIR}
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
	# pull in the shared configuration file

	. /etc/vhosts/webapp-config || die "Unable to open /etc/vhosts/webapp-config file"
}

function webapp_getinstalltype ()
{
	# are we emerging something that is already installed?

	if [ -d "${D}${MY_APPROOT}/${MY_APPSUFFIX}" ]; then
		# yes we are
		ewarn "Removing existing copy of ${PN}-${PVR}"
		rm -rf "${D}${MY_APPROOT}/${MY_APPSUFFIX}"
	fi

	# or are we upgrading?

	if ! use vhosts ; then
		# we only run webapp-config if vhosts USE flag is not set

		local my_output

		my_output="`webapp_check_installedat`"

		if [ "$?" = "0" ] ; then
			# something is already installed there
			#
			# make sure it isn't the same version

			local my_pn="`echo $my_output | awk '{ print $1 }'`"
			local my_pvr="`echo $my_output | awk '{ print $2 }'`"

			REMOVE_PKG="${my_pn}-${my_pvr}"

			if [ "$my_pn" == "$PN" ]; then
				if [ "$my_pvr" != "$PVR" ]; then
					einfo "This is an upgrade"
					IS_UPGRADE=1
				else
					einfo "This is a re-installation"
					IS_REPLACE=1
				fi
			fi
		fi
	fi
}

function webapp_src_preinst ()
{
	# create the directories that we need

	dodir ${MY_HTDOCSDIR}
	dodir ${MY_HOSTROOTDIR}
	dodir ${MY_CGIBINDIR}
	dodir ${MY_ICONSDIR}
	dodir ${MY_ERRORSDIR}
	dodir ${MY_SQLSCRIPTSDIR}
}

function webapp_pkg_postinst ()
{
	# if 'vhosts' is not set in your USE flags, we install a copy of
	# this application in /var/www/localhost/htdocs/${PN}/ for you
	
	if ! use vhosts ; then
		echo
		einfo "vhosts USE flag not set - auto-installing using webapp-config"

		webapp_getinstalltype

		G_HOSTNAME="localhost"
		. /etc/vhosts/webapp-config

		local my_mode=-I

		if [ "$IS_REPLACE" = "1" ]; then
			einfo "${PN}-${PVR} is already installed - replacing"
			/usr/sbin/webapp-config -C -d "$INSTALL_DIR"
		elif [ "$IS_UPGRADE" = "1" ]; then
			einfo "$REMOVE_PKG is already installed - upgrading"
			my_mode=-U
		else
			einfo "${PN}-${PVR} is not installed - using install mode"
		fi
	
		my_cmd="/usr/sbin/webapp-config $my_mode -h localhost -u root -d $INSTALL_DIR ${PN} ${PVR}"
		einfo "Running $my_cmd"
		$my_cmd

		# remove the old version
		#
		# why do we do this?  well ...
		#
		# normally, emerge -u installs a new version and then removes the
		# old version.  however, if the new version goes into a different
		# slot to the old version, then the old version gets left behind
		#
		# if USE=-vhosts, then we want to remove the old version, because
		# the user is relying on portage to do the magical thing for it

		if [ "$IS_UPGRADE" = "1" ] ; then
			einfo "Removing old version $REMOVE_PKG"

			echo emerge -C $CATEGORY/$REMOVE_PKG
		fi
	fi

	return 0
}
