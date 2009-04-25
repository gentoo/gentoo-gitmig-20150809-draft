# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libyahoo2/libyahoo2-0.7.7.ebuild,v 1.1 2009/04/25 11:33:28 patrick Exp $

DESCRIPTION="interface to the new Yahoo! Messenger protocol"
HOMEPAGE="http://libyahoo2.sourceforge.net/"
SRC_URI="mirror://sourceforge/libyahoo2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
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
