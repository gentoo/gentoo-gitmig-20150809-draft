# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netdate/netdate-1.2.ebuild,v 1.5 2005/01/07 03:57:58 robbat2 Exp $

DESCRIPTION="A Utility to synchronize the time with ntp-servers"
SRC_URI="mirror://gentoo/netdate-${PV}.tar.bz2"
SLOT="0"
LICENSE="public-domain"
KEYWORDS="~x86 ~sparc ~mips"
IUSE=""
DEPEND="virtual/libc"
S=${WORKDIR}/${PN}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dobin netdate
	doman netdate.8
	dodoc README COPYRIGHT
}
