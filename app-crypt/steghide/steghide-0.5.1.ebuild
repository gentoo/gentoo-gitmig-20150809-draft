# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/steghide/steghide-0.5.1.ebuild,v 1.2 2004/02/16 07:15:07 zhen Exp $

DESCRIPTION="A steganography program which hides data in various media files"
HOMEPAGE="http://steghide.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=app-crypt/mhash-0.8.18-r1
		>=dev-libs/libmcrypt-2.5.7
		>=media-libs/jpeg-6b-r3
		>=sys-libs/zlib-1.1.4-r2"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "installation failed"
}
