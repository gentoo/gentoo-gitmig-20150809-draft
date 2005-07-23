# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/nsplugins.eclass,v 1.21 2005/07/23 09:38:21 azarah Exp $
#
# Author: Martin Schlemmer <azarah@gentoo.org>
#
# Just some re-usable functions for the netscape/moz plugins sharing

inherit eutils

DESCRIPTION="Based on the ${ECLASS} eclass"

#DEPEND="www-client/update-nsplugins"

NSPLUGINS_DIR="/usr/$(get_libdir)/nsplugins"
NSBROWSERS_DIR="${NSPLUGINS_DIR}/nsbrowsers"


# This function installs a plugin in ${S} to NSPLUGINS_DIR.
# First argument should be the plugin file.  This is for stuff like
# mplayerplug-in that you can move the plugin to any directory ...
install_nsplugin() {
	local plugin=$1

	dodir "${NSPLUGINS_DIR}"
	exeinto "${NSPLUGINS_DIR}"
	doexe "${plugin}"
}

# This function installs a plugin with dosym to NSPLUGINS_DIR.
# First argument should be the plugin file.  This is for stuff like
# the java plugins that should be symlinked, and not moved from the VM
# directory ...
symlink_nsplugin() {
	local plugin=$1
	
	dodir "${NSPLUGINS_DIR}"
	dosym "${plugin}" "${NSPLUGINS_DIR}"
}

# First argument should be the browser name (usually $PN), second
# is its plugin dir.  This basically just makes update-nsplugins aware
# of the browser.
register_nsbrowser() {
	local browser=$1
	local plugindir=$2
	
	dodir "${NSBROWSERS_DIR}"
	echo "${plugindir}" > "${D}${NSBROWSERS_DIR}/${browser}"
}


###############################################################################
#
# Depriciated Functions - Please do not use any more !
#
###############################################################################

PLUGINS_DIR="nsbrowser/plugins"

# This function move the plugin dir in src_install() to
# ${D}/usr/$(get_libdir)/${PLUGIN_DIR}.  First argument should be
# the full path (without $D) to old plugin dir.
src_mv_plugins() {

	# Move plugins dir.  We use keepdir so that it might not be unmerged
	# by mistake ...
	keepdir /usr/$(get_libdir)/${PLUGINS_DIR}
	cp -a ${D}/$1/* ${D}/usr/$(get_libdir)/${PLUGINS_DIR}
	rm -rf ${D}/$1
	dosym /usr/$(get_libdir)/${PLUGINS_DIR} $1
}

# This function move plugins in pkg_preinst() in old dir to
# ${ROOT}/usr/$(get_libdir)/${PLUGIN_DIR}.  First argument should be
# the full path (without $ROOT) to old plugin dir.
pkg_mv_plugins() {

	# Move old plugins dir
	if [ -d "${ROOT}/$1" -a ! -L "${ROOT}/$1" ]
	then
		mkdir -p ${ROOT}/usr/$(get_libdir)/${PLUGINS_DIR}
		cp -a ${ROOT}/$1/* ${ROOT}/usr/$(get_libdir)/${PLUGINS_DIR}
		rm -rf ${ROOT}/$1
	fi
}

# This function installs a plugin with dosym to PLUGINS_DIR.
# First argument should be the plugin file.
inst_plugin() {
	dodir /usr/$(get_libdir)/${PLUGINS_DIR}
	dosym ${1} /usr/$(get_libdir)/${PLUGINS_DIR}
}
