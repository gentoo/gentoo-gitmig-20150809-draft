# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-plugins/nessus-plugins-2.3.1.ebuild,v 1.3 2007/03/26 19:43:39 grobian Exp $

inherit toolchain-funcs

DESCRIPTION="A remote security scanner for Linux (nessus-plugins)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/experimental/nessus-${PV}/src/${PN}-GPL-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=net-analyzer/nessus-core-${PV}"

S="${WORKDIR}/${PN}"

src_compile() {
	export CC=$(tc-getCC)
	econf || die
	emake || die
}

src_install() {
	emake \
		DESTDIR=${D} \
		install || die "make install failed"
	dodoc docs/*.txt
}
