# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-giFT/gkrellm-giFT-0.2.1.ebuild,v 1.2 2004/01/04 18:36:47 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GKrellM2 plugin to monitor giFT transfers"
SRC_URI="http://www.code-monkey.de/data/gkrellm-giFT/${P}.tar.gz"
HOMEPAGE="http://www.code-monkey.de/gkrellm-gift.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=app-admin/gkrellm-2.1.15
	>=net-p2p/gift-0.11.3"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING FAQ README
}
