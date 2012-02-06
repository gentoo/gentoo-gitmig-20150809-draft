# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libXcm/libXcm-0.4.2.ebuild,v 1.2 2012/02/06 02:23:33 xmw Exp $

EAPI=4

inherit eutils

DESCRIPTION="reference implementation of the net-color spec"
HOMEPAGE="http://www.oyranos.org/libxcm/"
SRC_URI="mirror://sourceforge/oyranos/${PN}/${PN}-0.4.x/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X doc static-libs"

RDEPEND="X? ( x11-libs/libXmu
		x11-libs/libXfixes
		x11-libs/libX11 )"
DEPEND="${RDEPEND}
	app-doc/doxygen"

src_prepare() {
	epatch "${FILESDIR}"/${P}-buildsystem.patch
}

src_configure() {
	econf --enable-verbose \
		$(use_enable static-libs static) \
		$(use_enable X libXfixes) \
		$(use_enable X libXmu) \
		$(use_enable X libX11) \
		$(use_with X x)
}

src_install() {
	emake DESTDIR="${D}" docdir=/usr/share/doc/${P} install

	use doc && dohtml doc/html/*
}
