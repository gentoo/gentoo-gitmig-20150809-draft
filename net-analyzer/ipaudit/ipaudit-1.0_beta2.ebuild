# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ipaudit/ipaudit-1.0_beta2.ebuild,v 1.6 2007/06/17 11:12:33 armin76 Exp $

inherit eutils
DESCRIPTION="IPAudit monitors network activity on a network by host, protocol and port."
HOMEPAGE="http://ipaudit.sourceforge.net/"
MY_P="${PN}-${PV/_beta/BETA}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="mysql"
DEPEND="virtual/libpcap
		mysql? ( virtual/mysql )"
#RDEPEND=""
S="${WORKDIR}/${MY_P}"

src_compile() {
	econf `use_with mysql` || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README
}
