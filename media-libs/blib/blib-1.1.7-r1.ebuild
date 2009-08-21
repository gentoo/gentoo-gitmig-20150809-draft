# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/blib/blib-1.1.7-r1.ebuild,v 1.4 2009/08/21 20:14:54 ssuominen Exp $

EAPI=2

DESCRIPTION="blib is a library full of useful things to hack the Blinkenlights"
HOMEPAGE="http://www.blinkenlights.de"
SRC_URI="http://www.blinkenlights.de/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="aalib gtk directfb"

RDEPEND=">=dev-libs/glib-2
	aalib? ( >=media-libs/aalib-1.4_rc4-r2 )
	directfb? ( >=dev-libs/DirectFB-0.9.20-r1 )
	gtk? ( >=x11-libs/gtk+-2.4.4:2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable aalib) \
		$(use_enable directfb) \
		$(use_enable gtk gtk2)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
