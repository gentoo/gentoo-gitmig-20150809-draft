# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglarea/gtkglarea-1.2.3-r1.ebuild,v 1.19 2004/11/08 19:31:15 vapier Exp $

# GTKGLArea has been abandoned by the author. We'll continue to mirror the
# source on Gentoo mirrors.
DESCRIPTION="GL Extentions for gtk+"
HOMEPAGE="http://www.student.oulu.fi/~jlof/gtkglarea/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 ppc sparc x86"
IUSE=""

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
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
	docinto txt
	dodoc docs/*.txt
}
