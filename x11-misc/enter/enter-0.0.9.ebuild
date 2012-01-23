# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/enter/enter-0.0.9.ebuild,v 1.2 2012/01/23 18:46:17 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A lightweight graphical login manager for X"
HOMEPAGE="http://enter.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/freetype-2
	media-libs/imlib2
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXext
	x11-libs/libXft"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xproto"

DOCS="AUTHORS ChangeLog README TODO"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	eautoreconf
}
