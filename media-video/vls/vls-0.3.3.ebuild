# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vls/vls-0.3.3.ebuild,v 1.2 2002/09/23 19:57:34 vapier Exp $

DESCRIPTION="The VideoLAN server"
HOMEPAGE="http://www.videolan.org/vls/"
SRC_URI="http://www.videolan.org/pub/videolan/vls/0.3.3/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND=">=media-libs/libdvdread-0.9.3
	>=media-libs/libdvdcss-1.2.1
	>=media-libs/libdvbpsi-0.1.1"
#RDEPEND=""

S=${WORKDIR}/${P}

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
