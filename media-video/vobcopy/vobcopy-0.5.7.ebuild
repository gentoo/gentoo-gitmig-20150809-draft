# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vobcopy/vobcopy-0.5.7.ebuild,v 1.2 2003/04/16 20:02:16 mholzer Exp $

DESCRIPTION="copies DVD .vob files to harddisk, decrypting them on the way"
HOMEPAGE="http://lpn.rnbhq.org/"
SRC_URI="http://lpn.rnbhq.org/download/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=media-libs/libdvdread-0.9.3"

S=${WORKDIR}/${P}

src_compile() {
	emake CFLAGS=-DHAVE_GETOPT_LONG || die
}

src_install() {
	dodir /usr/bin
	make PREFIX=${D}/usr/ install || die
	dodoc Changelog README TODO Release-Notes 
}
