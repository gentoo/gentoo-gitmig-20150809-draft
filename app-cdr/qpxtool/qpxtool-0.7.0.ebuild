# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/qpxtool/qpxtool-0.7.0.ebuild,v 1.2 2009/12/29 20:32:15 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs qt4

DESCRIPTION="CD/DVD quality checking utilities"
HOMEPAGE="http://qpxtool.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	media-libs/libpng"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	epatch "${FILESDIR}"/${P}-lrelease.patch
}

src_configure() {
	tc-export CXX
	./configure --prefix=/usr || die
	cd gui
	mv -vf Makefile Makefile.orig || die "Backup Makefile for install"
	eqmake4 qpxtool.pro
}

src_compile() {
	emake || die
}

src_install() {
	mv -vf gui/Makefile.orig gui/Makefile || die "Restore Makefile for install"
	dodir /usr/bin
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README ReleaseNotes TODO
	dohtml status.html
}
