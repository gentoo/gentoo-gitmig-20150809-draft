# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmsg/wmmsg-1.0.1-r1.ebuild,v 1.3 2011/12/16 20:49:41 ago Exp $

EAPI="1"

inherit autotools eutils

DESCRIPTION="a dockapp that informs events, such as incoming chat messages, by displaying icons and times"
HOMEPAGE="http://swapspace.net/~matt/wmmsg"
SRC_URI="http://swapspace.net/~matt/wmmsg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	media-libs/imlib2
	x11-libs/libXpm
	x11-libs/libXext
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-libs/libXt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-use_gtk2.patch
	epatch "${FILESDIR}"/${P}-alt-desktop.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README wmmsgrc
}
