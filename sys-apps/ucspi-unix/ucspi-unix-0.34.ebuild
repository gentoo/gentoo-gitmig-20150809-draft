# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Maintainer: Thilo Bangert <bangert@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.3 2002/02/04 15:46:51 gbevin Exp

S=${WORKDIR}/${P}
DESCRIPTION="A ucspi implementation for unix sockets."
SRC_URI="ftp://untroubled.org/ucspi-unix/${P}.tar.gz"

HOMEPAGE="http://untroubled.org"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/bin
        doexe unixserver unixclient unixcat
}
