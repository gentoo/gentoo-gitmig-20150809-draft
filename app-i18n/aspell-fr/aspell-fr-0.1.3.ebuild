# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/aspell-fr/aspell-fr-0.1.3.ebuild,v 1.1 2002/07/13 02:17:35 seemant Exp $

MY_P=${P/.3/-3}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Aspell French Word List Package"
HOMEPAGE="http://aspell.sourceforge.net"
SRC_URI="http://aspell.sourceforge.net/${MY_P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86"

DEPEND="app-text/aspell"

src_compile() {
	./configure 
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README COPYING Copyright
}
