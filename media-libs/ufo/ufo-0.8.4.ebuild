# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ufo/ufo-0.8.4.ebuild,v 1.5 2007/06/19 01:44:12 angelos Exp $

inherit eutils

DESCRIPTION="A platform and device independent core library for GUIs"
HOMEPAGE="http://libufo.sourceforge.net/"
SRC_URI="mirror://sourceforge/libufo/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libsdl
	x11-libs/libICE"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-namespace.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
