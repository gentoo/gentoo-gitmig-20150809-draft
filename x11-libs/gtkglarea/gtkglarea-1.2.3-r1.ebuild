# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-1.2.3-r1.ebuild,v 1.18 2004/06/28 17:35:45 agriffis Exp $

DESCRIPTION="GL Extentions for gtk+"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.student.oulu.fi/~jlof/gtkglarea/"
# GTKGLArea has been abandoned by the author. We'll continue to mirror the
# source on Gentoo mirrors.

IUSE=""
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ia64 amd64 hppa"

DEPEND="virtual/libc
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
