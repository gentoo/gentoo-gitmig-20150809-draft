# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-2.54_beta36.ebuild,v 1.3 2002/07/18 23:22:51 seemant Exp $

MY_P="${P/_beta/BETA}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Portscanner"
SRC_URI="http://www.insecure.org/nmap/dist/${MY_P}.tgz"
HOMEPAGE="http://www.insecure.org/nmap/"
DEPEND="virtual/glibc
	gtk? ( =x11-libs/gtk+-1.2* )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_compile() {

	econf --enable-ipv6	|| die

	use gtk && ( \
		make || die
	) || (
		make nmap || die
	)
}

src_install() {															 

	make	\
		prefix=${D}/usr 	\
	mandir=${D}/usr/share/man	\
	install

	dodoc CHANGELOG COPYING HACKING README*
	cd docs
	dodoc *.txt
	dohtml *.html
}
