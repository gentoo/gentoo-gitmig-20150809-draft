# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ed/ed-0.2-r3.ebuild,v 1.16 2003/02/09 00:50:13 gmsoft Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Your basic line editor"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/ed/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/ed/"
KEYWORDS="x86 ppc sparc alpha hppa"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {  
	./configure --prefix=/ --host=${CHOST} || die
	emake || die
}

src_install() {                               
	chmod 0644 ${S}/ed.info
	make prefix=${D}/ \
		mandir=${D}/usr/share/man/man1 \
		infodir=${D}/usr/share/info \
		install || die
		
	dodoc COPYING ChangeLog NEWS POSIX README THANKS TODO
}
