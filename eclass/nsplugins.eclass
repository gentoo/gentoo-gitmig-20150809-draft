# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/nsplugins.eclass,v 1.12 2003/05/13 04:42:54 george Exp $
#
# Author: Martin Schlemmer <azarah@gentoo.org>
#
# Just some re-usable functions for the netscape/moz plugins sharing

ECLASS=nsplugins
INHERITED="$INHERITED $ECLASS"

DESCRIPTION="Based on the ${ECLASS} eclass"

PLUGINS_DIR="nsbrowser/plugins"

# This function move the plugin dir in src_install() to
# ${D}/usr/lib/${PLUGIN_DIR}.  First argument should be
# the full path (without $D) to old plugin dir.
src_mv_plugins() {

	# Move plugins dir.  We use keepdir so that it might not be unmerged
	# by mistake ...
	keepdir /usr/lib/${PLUGINS_DIR}
	cp -a ${D}/$1/* ${D}/usr/lib/${PLUGINS_DIR}
	rm -rf ${D}/$1
	dosym /usr/lib/${PLUGINS_DIR} $1
}

# This function move plugins in pkg_preinst() in old dir to 
# ${ROOT}//usr/lib/${PLUGIN_DIR}.  First argument should be
# the full path (without $ROOT) to old plugin dir.
pkg_mv_plugins() {

	# Move old plugins dir
	if [ -d "${ROOT}/$1" -a ! -L "${ROOT}/$1" ]
	then
		mkdir -p ${ROOT}/usr/lib/${PLUGINS_DIR}
		cp -a ${ROOT}/$1/* ${ROOT}/usr/lib/${PLUGINS_DIR}
		rm -rf ${ROOT}/$1
	fi
}

# This function installs a plugin with dosym to PLUGINS_DIR.
# First argument should be the plugin file.
inst_plugin() {
	# Get the filename
	MYFILE="`echo ${1} | gawk  -F '/' '{ print $NF }'`"

	# Install the plugin if none is installed
	if [ ! -L "/usr/lib/${PLUGINS_DIR}/${MYFILE}" ]
	then
		dodir /usr/lib/${PLUGINS_DIR}
		# $ROOT should only be used in pkg_*() functions ...
		#	dosym ${1} ${ROOT}/usr/lib/${PLUGINS_DIR}
		echo dosym ${1} /usr/lib/${PLUGINS_DIR}
		dosym ${1} /usr/lib/${PLUGINS_DIR}
		einfo "Symlinked the java plugin into the mozilla/phoenix/galeon plugin directory."
	else
		einfo "Not creating symlink for the java plugin, because there already is a java plugin installed."
	fi
}

