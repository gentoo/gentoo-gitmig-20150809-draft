# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tleenx2/tleenx2-20040106.ebuild,v 1.2 2004/04/25 17:17:05 spock Exp $

IUSE=""
LICENSE="GPL-2"

DESCRIPTION="A client for Polish Tlen.pl instant messenging system."
HOMEPAGE="http://tleenx.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~spock/portage/distfiles/tleenx2-20040106.tar.gz"
SLOT="0"
KEYWORDS="x86"
S="${WORKDIR}/${PN}"

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
