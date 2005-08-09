# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/scsh.eclass,v 1.4 2005/08/09 18:10:18 mkennedy Exp $
#

inherit eutils

ECLASS=scsh
INHERITED="$INHERITED $ECLASS"

LICENSE="as-is BSD"
SLOT="0"
KEYWORDS="~x86"

IUSE="scsh"

SCSH_SCSH_PATH=/usr/$(get_libdir)/scsh

set_layout() {
	if use scsh; then
		SCSH_LAYOUT=scsh
	else
		ewarn "No layout was specified via USE, defaulting to FHS."
		SCSH_LAYOUT=fhs
	fi
	export SCSH_LAYOUT
}

set_path_variables() {
	SCSH_VERSION="$(best_version 'app-shells/scsh')"
	SCSH_MV="${SCSH_VERSION%*.*}"
	SCSH_MV="${SCSH_MV//app-shells\/scsh-}"
	export SCSH_VERSION SCSH_MV

	case $SCSH_LAYOUT in
		fhs)
			SCSH_PREFIX=/usr
			SCSH_MODULES_PATH=/usr/share/scsh-$SCSH_MV/modules
			;;
		scsh)
			SCSH_PREFIX=/usr/$(get_libdir)/scsh/modules
			SCSH_MODULES_PATH=/usr/$(get_libdir)/scsh/modules/$SCSH_MV
			;;
	esac
	export SCSH_PREFIX SCSH_MODULES_PATH

	SCSH_LIB_DIRS='"'${SCSH_MODULES_PATH}'"'" "'"'${SCSH_SCSH_PATH}'"'" "'"'.'"'
	export SCSH_LIB_DIRS
}

scsh_src_unpack() {
	set_layout
	set_path_variables
	einfo "Using $SCSH_LAYOUT layout"
	unpack ${A}
}

scsh_get_layout_conf() {
	SCSH_LAYOUT_CONF=" --build $CHOST
		--force
		--layout $SCSH_LAYOUT
		--prefix $SCSH_PREFIX
		--no-user-defaults
		--dest-dir ${D}"
	export SCSH_LAYOUT_CONF
}

scsh_src_compile() {
	get_layout_conf
}

scsh_src_install() {
	dodir $SCSH_MODULES_PATH
	scsh-install-pkg ${SCSH_LAYOUT_CONF} || die "./scsh-install-pkg failed"
}

EXPORT_FUNCTIONS src_unpack src_compile src_install get_layout_conf
