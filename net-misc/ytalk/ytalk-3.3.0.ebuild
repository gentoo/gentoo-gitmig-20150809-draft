# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ytalk/ytalk-3.3.0.ebuild,v 1.1 2005/02/25 20:33:24 carlo Exp $

DESCRIPTION="Multi-user replacement for UNIX talk"
HOMEPAGE="http://www.impul.se/ytalk/"
SRC_URI="http://www.impul.se/ytalk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64"
IUSE=""

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2"

src_compile() {
	econf || die "./configure failed"

	emake || die "Parallel Make Failed"
}

src_install() {
	einstall || die "Installation Failed"

	dodoc ChangeLog INSTALL README
}
