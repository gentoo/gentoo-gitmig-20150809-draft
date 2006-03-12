# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gcdial/gcdial-0.7b.ebuild,v 1.7 2006/03/12 12:04:59 mrness Exp $

DESCRIPTION="A simple GTK+ client for DWUN"
HOMEPAGE="http://dwun.sourceforge.net/"
SRC_URI="mirror://sourceforge/dwun/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="${DEPEND}
	net-dialup/dwun"

src_compile() {
	econf || die "econf failed."
	emake || die "parallel make failed."
}

src_install() {
	einstall || die "install failed."
	dodoc AUTHORS ChangeLog README TODO
}
