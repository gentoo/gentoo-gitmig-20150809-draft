# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbcd/bbcd-0.3.1-r1.ebuild,v 1.1 2003/08/20 05:04:27 iggy Exp $

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

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${FILESDIR}/${P}_${PV}a.diff.gz
}

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
