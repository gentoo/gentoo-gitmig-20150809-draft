# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/asapm/asapm-2.11.ebuild,v 1.8 2002/10/05 05:39:27 drobbins Exp $

IUSE="jpeg"

S=${WORKDIR}/${P}
DESCRIPTION="APM monitor for AfterStep"
SRC_URI="http://www.tigr.net/afterstep/download/asapm/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net/afterstep/list.pl"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

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
