# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/x70talk/x70talk-0.1.4.ebuild,v 1.1 2004/09/20 11:03:16 chrb Exp $

DESCRIPTION="Communicate and sync with Panasonic X70 mobile phone"
HOMEPAGE="http://x70talk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="bluez-libs"
S=${WORKDIR}/${PN}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dobin x70talk
	dodoc ChangeLog README TODO COPYING
}
