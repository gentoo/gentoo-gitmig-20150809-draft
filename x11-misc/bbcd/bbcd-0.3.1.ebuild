# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Header

S=${WORKDIR}/${P}
DESCRIPTION="Basic CD Player for blackbox wm"
HOMEPAGE="http://tranber1.free.fr/bbcd.html"
SRC_URI="http://tranber1.free.fr/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/blackbox
		media-libs/libcdaudio"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make \
		DESTDIR=${D} \
		install || die
	rm -rf ${D}/usr/doc
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
