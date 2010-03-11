# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbdesk/fbdesk-1.4.1.ebuild,v 1.10 2010/03/11 12:24:56 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="fluxbox-util application that creates and manage icons on your Fluxbox desktop"
HOMEPAGE="http://www.fluxbox.org/fbdesk/"
SRC_URI="http://www.fluxbox.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE="debug png"

RDEPEND="png? ( media-libs/libpng )
	media-libs/imlib2
	>=media-libs/freetype-2
	x11-libs/libXpm
	x11-libs/libXft"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc-4.3.patch \
		"${FILESDIR}"/${P}-libpng14.patch
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable png)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}
