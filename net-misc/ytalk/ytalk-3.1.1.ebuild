# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ytalk/ytalk-3.1.1.ebuild,v 1.21 2005/01/04 04:47:58 seemant Exp $

DESCRIPTION="Multi-user replacement for UNIX talk"
HOMEPAGE="http://www.iagora.com/~espel/ytalk/ytalk.html"
SRC_URI="http://www.iagora.com/~espel/ytalk/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 sparc ppc alpha amd64"
IUSE="X"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2
	X? ( virtual/x11 )"

src_compile() {
	econf `use_with X x` || die "./configure failed"

	emake || die "Parallel Make Failed"
}

src_install() {
	einstall || die "Installation Failed"

	dodoc BUGS ChangeLog INSTALL README README.old
}
