# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsup/cvsup-16.1e.ebuild,v 1.3 2002/07/23 10:38:07 seemant Exp $

S=${WORKDIR}
DESCRIPTION="a faster alternative to cvs. binary version"
SRC_URI="http://people.freebsd.org/~jdp/s1g/debian/${P}-LINUXLIBC6-gui.tar.gz"
HOMEPAGE="http://people.freebsd.org/~jdp/s1g/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"

src_install() {							   

	cd ${S}
	exeinto /opt/cvsup
	doexe cvsup*
	
	dodoc License
	
	insinto /etc/env.d
	doins $FILESDIR/99cvsup

}
