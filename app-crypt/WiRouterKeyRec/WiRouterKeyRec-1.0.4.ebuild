# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/WiRouterKeyRec/WiRouterKeyRec-1.0.4.ebuild,v 1.1 2011/04/22 12:56:39 c1pher Exp $

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
	sed -i 's/$(CFLAGS)\ -o\ $(EXEC)/$(CFLAGS)\ $(LDFLAGS)\ -o\ $(EXEC)/' Makefile || die
}

src_compile () {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install () {
	newbin wirouterkeyrec ${PN}
	insinto /etc/${PN}
	doins "config/agpf_config.lst"
}