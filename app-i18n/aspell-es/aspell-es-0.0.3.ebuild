# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/aspell-es/aspell-es-0.0.3.ebuild,v 1.3 2002/08/14 14:30:49 seemant Exp $

MY_P="aspell-es-0.0-3"
DESCRIPTION="The Spanish aspell dict"
HOMEPAGE="http://aspell.sourceforge.net"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="app-text/aspell"

SRC_URI="http://aspell.sourceforge.net/${MY_P}.tar.bz2"

S=${WORKDIR}/${MY_P}

src_compile() {
	./configure 
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
