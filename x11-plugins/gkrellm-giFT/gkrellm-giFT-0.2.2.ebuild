# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-giFT/gkrellm-giFT-0.2.2.ebuild,v 1.1 2004/03/25 02:43:55 pyrania Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GKrellM2 plugin to monitor giFT transfers"
SRC_URI="ftp://ftp.code-monkey.de/pub/gkrellm-gift/${P}.tar.gz"
HOMEPAGE="http://www.code-monkey.de/gkrellm-gift.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
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
