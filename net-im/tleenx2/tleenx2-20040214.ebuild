# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tleenx2/tleenx2-20040214.ebuild,v 1.1 2004/04/17 19:07:56 spock Exp $

IUSE=""
LICENSE="GPL-2"

MY_P="TleenX2-${PV}"

DESCRIPTION="A client for Polish Tlen.pl instant messenging system."
HOMEPAGE="http://tleenx.sourceforge.net/"
SRC_URI="mirror://sourceforge/tleenx/${MY_P}.tar.gz"
SLOT="0"
KEYWORDS="~x86"
S="${WORKDIR}/${MY_P}"

DEPEND="net-libs/libtlen
	>=x11-libs/gtk+-2.0"

src_compile() {

	cd ${S}
	econf || die
	emake || die
}

src_install() {

	einstall
	cd ${S}
	dodoc doc/* AUTHORS BUGS TODO
}
