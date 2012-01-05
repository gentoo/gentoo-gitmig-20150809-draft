# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/WiRouterKeyRec/WiRouterKeyRec-1.1.1.ebuild,v 1.1 2012/01/05 16:01:32 ago Exp $

EAPI=4

inherit toolchain-funcs

MY_PN="WiRouter_KeyRec"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="Recovery tool for wpa passphrase"
HOMEPAGE="http://www.salvatorefresta.net"
SRC_URI="http://tools.salvatorefresta.net/${MY_P}.zip -> ${P}.zip"

KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare () {
	sed -i "s:wirouterkeyrec:WiRouterKeyRec:" src/*.h || die
}

src_compile () {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}"
}

src_install () {
	newbin build/wirouterkeyrec ${PN}
	insinto /etc/${PN}
	doins \
		"config/agpf_config.lst" \
		"config/teletu_config.lst"
}
