# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbdesk/fbdesk-1.4.1.ebuild,v 1.11 2010/06/13 11:45:49 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="fluxbox-util application that creates and manage icons on your Fluxbox desktop"
HOMEPAGE="http://fluxbox.sourceforge.net/fbdesk/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE="debug png"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libXrender
	x11-libs/libXft
	media-libs/imlib2[X]
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	x11-proto/xproto"

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
