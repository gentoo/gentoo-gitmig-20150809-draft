# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vls/vls-0.5.0.ebuild,v 1.2 2003/07/12 21:12:57 aliz Exp $


S=${WORKDIR}/${P}
DESCRIPTION="The VideoLAN server"
HOMEPAGE="http://www.videolan.org/vls/"
SRC_URI="http://www.videolan.org/pub/videolan/vls/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND=">=media-libs/libdvdread-0.9.3
	>=media-libs/libdvdcss-1.2.1
	>=media-libs/libdvbpsi-0.1.1"

src_compile() {

	econf \
		--disable-debug || die "econf failed"

	emake || die "emake failed"

}

src_install () {

	einstall || die "einstall failed"

	cd ${S}
	dodoc AUTHORS INSTALL README TODO

}
