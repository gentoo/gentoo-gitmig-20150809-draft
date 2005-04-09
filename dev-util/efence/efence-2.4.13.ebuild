# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/efence/efence-2.4.13.ebuild,v 1.3 2005/04/09 02:09:48 ka0ttic Exp $

inherit eutils versionator toolchain-funcs

MY_P="${PN}_$(replace_all_version_separators '_')"
S="${WORKDIR}/${PN}"
DESCRIPTION="ElectricFence malloc() debugger"
HOMEPAGE="http://www.pf-lug.de/projekte/haya/efence.php"
SRC_URI="http://www.pf-lug.de/projekte/haya/${MY_P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	app-shells/bash"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	make prefix="${D}/usr" install || die "make install failed"
	insinto /usr/include
	doins efence.h efencepp.h efence_config.h \
		|| die "failed to install headers"
	dodoc CHANGES README
}
