# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/checkpassword/checkpassword-0.90-r1.ebuild,v 1.3 2003/05/14 03:51:16 robbat2 Exp $

inherit eutils

DESCRIPTION="A uniform password checking interface for root applications"
SRC_URI="http://cr.yp.to/checkpwd/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/checkpwd.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-errno.patch
}

src_compile() {
	echo "gcc ${CFLAGS}" > conf-cc
	make || die
}

src_install() {				 
	into /
	dobin checkpassword
	dodoc CHANGES README TODO VERSION FILES SYSDEPS TARGETS
}
