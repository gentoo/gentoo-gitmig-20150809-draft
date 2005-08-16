# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsmixer/wmsmixer-0.5.ebuild,v 1.12 2005/08/16 10:10:59 s4t4n Exp $

inherit eutils
IUSE=""
DESCRIPTION="fork of wmmixer adding scrollwheel support and other features"
HOMEPAGE="http://www.hibernaculum.net/wmsmixer/index.php"
SRC_URI="http://www.hibernaculum.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~sparc"

DEPEND="virtual/libc
	virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gcc3.diff
}

src_compile() {
	g++ -m32 ${CFLAGS} -I/usr/X11R6/include -c -o wmsmixer.o wmsmixer.cc
	rm -f wmsmixer
	g++ -o wmsmixer ${CFLAGS} -L/usr/X11R6/lib wmsmixer.o -lXpm -lXext -lX11
}

src_install() {
	insinto /usr/X11R6/bin
	insopts -m0655
	doins wmsmixer
	dodoc README README.wmmixer
}
