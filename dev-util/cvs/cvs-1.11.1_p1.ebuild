# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs/cvs-1.11.1_p1.ebuild,v 1.1 2002/03/16 10:09:50 blocke Exp $

# hopefully future upstream releases won't need such hardcoding
PVER="1.11.1p1"
PFTPDIR="cvs-1.11.1"

S=${WORKDIR}/cvs-${PVER}
DESCRIPTION="Concurrent Versions System - source code revision control tools"
SRC_URI="ftp://ftp.cvshome.org/pub/${PFTPDIR}/cvs-${PVER}.tar.gz"
HOMEPAGE="http://www.cvshome.org/"
DEPEND="virtual/glibc >=sys-libs/ncurses-5.1 >=sys-libs/zlib-1.1.4"

src_unpack() {

	unpack ${DISTFILES}/cvs-${PVER}.tar.gz

	# Redhat's external zlib patch
	cd ${S}/..
	patch -p0 < ${FILESDIR}/cvs-1.11.1p1-extzlib.patch

}

src_compile() {                           
	./configure --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info
	assert

	make || die
}

src_install() {                               
	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc BUGS COPYING* ChangeLog* DEVEL* FAQ HACKING 
	dodoc MINOR* NEWS PROJECTS README* TESTS TODO
	mv ${D}/usr/lib/cvs/contrib ${D}/usr/doc/${P}/contrib
	insinto /usr/share/emacs/site-lisp
	doins cvs-format.el
}
