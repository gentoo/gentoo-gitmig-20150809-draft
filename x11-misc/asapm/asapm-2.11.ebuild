# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/asapm/asapm-2.11.ebuild,v 1.1 2002/06/19 14:36:12 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="APM monitor for AfterStep"
SRC_URI="http://www.tigr.net/afterstep/download/asapm/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net/afterstep/list.pl"

DEPEND="virtual/x11
	jpeg? ( media-libs/jpeg )"

src_compile() {

	local myconf

	use jpeg	\
		&& myconf="${myconf} --enable-jpeg"	\
		|| myconf="${myconf} --disable-jpeg"

    ./configure 	\
		--infodir=/usr/share/info	\
		--mandir=/usr/share/man	\
		--prefix=/usr	\
		--host=${CHOST}	\
		${myconf} || die

    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff    
    emake || die
}

src_install () {
	
	dodir usr/bin
	dodir usr/share/man/man1
	
    make 	\
		AFTER_BIN_DIR=${D}/usr/bin	\
		AFTER_MAN_DIR=${D}/usr/share/man/man1	\
		install || die
}
