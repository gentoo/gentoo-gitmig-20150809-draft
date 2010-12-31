# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethloop/ethloop-10-r3.ebuild,v 1.2 2010/12/31 19:13:58 phajdan.jr Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Local simulator for testing Linux QoS disciplines"
HOMEPAGE="http://luxik.cdi.cz/~devik/qos/ethloop/"
SRC_URI="http://luxik.cdi.cz/~devik/qos/ethloop/ethloop10.tgz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc45.patch
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" || die
}

src_install() {
	dosbin ethloop
}
