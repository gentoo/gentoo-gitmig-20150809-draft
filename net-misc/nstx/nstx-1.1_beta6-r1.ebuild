# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nstx/nstx-1.1_beta6-r1.ebuild,v 1.1 2005/07/21 03:06:47 robbat2 Exp $

inherit versionator toolchain-funcs

MY_PV=$(replace_version_separator 2 - "${PV}")
MY_P="${PN}-${MY_PV}"

DESCRIPTION="IP over DNS tunnel"
SRC_URI="http://dereference.de/nstx/${MY_P}.tgz"
HOMEPAGE="http://dereference.de/nstx/"
DEPEND="virtual/os-headers"
RDEPEND=""
KEYWORDS="~x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
S="${WORKDIR}/${MY_P}"

src_compile() {
	emake CC="$(tc-getCC)" || die
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
