# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ed/ed-0.2-r3.ebuild,v 1.9 2002/08/14 03:18:39 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Your basic line editor"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/ed/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/ed/"
KEYWORDS="x86 ppc sparc sparc64"
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
	make prefix=${D}/ \
		mandir=${D}/usr/share/man/man1 \
		infodir=${D}/usr/share/info \
		install || die
		
	if [ -z "`use bootcd`" ]
	then
		dodoc COPYING ChangeLog NEWS POSIX README THANKS TODO
	else
		rm -rf ${D}/usr/share
	fi
}
