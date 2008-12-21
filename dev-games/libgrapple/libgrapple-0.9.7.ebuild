# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libgrapple/libgrapple-0.9.7.ebuild,v 1.1 2008/12/21 01:37:25 nyhm Exp $

DESCRIPTION="A high level network layer for multiuser applications"
HOMEPAGE="http://grapple.linuxgamepublishing.com/"
SRC_URI="http://osfiles.linuxgamepublishing.com/${P}.tbz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CREDITS README* UPDATES
}
