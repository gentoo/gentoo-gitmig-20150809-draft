# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/dial/dial-1.2.ebuild,v 1.5 2004/11/17 18:23:22 mrness Exp $

inherit eutils

DESCRIPTION="A simple client for DWUN"
HOMEPAGE="http://dwun.sourceforge.net/"
SRC_URI="mirror://sourceforge/dwun/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	net-dialup/dwun"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.3.patch

}

src_compile() {

	econf || die "econf failed."
	emake || die "parallel make failed."

}

src_install() {

	einstall || die "install failed."
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO

}
