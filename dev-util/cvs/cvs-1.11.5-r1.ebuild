# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs/cvs-1.11.5-r1.ebuild,v 1.5 2003/05/27 05:24:56 kumba Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Concurrent Versions System - source code revision control tools"
SRC_URI="http://www.cvshome.org/files/19/10/${P}.tar.bz2"
HOMEPAGE="http://www.cvshome.org/"
DEPEND="virtual/glibc 
	>=sys-libs/ncurses-5.1 
	>=sys-libs/zlib-1.1.4"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc sparc alpha hppa ~mips"

src_compile() {
	econf --with-tmpdir=/tmp || die
	make || die
}

src_install() {                               
	einstall || die
	insinto /etc/xinetd.d
	newins ${FILESDIR}/cvspserver.xinetd.d cvspserver

	dodoc BUGS COPYING* ChangeLog* DEVEL* FAQ HACKING 
	dodoc MINOR* NEWS PROJECTS README* TESTS TODO
	mv ${D}/usr/lib/cvs/contrib ${D}/usr/doc/${P}/contrib
	insinto /usr/share/emacs/site-lisp
	doins cvs-format.el
}
