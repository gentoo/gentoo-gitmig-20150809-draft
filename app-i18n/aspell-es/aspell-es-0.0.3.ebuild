# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/aspell-es/aspell-es-0.0.3.ebuild,v 1.2 2002/07/13 16:30:25 stubear Exp $

MY_P="aspell-es-0.0-3"

DESCRIPTION="The Spanish aspell dict"

HOMEPAGE="http://aspell.sourceforge.net"

KEYWORDS="x86"

LICENSE="GPL"

DEPEND="aspell"
RDEPEND="${DEPEND}"
SLOT="0"

SRC_URI="http://aspell.sourceforge.net/${MY_P}.tar.bz2"

S=${WORKDIR}/${MY_P}

src_compile() {
	./configure 
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
