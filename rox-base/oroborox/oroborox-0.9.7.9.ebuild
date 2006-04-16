# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/oroborox/oroborox-0.9.7.9.ebuild,v 1.3 2006/04/16 14:13:11 svyatogor Exp $

MY_PN="OroboROX"

DESCRIPTION="OroboROX is a small window manager for the ROX Desktop."
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="http://roxos.sunsite.dk/dev-contrib/guido/${MY_PN}-${PV}.tar.bz2"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/x11
		virtual/xft
		>=media-libs/freetype-2.0"

S=${WORKDIR}
ROX_LIB_VER=1.9.14
SET_PERM=TRUE

APPNAME=${MY_PN}

inherit rox

# OroboROX fails to build if CHOICESPATH is set to any path.
# see bug #124133
unset CHOICESPATH

# Special processing to remove =build AND
# to change perms for all AppRun statements
# in subdirectories
pkg_preinst() {
	cd ${D}/usr/lib/rox/${APPNAME}
	if [ -d "=build" ]; then
		rm -rf "=build"
	fi

	find . -name 'AppRun' | xargs chmod a+x >/dev/null 2>&1
}
