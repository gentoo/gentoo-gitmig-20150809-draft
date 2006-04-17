# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vls/vls-0.5.6-r2.ebuild,v 1.11 2006/04/17 15:59:30 flameeyes Exp $

inherit eutils

IUSE="debug dvd dvb"

DESCRIPTION="The VideoLAN server"
HOMEPAGE="http://www.videolan.org/vls/"
SRC_URI="http://www.videolan.org/pub/videolan/vls/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86"

DEPEND="dvd? ( >=media-libs/libdvdread-0.9.4
	>=media-libs/libdvdcss-1.2.8 )
	dvb? (
		>=media-libs/libdvb-0.5.0
		media-tv/linuxtv-dvb-headers
	)
	>=media-libs/libdvbpsi-0.1.3"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-gcc34.patch"
	epatch "${FILESDIR}/${P}-dvdread.patch"
}

src_compile() {
	local myconf
	use debug || myconf="--disable-debug"

	if use dvb; then
		export CCFLAGS="-I/usr/include/libdvb"
		export CPPFLAGS="${CPPFLAGS} -I/usr/include/libdvb"
		myconf="${myconf} --enable-dvb --with-libdvb=/usr/lib/"
	fi

	econf $(use_enable dvd) \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install () {
	einstall || die "einstall failed"

	dodoc AUTHORS README TODO
}
