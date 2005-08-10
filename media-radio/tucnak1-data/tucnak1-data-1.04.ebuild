# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/tucnak1-data/tucnak1-data-1.04.ebuild,v 1.1 2005/08/10 22:16:18 killsoft Exp $

DESCRIPTION="tucnak Contest Logbook, Data files"
HOMEPAGE="http://tucnak.nagano.cz/tucnak1en.html"
SRC_URI="http://tucnak.nagano.cz/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="virtual/libc"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
}
