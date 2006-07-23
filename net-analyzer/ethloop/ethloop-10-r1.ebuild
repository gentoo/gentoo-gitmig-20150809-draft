# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethloop/ethloop-10-r1.ebuild,v 1.2 2006/07/23 23:40:18 vanquirius Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Local simulator for testing Linux QoS disciplines"
HOMEPAGE="http://luxik.cdi.cz/~devik/qos/ethloop/"
SRC_URI="http://luxik.cdi.cz/~devik/qos/ethloop/ethloop10.tgz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""
DEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc4.diff
}

src_compile() {
	export CC="$(tc-getCC)"
	emake || die
}

src_install() {
	dosbin ${S}/ethloop
}
