# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/ccsh/ccsh-0.0.4-r1.ebuild,v 1.5 2000/11/01 04:44:12 achim Exp $

P=ccsh-0.0.4      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="UNIX Shell for people already familiar with the C language"
SRC_URI="http://download.sourceforge.net/ccsh/"${A}
HOMEPAGE="http://ccsh.sourceforge.net"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
	cd ${S}
	
	make CFLAGS="${CFLAGS}" all
}

src_install() {                               
	cd ${S}
	into /
	dobin ccsh
	into /usr
	newman ccsh.man ccsh.1
	dodoc ChangeLog COPYING README TODO
}





