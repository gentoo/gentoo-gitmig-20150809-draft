# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linksys-tftp/linksys-tftp-1.2.1.ebuild,v 1.1 2004/03/18 07:30:14 dragonheart Exp $

DESCRIPTION="TFTP client suitable for uploading to the Linksys WRT54G Wireless Router"
HOMEPAGE="http://redsand.net/"
SRC_URI="http://redsand.net/code/linksys-tftp.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
DEPEND="sys-devel/gcc
	virtual/glibc"

RDEPEND="virtual/glibc"

S=${WORKDIR}/linksys-tftp

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin/
	doexe linksys-tftp || die
	dodoc README
}
