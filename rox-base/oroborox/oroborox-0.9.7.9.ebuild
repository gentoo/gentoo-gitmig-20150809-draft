# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/oroborox/oroborox-0.9.7.9.ebuild,v 1.6 2007/07/13 06:15:04 mr_bones_ Exp $

ROX_LIB_VER=1.9.14
inherit rox

MY_PN="OroboROX"

DESCRIPTION="OroboROX is a small window manager for the ROX Desktop."
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="http://roxos.sunsite.dk/dev-contrib/guido/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="xinerama"

DEPEND="
	>=media-libs/freetype-2.0
	virtual/xft
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto
		x11-proto/xf86vidmodeproto
		x11-libs/libXpm
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXcomposite
		x11-libs/libXdamage
		xinerama? ( x11-proto/xineramaproto )
	)
		virtual/x11
	)
	"

RDEPEND="
	>=media-libs/freetype-2.0
	virtual/xft
	|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXxf86vm
		xinerama? ( x11-libs/libXinerama )
	)
		virtual/x11
	)
	"

S=${WORKDIR}
APPNAME=${MY_PN}

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
