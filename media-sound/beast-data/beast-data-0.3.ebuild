# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beast-data/beast-data-0.3.ebuild,v 1.10 2004/08/03 11:32:57 dholm Exp $

DESCRIPTION="BEAST - the Bedevilled Sound Engine (datafiles)"
HOMEPAGE="http://beast.gtk.org"
LICENSE="GPL-2"

DEPEND=">=media-sound/beast-0.4.1"

SRC_URI="ftp://beast.gtk.org/pub/beast/v0.3/${P}.tar.gz"
KEYWORDS="~x86 ~ppc"

IUSE=""

SLOT="0"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
}
