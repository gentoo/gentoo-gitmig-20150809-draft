# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsup/cvsup-16.1e.ebuild,v 1.11 2003/09/06 08:39:20 msterret Exp $

DESCRIPTION="a faster alternative to cvs. binary version"
HOMEPAGE="http://people.freebsd.org/~jdp/s1g/"
SRC_URI="http://people.freebsd.org/~jdp/s1g/debian/${P}-LINUXLIBC6-gui.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 -ppc sparc"

S=${WORKDIR}

src_install() {
	exeinto /opt/cvsup
	doexe cvsup*

	dodoc License

	insinto /etc/env.d
	doins ${FILESDIR}/99cvsup
}
