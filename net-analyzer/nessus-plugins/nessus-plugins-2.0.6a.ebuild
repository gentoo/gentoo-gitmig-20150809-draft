# Copyright 2000-2002 Achim Gottinger
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-plugins/nessus-plugins-2.0.6a.ebuild,v 1.4 2003/09/11 23:31:27 msterret Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A remote security scanner for Linux (nessus-plugins)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"
DEPEND="=net-analyzer/nessus-core-${PV}-r1"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc -sparc alpha"

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
