# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Grant Goodyear <grant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/xsnap/xsnap-1.3.ebuild,v 1.2 2002/04/27 07:54:15 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Program to interactively take a 'snapshot' of a region of 
the screen"
SRC_URI="ftp://ftp.ac-grenoble.fr/ge/Xutils/${P}.tar.gz"
HOMEPAGE=""

DEPEND="virtual/x11"

src_compile() {

	xmkmf || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die
	make DESTDIR=${D} install.man || die
	dodoc README INSTALL AUTHORS

}
