# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/cscope/cscope-15.3.ebuild,v 1.7 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="CScope - interactively examine a C program"
SRC_URI="mirror://sourceforge/cscope/${P}.tar.gz"
HOMEPAGE="http://cscope.sourceforge.net"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

DEPEND="$RDEPEND
	sys-devel/flex"

src_compile() {                           

	./configure --prefix=/usr/					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info
	assert

	make clean || die
	emake || die
}

src_install() {                               
	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc NEWS AUTHORS TODO COPYING Changelog INSTALL README*
}
