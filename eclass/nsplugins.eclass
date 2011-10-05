# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/nsplugins.eclass,v 1.26 2011/10/05 15:14:07 scarabeus Exp $
#
# Author: Martin Schlemmer <azarah@gentoo.org>
#
# Just some re-usable functions for the netscape/moz plugins sharing

inherit eutils

DESCRIPTION="Based on the ${ECLASS} eclass"

PLUGINS_DIR="nsbrowser/plugins"

# This function move the plugin dir in src_install() to
# ${D}/usr/$(get_libdir)/${PLUGIN_DIR}.  First argument should be
# the full path (without $D) to old plugin dir.
src_mv_plugins() {
	has "${EAPI:-0}" 0 1 2 && ! use prefix && ED="${D}"

	# Move plugins dir.  We use keepdir so that it might not be unmerged
	# by mistake ...
	keepdir /usr/$(get_libdir)/${PLUGINS_DIR}
	cp -a "${ED}"/$1/* "${ED}"/usr/$(get_libdir)/${PLUGINS_DIR}
	rm -rf "${ED}"/$1
	dosym /usr/$(get_libdir)/${PLUGINS_DIR} $1
}

# This function move plugins in pkg_preinst() in old dir to
# ${ROOT}/usr/$(get_libdir)/${PLUGIN_DIR}.  First argument should be
# the full path (without $ROOT) to old plugin dir.
pkg_mv_plugins() {
	has "${EAPI:-0}" 0 1 2 && ! use prefix && ED="${ROOT}"

	# Move old plugins dir
	if [ -d "${ROOT}/$1" -a ! -L "${ROOT}/$1" ]
	then
		mkdir -p "${EROOT}"/usr/$(get_libdir)/${PLUGINS_DIR}
		cp -a "${EROOT}"/$1/* "${EROOT}"/usr/$(get_libdir)/${PLUGINS_DIR}
		rm -rf "${EROOT}"/$1
	fi
}

# This function installs a plugin with dosym to PLUGINS_DIR.
# First argument should be the plugin file.
inst_plugin() {
	dodir /usr/$(get_libdir)/${PLUGINS_DIR}
	dosym ${1} /usr/$(get_libdir)/${PLUGINS_DIR}/$(basename ${1})
}
