# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/ccsh/ccsh-0.0.4-r2.ebuild,v 1.3 2002/07/07 12:00:28 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="UNIX Shell for people already familiar with the C language"
SRC_URI="http://download.sourceforge.net/ccsh/${P}.tar.gz"
HOMEPAGE="http://ccsh.sourceforge.net"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	
	make CFLAGS="${CFLAGS}" all
}

src_install() {                               

	into /
	dobin ccsh
	into /usr
	newman ccsh.man ccsh.1
	dodoc ChangeLog COPYING README TODO

}





