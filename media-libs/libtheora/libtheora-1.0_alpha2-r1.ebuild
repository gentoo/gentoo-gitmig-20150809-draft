# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libtheora/libtheora-1.0_alpha2-r1.ebuild,v 1.1 2004/03/21 21:16:10 mholzer Exp $

DESCRIPTION="The Theora Video Compression Codec"
HOMEPAGE="http://www.theora.org/"
SRC_URI="http://www.theora.org/files/${P/_}.tar.gz
		http://download.videolan.org/pub/videolan/vlc/0.7.0/contrib/${P/_}.tar.gz"

LICENSE="xiph"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="media-libs/libsdl
	>=media-libs/libogg-1.1.0
	>=media-libs/libvorbis-1.0.1"

S=${WORKDIR}/${P/_}

src_compile() {
	econf --enable-shared || die

	cd ${S}/lib
	emake || die
}

src_install() {
	cd ${S}/lib
	make DESTDIR=${D} install || die

	cd ${S}/include
	make DESTDIR=${D} install || die

	cd ${S}
	dodoc README
}
