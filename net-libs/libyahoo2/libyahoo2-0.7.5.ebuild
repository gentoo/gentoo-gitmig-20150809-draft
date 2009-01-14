# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libyahoo2/libyahoo2-0.7.5.ebuild,v 1.3 2009/01/14 04:51:18 vapier Exp $

DESCRIPTION="interface to the new Yahoo! Messenger protocol"
HOMEPAGE="http://libyahoo2.sourceforge.net/"
SRC_URI="mirror://sourceforge/libyahoo2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:-ansi -pedantic::' configure #240912
}

src_install() {
	emake install DESTDIR="${D}" || die
	dobin src/yahoo || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
	dodoc doc/*.txt
	docinto sample
	dodoc src/sample_client.c src/sample_makefile
}
