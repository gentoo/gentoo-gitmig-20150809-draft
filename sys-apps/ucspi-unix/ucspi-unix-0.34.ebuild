# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-unix/ucspi-unix-0.34.ebuild,v 1.5 2002/07/14 19:20:19 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A ucspi implementation for unix sockets."
SRC_URI="http://untroubled.org/ucspi-unix/${P}.tar.gz"

HOMEPAGE="http://untroubled.org"
KEYWORDS="x86"
SLOT="0"
LICENSE=""

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/bin
        doexe unixserver unixclient unixcat
}
