# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/qpxtool/qpxtool-0.7.0-r1.ebuild,v 1.1 2010/01/25 20:08:33 carlo Exp $

EAPI=2
inherit eutils toolchain-funcs qt4-r2

DESCRIPTION="CD/DVD quality checking utilities"
HOMEPAGE="http://qpxtool.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	media-libs/libpng"

DOCS="AUTHORS ChangeLog README ReleaseNotes TODO"

src_prepare() {
	epatch "${FILESDIR}"/${P}-lrelease.patch
	epatch "${FILESDIR}"/${P}-ldlibs.patch
	epatch "${FILESDIR}"/${P}-locale-install-race-patch
}

src_configure() {
	tc-export CXX
	./configure --prefix=/usr || die
	cd gui
	mv -vf Makefile Makefile.orig || die "Backup Makefile for install"
	qt4-r2_src_configure
}

src_install() {
	mv -vf gui/Makefile.orig gui/Makefile || die "Restore Makefile for install"
	dodir /usr/bin
	dohtml status.html
	qt4-r2_src_install
}
