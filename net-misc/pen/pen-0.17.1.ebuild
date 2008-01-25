# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pen/pen-0.17.1.ebuild,v 1.2 2008/01/25 21:33:51 armin76 Exp $

DESCRIPTION="TCP Load Balancing Port Forwarder"
HOMEPAGE="http://siag.nu/pen/"
SRC_URI="http://siag.nu/pub/pen/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="dev-libs/openssl"

src_install() {
	make DESTDIR="${D}" docdir=/usr/share/doc/${PF} install || die
}
