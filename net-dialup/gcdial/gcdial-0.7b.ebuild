# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gcdial/gcdial-0.7b.ebuild,v 1.3 2004/07/01 22:06:24 eradicator Exp $

DESCRIPTION="A simple GTK+ client for DWUN"
HOMEPAGE="http://dwun.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/dwun/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	=x11-libs/gtk+-1.2*"
RDEPEND="net-dialup/dwun"

src_compile() {

	econf || die "econf failed."
	emake || die "parallel make failed."

}

src_install() {

	einstall || die "install failed."
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO

}
