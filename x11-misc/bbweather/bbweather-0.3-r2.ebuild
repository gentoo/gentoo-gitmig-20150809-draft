# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbweather/bbweather-0.3-r2.ebuild,v 1.1 2002/03/15 15:19:06 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="blackbox weather monitor"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.bz2"
HOMEPAGE="http://www.netmeister.org/apps/bbweather/index.html"

DEPEND="virtual/blackbox
        >=net-misc/wget-1.7
        >=sys-devel/perl-5.6.1"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	rm -rf ${D}/usr/share/doc
	dodoc README COPYING AUTHORS INSTALL ChangeLog NEWS TODO data/README.bbweather
	docinto html
	dodoc doc/*.html
}
