# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-1.2.3-r1.ebuild,v 1.14 2004/02/17 22:23:55 agriffis Exp $

DESCRIPTION="GL Extentions for gtk+"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.student.oulu.fi/~jlof/gtkglarea/"
# GTKGLArea has been abandoned by the author. We'll continue to mirror the
# source on Gentoo mirrors.

IUSE=""
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ia64"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
	virtual/glu
	virtual/opengl"


src_compile() {

	./configure --prefix=/usr \
		--host=${CHOST} || die

	make || die
}

src_install() {

	make DESTDIR=${D} \
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
	docinto txt
	dodoc docs/*.txt
}
