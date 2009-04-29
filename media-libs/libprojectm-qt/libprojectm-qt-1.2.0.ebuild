# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libprojectm-qt/libprojectm-qt-1.2.0.ebuild,v 1.3 2009/04/29 19:48:32 maekke Exp $

EAPI=1

inherit cmake-utils eutils

MY_TP=${P/m/M}
MY_P=${MY_TP%_p*}
MY_UP=${PN/m/M}-${PV/_p/-r}

DESCRIPTION="A graphical music visualization plugin similar to milkdrop"
HOMEPAGE="http://projectm.sourceforge.net"
SRC_URI="mirror://sourceforge/projectm/${MY_UP}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=media-libs/libprojectm-1.1
	|| ( ( x11-libs/qt-gui
		x11-libs/qt-core
		x11-libs/qt-opengl )
		>=x11-libs/qt-4.3:4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/cmake"

S=${WORKDIR}/${MY_P}

CMAKE_IN_SOURCE_BUILD=true

pkg_setup() {
	if ! has_version x11-libs/qt-opengl && ! built_with_use =x11-libs/qt-4* opengl; then
		eerror "You need to build qt4 with opengl support to build ${PN}"
		die "Please rebuild qt4 with opengl support"
	fi
}
