# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nstx/nstx-1.1_beta6.ebuild,v 1.1 2005/06/08 19:49:03 robbat2 Exp $

inherit linux-info versionator

MY_PV=$(replace_version_separator 2 - "${PV}")
MY_P="${PN}-${MY_PV}"

CONFIG_CHECK="ETHERTAP"

DESCRIPTION="IP over DNS tunnel"
SRC_URI="http://dereference.de/nstx/${MY_P}.tgz"
HOMEPAGE="http://dereference.de/nstx/"
DEPEND="virtual/linux-sources"
RDEPEND=""
KEYWORDS="~x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
S="${WORKDIR}/${MY_P}"

src_compile() {
	emake || die
}

src_install() {
	into /usr
	dosbin nstxcd nstxd
	dodoc README Changelog
}

pkg_postinst() {
	einfo "Please read the documentation provided in"
	einfo "  /usr/share/doc/${PF}/README.gz"
}
