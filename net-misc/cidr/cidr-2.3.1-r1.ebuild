# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cidr/cidr-2.3.1-r1.ebuild,v 1.2 2003/09/05 22:01:48 msterret Exp $

TARBALL="cidr-current.tar.gz"
S=${WORKDIR}/${PN}-2.3
DESCRIPTION="command line util to assist in calculating subnets."
SRC_URI="http://home.netcom.com/~naym/cidr/${TARBALL}"
HOMEPAGE="http://home.netcom.com/~naym/cidr/"
DEPEND=""
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}.patch || die "patch failed"
}

src_compile() {
	emake || die "make failed"
}

src_install () {

	 dobin cidr
	 dodoc README ChangeLog
	 doman cidr.1
}

