# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmal/libmal-0.40.ebuild,v 1.1 2004/02/17 09:00:03 absinthe Exp $

IUSE=""

DESCRIPTION="libmal is a convenience library of the functions malsync distribution"
HOMEPAGE="http://jasonday.home.att.net/code/libmal/libmal.html"
SRC_URI="http://jasonday.home.att.net/code/libmal/${P}.tar.gz"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND="virtual/glibc \
		>=app-pda/pilot-link-0.11.7-r1"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL License.txt NEWS README
}
