# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/streamtuner/streamtuner-0.10.1.ebuild,v 1.4 2004/04/09 04:40:41 eradicator Exp $

DESCRIPTION="Stream directory browser for browsing internet radio streams"
HOMEPAGE="http://www.nongnu.org/streamtuner/"
SRC_URI="http://savannah.nongnu.org/download/streamtuner/streamtuner.pkg/${PV}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND=">=x11-libs/gtk+-2.0.0
	>=net-misc/curl-7.7.2"

src_install() {
	make DESTDIR=${D} \
		sysconfdir=${D}/etc \
		install || die
	dodoc ChangeLog NEWS INSTALL TODO
}
