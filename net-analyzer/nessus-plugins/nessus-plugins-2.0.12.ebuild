# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-plugins/nessus-plugins-2.0.12.ebuild,v 1.2 2004/07/24 02:39:55 weeve Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A remote security scanner for Linux (nessus-plugins)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

DEPEND=">=net-analyzer/nessus-core-${PV}"
SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha ~amd64"

src_compile() {
	econf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		mandir=${D}/usr/share/man \
		install || die "make install failed"
	cd ${S}
	dodoc docs/*.txt plugins/accounts/accounts.txt
}
