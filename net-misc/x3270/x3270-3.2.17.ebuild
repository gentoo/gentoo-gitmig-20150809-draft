# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/x3270/x3270-3.2.17.ebuild,v 1.5 2002/08/14 12:08:08 murphy Exp $

S="${WORKDIR}/${PN}-3.2"
DESCRIPTION="Telnet 3270 client for X"
SRC_URI="http://x3270.bgp.nu/download/${PN}-3217.tgz"
HOMEPAGE="http://www.geocities.com/SiliconValley/Peaks/7814/"
DEPEND="virtual/x11"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL"
SLOT="0"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-x \
		--mandir=/usr/share/man || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	#make prefix=${D}/usr install || die
}
