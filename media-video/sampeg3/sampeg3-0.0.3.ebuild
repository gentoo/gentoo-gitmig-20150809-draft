# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/sampeg3/sampeg3-0.0.3.ebuild,v 1.1 2003/06/27 12:43:15 pylon Exp $

DESCRIPTION="MPEG video encoder targeted for optimum picture quality"
HOMEPAGE="http://rachmaninoff.informatik.uni-mannheim.de/sampeg/"
SRC_URI="http://rachmaninoff.informatik.uni-mannheim.de/sampeg/data/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="1.0"

KEYWORDS="~x86 ~ppc"

IUSE="mpeg"

DEPEND="virtual/glibc
		sys-libs/zlib
		>=media-libs/libvideogfx-1.0
		media-libs/libpng
		media-libs/jpeg
		x11-base/xfree"
RDEPEND=${DEPEND}

S=${WORKDIR}/${P}

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install() {

	make DESTDIR=${D} install || die


	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README TODO

}
