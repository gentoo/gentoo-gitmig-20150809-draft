# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsup/cvsup-16.1e.ebuild,v 1.12 2004/01/09 22:23:59 weeve Exp $

DESCRIPTION="a faster alternative to cvs. binary version"
HOMEPAGE="http://people.freebsd.org/~jdp/s1g/"
SRC_URI="http://people.freebsd.org/~jdp/s1g/debian/${P}-LINUXLIBC6-gui.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 -ppc -sparc"

S=${WORKDIR}

src_install() {
	exeinto /opt/cvsup
	doexe cvsup*

	dodoc License

	insinto /etc/env.d
	doins ${FILESDIR}/99cvsup
}
