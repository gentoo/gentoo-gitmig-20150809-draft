# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/minicom/minicom-2.00.0.ebuild,v 1.6 2003/02/05 22:17:53 gerk Exp $

DESCRIPTION="Serial Communication Program"
SRC_URI="http://www.netsonic.fi/~walker/${P}.src.tar.gz"
HOMEPAGE="http://www.netsonic.fi/~walker/minicom.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha"

DEPEND=">=sys-libs/ncurses-5.2-r3"

src_compile() {
	econf --sysconfdir=/etc/${PN} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc doc/minicom.FAQ
	insinto /etc/minicom
	doins ${FILESDIR}/minirc.dfl 
	
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

}
