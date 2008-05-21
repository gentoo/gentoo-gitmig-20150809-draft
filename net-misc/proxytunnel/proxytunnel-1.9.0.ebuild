# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/proxytunnel/proxytunnel-1.9.0.ebuild,v 1.1 2008/05/21 20:35:54 jokey Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="program that connects stdin and stdout to a server somewhere on the network, through a standard HTTPS proxy"
HOMEPAGE="http://proxytunnel.sourceforge.net/"
SRC_URI="mirror://sourceforge/proxytunnel/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static"

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	use static && append-ldflags -static
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake install PREFIX=/usr DESTDIR="${D}" || die
	dodoc CHANGES CREDITS KNOWN_ISSUES README
}
