# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vls/vls-0.5.5.ebuild,v 1.8 2006/08/30 13:03:43 zzam Exp $

IUSE="debug"

DESCRIPTION="The VideoLAN server"
HOMEPAGE="http://www.videolan.org/vlc/streaming.html"
SRC_URI="http://www.videolan.org/pub/videolan/vls/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND=">=media-libs/libdvdread-0.9.4
	>=media-libs/libdvdcss-1.2.8
	>=media-libs/libdvbpsi-0.1.3"

src_compile() {
	local myconf
	use debug || myconf="--disable-debug"

	econf ${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install () {
	einstall || die "einstall failed"

	dodoc AUTHORS README TODO
}
