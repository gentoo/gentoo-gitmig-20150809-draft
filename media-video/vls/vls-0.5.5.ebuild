# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vls/vls-0.5.5.ebuild,v 1.1 2004/01/14 18:46:31 mholzer Exp $

IUSE="debug"

DESCRIPTION="The VideoLAN server"
HOMEPAGE="http://www.videolan.org/vls/"
SRC_URI="http://www.videolan.org/pub/videolan/vls/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND=">=media-libs/libdvdread-0.9.4
	>=media-libs/libdvdcss-1.2.8
	>=media-libs/libdvbpsi-0.1.3"

S=${WORKDIR}/${P}

src_compile() {
	local myconf
	use debug || myconf="--disable-debug"

	econf ${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install () {
	einstall || die "einstall failed"

	dodoc AUTHORS INSTALL README TODO
}
