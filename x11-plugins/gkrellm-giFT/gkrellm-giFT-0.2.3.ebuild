# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-giFT/gkrellm-giFT-0.2.3.ebuild,v 1.2 2004/09/03 00:57:05 dholm Exp $

MY_PN=${PN/FT/ft}
MY_P=${MY_PN}-${PV}
DESCRIPTION="GKrellM2 plugin to monitor giFT transfers"
SRC_URI="ftp://ftp.code-monkey.de/pub/${MY_PN}/${P}.tar.gz"
HOMEPAGE="http://code-monkey.de/?gkrellm-gift"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND=">=app-admin/gkrellm-2.1.23
	>=net-p2p/gift-0.11.3"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING FAQ README
}
