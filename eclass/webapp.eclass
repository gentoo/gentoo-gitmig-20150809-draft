# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/webapp.eclass,v 1.29 2004/07/22 14:07:01 stuart Exp $
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
# The master copy of this eclass is held in Stu's subversion repository.
#
# If you make changes to this file and don't tell Stu, chances are that
# your changes will be overwritten the next time Stu releases a new version
# of webapp-config.
#
# ------------------------------------------------------------------------

ECLASS=webapp
INHERITED="$INHERITED $ECLASS"
SLOT="${PVR}"
IUSE="$IUSE vhosts"
DEPEND="$DEPEND >=net-www/webapp-config-1.7 app-portage/gentoolkit"

EXPORT_FUNCTIONS pkg_postinst pkg_setup src_install pkg_prerm

INSTALL_DIR="/$PN"
IS_UPGRADE=0
IS_REPLACE=0

INSTALL_CHECK_FILE="installed_by_webapp_eclass"

ETC_CONFIG="/etc/vhosts/webapp-config"

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

	if [ ! -e "${my_prefix}$1" ]; then
		msg="ebuild fault: file '$1' not found"
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

	/usr/sbin/webapp-config --show-installed -h localhost -d "$INSTALL_DIR" 2> /dev/null
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

	local MY_FILE="`webapp_strip_appdir \"$1\"`"
	MY_FILE="`webapp_strip_cwd \"$MY_FILE\"`"

	einfo "(config) $MY_FILE"
	echo "$MY_FILE" >> ${D}${WA_CONFIGLIST}
}

# ------------------------------------------------------------------------
# EXPORTED FUNCTION - FOR USE IN EBUILDS
#
# Install a script that will run after a virtual copy is created, and
# before a virtual copy has been removed
#
# @param	$1 - the script to run
# ------------------------------------------------------------------------

function webapp_hook_script ()
{
	webapp_checkfileexists "$1"

	einfo "(hook) $1"
	cp "$1" "${D}${MY_HOOKSCRIPTSDIR}/`basename $1`" || die "Unable to install $1 into ${D}${MY_HOOKSCRIPTSDIR}/"
	chmod 555 "${D}${MY_HOOKSCRIPTSDIR}/`basename $1`"
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
	local MY_FILE="`webapp_strip_appdir \"$2\"`"
	MY_FILE="`webapp_strip_cwd \"$MY_FILE\"`"

	einfo "(cgi-bin) $1 - $MY_FILE"
	echo "\"$1\" \"$MY_FILE\"" >> "${D}${WA_RUNBYCGIBINLIST}"
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
	local MY_FILE="`webapp_strip_appdir \"$1\"`" 
	MY_FILE="`webapp_strip_cwd \"$MY_FILE\"`"
	
	einfo "(server owned) $MY_FILE"
	echo "$MY_FILE" >> "${D}${WA_SOLIST}"
}

# ------------------------------------------------------------------------
# EXPORTED FUNCTION - FOR USE IN EBUILDS
#
# @param	$1 - the webserver to install the config file for
#			     (one of apache1, apache2, cherokee)
# @param	$2 - the config file to install
# @param	$3 - new name for the config file (default is `basename $2`)
#				 this is an optional parameter
#
# NOTE:
#	this function will automagically prepend $1 to the front of your
#	config file's name
# ------------------------------------------------------------------------

function webapp_server_configfile ()
{
	webapp_checkfileexists "$2"

	# sort out what the name will be of the config file

	local my_file

	if [ -z "$3" ]; then
		my_file="$1-`basename $2`"
	else
		my_file="$1-$3"
	fi

	# warning:
	#
	# do NOT change the naming convention used here without changing all
	# the other scripts that also rely upon these names
 
	einfo "($1) config file '$my_file'"
	cp "$2" "${D}${MY_SERVERCONFIGDIR}/${my_file}"
}

# ------------------------------------------------------------------------
# EXPORTED FUNCTION - FOR USE IN EBUILDS
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
		cp "$2" "${D}${MY_SQLSCRIPTSDIR}/$1/${3}_to_${PVR}.sql"
	else
		# no, we are not
		einfo "($1) create script for ${PN}-${PVR}"
		cp "$2" "${D}${MY_SQLSCRIPTSDIR}/$1/${PVR}_create.sql"
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
	chown -R "${VHOST_DEFAULT_UID}:${VHOST_DEFAULT_GID}" "${D}/"
	chmod -R u-s "${D}/"
	chmod -R g-s "${D}/"

	keepdir "${MY_PERSISTDIR}"
	fowners "root:root" "${MY_PERSISTDIR}"
	fperms 755 "${MY_PERSISTDIR}"

	# to test whether or not the ebuild has correctly called this function
	# we add an empty file to the filesystem
	#
	# we used to just set a variable in the shell script, but we can
	# no longer rely on Portage calling both webapp_src_install() and
	# webapp_pkg_postinst() within the same shell process

	touch "${D}/${MY_APPDIR}/${INSTALL_CHECK_FILE}"
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
	# add sanity checks here

	if [ "$SLOT+" != "${PVR}+" ]; then
		die "ebuild sets SLOT, overrides webapp.eclass"
	fi

	# pull in the shared configuration file

	G_HOSTNAME="localhost"
	. "${ETC_CONFIG}" || die "Unable to open file ${ETC_CONFIG}"

	# are we installing a webapp-config solution over the top of a 
	# non-webapp-config solution?

	if ! use vhosts ; then
		local my_dir="$VHOST_ROOT/$MY_HTDOCSBASE/$PN"
		local my_output

		if [ -d "$my_dir" ] ; then
			einfo "You already have something installed in $my_dir"
			einfo "Are you trying to install over the top of something I cannot upgrade?"

			my_output="`webapp_check_installedat`"

			if [ "$?" != "0" ]; then

				# okay, whatever is there, it isn't webapp-config-compatible
				ewarn
				ewarn "Whatever is in $my_dir, it's not"
				ewarn "compatible with webapp-config."
				ewarn
				ewarn "This ebuild may be overwriting important files."
				ewarn
			elif [ "`echo $my_output | awk '{ print $1 }'`" != "$PN" ]; then
				eerror "$my_dir contains $my_output"
				eerror "I cannot upgrade that"
				die "Cannot upgrade contents of $my_dir"
			else
				einfo
				einfo "I can upgrade the contents of $my_dir"
				einfo
			fi
		fi
	fi
}

function webapp_someunusedfunction ()
{
	# are we emerging something that is already installed?

	if [ -d "${D}${MY_APPROOT}/${MY_APPSUFFIX}" ]; then
		# yes we are
		ewarn "Removing existing copy of ${PN}-${PVR}"
		rm -rf "${D}${MY_APPROOT}/${MY_APPSUFFIX}"
	fi
}

function webapp_getinstalltype ()
{
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
			else
				einfo "$my_ouptut is installed there"
			fi
		else
			einfo "This is an installation"
		fi
	fi
}

function webapp_src_preinst ()
{
	# create the directories that we need

	dodir "${MY_HTDOCSDIR}"
	dodir "${MY_HOSTROOTDIR}"
	dodir "${MY_CGIBINDIR}"
	dodir "${MY_ICONSDIR}"
	dodir "${MY_ERRORSDIR}"
	dodir "${MY_SQLSCRIPTSDIR}"
	dodir "${MY_HOOKSCRIPTSDIR}"
	dodir "${MY_SERVERCONFIGDIR}"
}

function webapp_pkg_postinst ()
{
	. "${ETC_CONFIG}"

	# sanity checks, to catch bugs in the ebuild

	if [ ! -f "${MY_APPDIR}/${INSTALL_CHECK_FILE}" ]; then
		eerror
		eerror "This ebuild did not call webapp_src_install() at the end"
		eerror "of the src_install() function"
		eerror
		eerror "Please log a bug on http://bugs.gentoo.org"
		eerror
		eerror "You should use emerge -C to remove this package, as the"
		eerror "installation is incomplete"
		eerror
		die "Ebuild did not call webapp_src_install() - report to http://bugs.gentoo.org"
	fi

	# if 'vhosts' is not set in your USE flags, we install a copy of
	# this application in /var/www/localhost/htdocs/${PN}/ for you
	
	if ! use vhosts ; then
		echo
		einfo "vhosts USE flag not set - auto-installing using webapp-config"

		webapp_getinstalltype

		G_HOSTNAME="localhost"
		. "${ETC_CONFIG}"

		local my_mode=-I

		if [ "$IS_REPLACE" = "1" ]; then
			einfo "${PN}-${PVR} is already installed - replacing"
			my_mode=-I
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

			emerge -C "$REMOVE_PKG"
		fi
	else
		# vhosts flag is on
		#
		# let's tell the administrator what to do next

		einfo
		einfo "The 'vhosts' USE flag is switched ON"
		einfo "This means that Portage will not automatically run webapp-config to"
		einfo "complete the installation."
		einfo
		einfo "To install $PN-$PVR into a virtual host, run the following command:"
		einfo
		einfo "    webapp-config -I -h <host> -d $PN $PN $PVR"
		einfo
		einfo "For more details, see the webapp-config(8) man page"
	fi

	return 0
}

function webapp_pkg_prerm ()
{
	# remove any virtual installs that there are

	local my_output
	local x

	my_output="`webapp-config --list-installs $PN $PVR`"

	if [ "$?" != "0" ]; then
		return
	fi

	# the changes to IFS here are necessary to ensure that we can cope
	# with directories that contain spaces in the file names

	# OLD_IFS="$IFS"
	# IFS=""

	for x in $my_output ; do
		# IFS="$OLD_IFS"

		[ -f $x/.webapp ] && . $x/.webapp || ewarn "Cannot find file $x/.webapp"

		if [ -z "WEB_HOSTNAME" -o -z "WEB_INSTALLDIR" ]; then
			ewarn "Don't forget to use webapp-config to remove the copy of"
			ewarn "${PN}-${PVR} installed in"
			ewarn
			ewarn "    $x"
			ewarn
		else
			# we have enough information to remove the virtual copy ourself

			webapp-config -C -h ${WEB_HOSTNAME} -d ${WEB_INSTALLDIR}

			# if the removal fails - we carry on anyway!
		fi
		# IFS=""
	done

	# IFS="$OLD_IFS"
}
