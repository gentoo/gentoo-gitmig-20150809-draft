# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fraqtive/fraqtive-0.4.4.ebuild,v 1.1 2009/02/02 16:59:38 drizzt Exp $

EAPI=1

inherit qt4

DESCRIPTION="Fraqtive is a KDE-based program for interactively drawing Mandelbrot and Julia fractals"
HOMEPAGE="http://fraqtive.mimec.org/"
SRC_URI="mirror://sourceforge/fraqtive/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sse2"

RDEPEND="|| ( ( x11-libs/qt-core
				x11-libs/qt-gui
				x11-libs/qt-opengl )
				<x11-libs/qt-4.4:4 )"
DEPEND="${RDEPEND}"

QT4_BUILT_WITH_USE_CHECK="opengl"

src_unpack() {
	local conf="release"

	if use sse2; then
		conf="$conf sse2"
	else
		conf="$conf no-sse2"
	fi

	unpack ${A}

	echo "CONFIG += $conf" > "${S}"/config.pri
	echo "PREFIX = /usr" >> "${S}"/config.pri
}

src_compile() {
	eqmake4
	emake || die "make failed"
}

src_install() {
	make install INSTALL_ROOT="${D}" || die "install failed"
}
