# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/streamtuner/streamtuner-0.10.1.ebuild,v 1.1 2003/09/28 13:29:37 jje Exp $

DESCRIPTION="Stream directory browser for browsing internetradio streams"
SRC_URI="http://savannah.nongnu.org/download/streamtuner/streamtuner.pkg/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"
KEYWORDS="~x86"
SLOT="0"
LICENSE="as-is"

DEPEND=">=x11-libs/gtk+-2.0.0
	>=net-ftp/curl-7.7.2"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} \
	sysconfdir=${D}/etc \
	install || die
	dodoc ChangeLog NEWS LICENCE INSTALL TODO
}
