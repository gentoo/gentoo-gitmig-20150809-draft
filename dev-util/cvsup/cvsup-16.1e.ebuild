# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsup/cvsup-16.1e.ebuild,v 1.7 2002/12/09 04:21:13 manson Exp $

S=${WORKDIR}
DESCRIPTION="a faster alternative to cvs. binary version"
SRC_URI="http://people.freebsd.org/~jdp/s1g/debian/${P}-LINUXLIBC6-gui.tar.gz"
HOMEPAGE="http://people.freebsd.org/~jdp/s1g/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 -ppc sparc "

src_install() {							   

	cd ${S}
	exeinto /opt/cvsup
	doexe cvsup*
	
	dodoc License
	
	insinto /etc/env.d
	doins $FILESDIR/99cvsup

}
