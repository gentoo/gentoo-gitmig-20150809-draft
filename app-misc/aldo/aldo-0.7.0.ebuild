# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/aldo/aldo-0.7.0.ebuild,v 1.1 2005/12/22 18:58:31 vanquirius Exp $

DESCRIPTION="a morse tutor"
HOMEPAGE="http://savannah.nongnu.org/projects/aldo"
SRC_URI="http://savannah.nongnu.org/download/aldo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="virtual/libc
	sys-libs/libtermcap-compat"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README TODO AUTHORS ChangeLog NEWS THANKS
}

