# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-plugins/nessus-plugins-2.2.4.ebuild,v 1.2 2005/04/09 08:52:57 corsair Exp $

inherit toolchain-funcs

S=${WORKDIR}/${PN}
DESCRIPTION="A remote security scanner for Linux (nessus-plugins)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/nessus-plugins-GPL-${PV}.tar.gz"
DEPEND=">=net-analyzer/nessus-core-${PV}"
SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ppc64"

src_compile() {
	export CC=$(tc-getCC)
	econf || die
	emake || die
}

src_install() {
	emake \
		DESTDIR=${D} \
		install || die "make install failed"
	dodoc docs/*.txt plugins/accounts/accounts.txt
}

