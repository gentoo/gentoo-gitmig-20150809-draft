# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pth/pth-1.4.0.ebuild,v 1.2 2002/07/11 06:30:21 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Portable Threads"
SRC_URI="ftp://ftp.gnu.org/gnu/pth/pth-1.4.0.tar.gz"
HOMEPAGE="http://www.gnu.org/software/pth/"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info
	assert

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc ANNOUNCE AUTHORS COPYING ChangeLog NEWS README THANKS USERS
}







