# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-i18n/aspell-nl/aspell-nl-0.0.3.ebuild,v 1.1 2002/07/12 16:43:51 seemant Exp $

MY_P=${PN}-${PV/.3/-3}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dutch dictionary for aspell"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/nl-aspell/index.html"
SRC_URI="http://aspell.sourceforge.net/${MY_P}.tar.bz2"

DEPEND="app-text/aspell"
RDEPEND="app-text/aspell"

LICENSE="aspell-nl"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		install || die

	dodoc Copyright README doc/nl-spelling.txt
	dohtml doc/index.html
}
