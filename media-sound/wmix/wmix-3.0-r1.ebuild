# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jano (default3) <your email>
# $Header: /var/cvsroot/gentoo-x86/media-sound/wmix/wmix-3.0-r1.ebuild,v 1.1 2001/10/06 15:30:16 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Dockapp mixer for OSS or ALSA"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/software/${P}.tar.gz"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "/^CFLAGS/d" Makefile.orig > Makefile
}

src_compile() {

	try emake

}

src_install () {

	exeinto /usr/bin
	doexe wmix
	gzip -cd wmix.1x.gz > wmix.1
	doman wmix.1
	dodoc README COPYING INSTALL NEWS BUGS AUTHORS sample.wmixrc

}
