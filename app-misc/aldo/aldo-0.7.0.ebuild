# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/aldo/aldo-0.7.0.ebuild,v 1.6 2007/09/09 14:34:51 coldwind Exp $

DESCRIPTION="a morse tutor"
HOMEPAGE="http://www.nongnu.org/aldo/"
SRC_URI="http://savannah.nongnu.org/download/aldo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="virtual/libc
	>=media-libs/libao-0.8.5"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README TODO AUTHORS ChangeLog NEWS THANKS
}
