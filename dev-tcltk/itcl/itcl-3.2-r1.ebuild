# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/itcl/itcl-3.2-r1.ebuild,v 1.1 2002/01/15 01:27:50 gbevin Exp $

S=${WORKDIR}/itcl${PV}
DESCRIPTION="Object Oriented Enhancements for Tcl/Tk"
SRC_URI="http://dev.scriptics.com/ftp/itcl/itcl${PV}.tar.gz"
HOMEPAGE="http://dev.scriptics.com/ftp/itcl/"

DEPEND=">=dev-lang/tk-8.4.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	try patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	make CFLAGS_DEFAULT="${CFLAGS}" || die
}

src_install () {
	make prefix=${D}/usr install || die

	rm ${D}/usr/lib/iwidgets
	ln -s iwidgets3.0.1 ${D}/usr/lib/iwidgets
	dodoc CHANGES INCOMPATIBLE README TODO
	cd ${S}/doc ; docinto doc
	dodoc README
}
