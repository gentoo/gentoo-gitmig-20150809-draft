# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dnotify/dnotify-0.5.0.ebuild,v 1.5 2002/08/14 04:40:34 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Execute a command when the contents of a directory change"
SRC_URI="http://www.student.lu.se/~nbi98oli/src/dnotify-0.5.0.tar.gz"
HOMEPAGE="http://www.student.lu.se/~nbi98oli/"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

src_unpack() {

        unpack ${A}
		cd ${S}
}

src_compile() {
	       ./configure --host=${CHOST} \
		                --prefix=/usr \
		                --mandir=/usr/share/man \
		                --sysconfdir=/etc \
		    make || die
}

src_install() {
			make prefix=${D}/usr \
            mandir=${D}/usr/share/man \
            install || die
	        dodoc AUTHORS ChangeLog COPYING* NEWS README 
}
