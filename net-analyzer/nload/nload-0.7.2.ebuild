# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nload/nload-0.7.2.ebuild,v 1.1 2011/04/20 00:10:13 jer Exp $

EAPI="3"

inherit eutils

DESCRIPTION="console application which monitors network traffic and bandwidth usage in real time"
HOMEPAGE="http://www.roland-riegel.de/nload/index.html"
SRC_URI="mirror://sourceforge/nload/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"
RDEPEND="${DEPEND}"

src_configure() {
	# --enable-debug  do not strip debugging symbols (default no)
	econf --enable-debug
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
}
