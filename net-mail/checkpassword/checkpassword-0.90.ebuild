# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/checkpassword/checkpassword-0.90.ebuild,v 1.4 2002/07/17 06:38:03 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A modern replacement for sendmail which uses maildirs"
SRC_URI="http://cr.yp.to/checkpwd/${P}.tar.gz"
HOMEPAGE="http://www.qmail.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"

src_compile() {
	cd ${S}
	echo "gcc ${CFLAGS}" > conf-cc
	make || die
}



src_install() {				 
	into /
	dobin checkpassword
	dodoc CHANGES README TODO VERSION
}
