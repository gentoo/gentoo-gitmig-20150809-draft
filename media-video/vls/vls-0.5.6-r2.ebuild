# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vls/vls-0.5.6-r2.ebuild,v 1.3 2005/01/29 00:27:08 luckyduck Exp $

IUSE="debug dvd dvb"

DESCRIPTION="The VideoLAN server"
HOMEPAGE="http://www.videolan.org/vls/"
SRC_URI="http://www.videolan.org/pub/videolan/vls/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc -sparc ~alpha"

DEPEND="dvd? ( >=media-libs/libdvdread-0.9.4
	>=media-libs/libdvdcss-1.2.8 )
	dvb? ( >=media-libs/libdvb-0.5.0 )
	>=media-libs/libdvbpsi-0.1.3"

src_compile() {
	local myconf
	use debug || myconf="--disable-debug"

	use dvb && myconf="${myconf} --enable-dvb --with-libdvb=/usr/lib/"

	econf `use_enable dvd` \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install () {
	einstall || die "einstall failed"

	dodoc AUTHORS INSTALL README TODO
}
