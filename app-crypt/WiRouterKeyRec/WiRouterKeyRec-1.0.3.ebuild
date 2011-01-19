# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/WiRouterKeyRec/WiRouterKeyRec-1.0.3.ebuild,v 1.1 2011/01/19 12:48:57 c1pher Exp $

EAPI=2

inherit toolchain-funcs

MY_PN="WiRouter_KeyRec"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="Recovery tool for wpa passhprase"
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
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install () {
	newbin wirouterkeyrec ${PN} || die
	insinto /etc/${PN}
	doins "config/agpf_config.lst" || die
}
