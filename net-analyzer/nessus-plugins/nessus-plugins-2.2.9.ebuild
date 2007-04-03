# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-plugins/nessus-plugins-2.2.9.ebuild,v 1.1 2007/04/03 14:34:34 vanquirius Exp $

inherit toolchain-funcs

S="${WORKDIR}/${PN}"
DESCRIPTION="A remote security scanner for Linux (nessus-plugins)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/nessus-plugins-GPL-${PV}.tar.gz"
DEPEND=">=net-analyzer/nessus-core-${PV}"
SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

src_compile() {
	export CC="$(tc-getCC)"
	econf || die
	emake || die
}

src_install() {
	emake \
		DESTDIR="${D}" \
		install || die "make install failed"
	dodoc docs/*.txt plugins/accounts/accounts.txt
}

