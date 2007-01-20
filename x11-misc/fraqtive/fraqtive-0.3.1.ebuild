# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fraqtive/fraqtive-0.3.1.ebuild,v 1.2 2007/01/20 14:54:34 drizzt Exp $

inherit kde

DESCRIPTION="Fraqtive is a KDE-based program for interactively drawing Mandelbrot and Julia fractals"
HOMEPAGE="http://fraqtive.mimec.org/"
SRC_URI="http://fraqtive.mimec.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_setup() {
	if ! built_with_use =x11-libs/qt-3* opengl; then #162926
		eerror "${PN} requires =x11-libs/qt-3* emerged with USE=opengl"
		die "${PN} requires =x11-libs/qt-3* emerged with USE=opengl"
	fi

	kde_pkg_setup
}

need-kde 3.2
