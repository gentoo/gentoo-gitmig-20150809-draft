# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dialup/minicom/minicom-2.00.0.ebuild,v 1.1 2002/09/02 15:36:05 phoenix Exp $

DESCRIPTION="Serial Communication Program"
SRC_URI="http://www.netsonic.fi/~walker/${P}.src.tar.gz"
HOMEPAGE="http://www.netsonic.fi/~walker/minicom.html"

DEPEND=">=sys-libs/ncurses-5.2-r3"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	unpack ${A}
	cd ${S}
	econf --sysconfdir=/etc/${PN} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc doc/minicom.FAQ
	insinto /etc/minicom
	doins ${FILESDIR}/minirc.dfl 
	
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

}
